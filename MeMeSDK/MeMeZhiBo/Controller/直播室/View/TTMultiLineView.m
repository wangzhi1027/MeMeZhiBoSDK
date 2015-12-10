//
//  TTMultiLineView.m
//  TTShow
//
//  Created by twb on 13-7-8.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import "TTMultiLineView.h"
#import "UIImageView+MMWebCache.h"

#define kChatTextHeightDefault         (24.0f)
#define kChatViewWidthMax              (kScreenWidth - self.padding * 2)
#define kChatViewWidthNest             (kScreenWidth - 100)

#define kChatViewWidthMaxRight              kScreenWidth - 140
#define kChatSplitSingleWordWidth      (15.0f)
#define kChatContentPaddingX            (10.0f)
#define kChatContentPaddingY           (3.0f)

// Parse.
#define kChatParseTextWidthKeyName     @"chat.parse.text.width"
#define kChatParseTextContentKeyName   @"chat.parse.text.content"
#define kChatParseTextCutPointKeyName  @"chat.parse.text.cutpoint"

@interface TTMultiLineView ()

@property (nonatomic, assign) CGFloat previousHeight;
@property (nonatomic, assign) CGFloat padding;

@end

@implementation TTMultiLineView

- (id)initWithSubViews:(NSMutableArray *)views
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        // Initialization code
        [self chatMultiLineView:views];
    }
    return self;
}
- (id)initWithSubViewsNest:(NSMutableArray *)views
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        // Initialization code
        [self chatMultiLineViewNest:views];
    }
    return self;
}

- (id)initWithSubViewsRight:(NSMutableArray *)views
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        // Initialization code
        [self chatMultiLineViewRight:views];
    }
    return self;
}

- (CGFloat)chatMultiLineViewNest:(NSMutableArray *)array
{
    CGFloat viewWidth = 0.0f;
    CGFloat viewHeightMax = 0.0f;
    CGFloat viewWidthMax = 0.0f;
    
    if (self.padding == 0.0f)
    {
        self.padding = kChatContentPaddingX;
    }
    
    for (NSDictionary *dict in array)
    {
        @autoreleasepool
        {
            switch ([self contentType:dict])
            {
                case kChatFriendText:
                    break;
                case kChatRoomText:
                {
                    NSString *contentText = [self chatContentText:dict];
                    CGFloat fontSize = 15;//[self chatContentTextFont:dict];
                    BOOL hasUnderLine = [self chatContentWithUnderLine:dict];
                    
                    if (contentText != nil && contentText.length > 0)
                    {
                        CGSize firstCharSize = [[contentText substringToIndex:1] sizeWithFont:kFontOfSize(fontSize) constrainedToSize:CGSizeMake(MAXFLOAT, kChatTextHeightDefault)];
                        
                        if (viewWidth + firstCharSize.width > kChatViewWidthNest)
                        {
                            // insert new line if last string reach end.
                            self.previousHeight += kChatTextHeightDefault;
                            viewWidth = 16.0f;
                        }
                    }
                    
                    NSArray *sectionStrs = [self splitStringNest:contentText start:viewWidth size:fontSize];
                    
                    // Multiline.
                    NSUInteger line = 0;
                    for (NSDictionary *d in sectionStrs)
                    {
                        @autoreleasepool
                        {
                            NSUInteger width = [[d valueForKey:kChatParseTextWidthKeyName] unsignedIntegerValue];
                            NSString *text = [d valueForKey:kChatParseTextContentKeyName];
                            
                            
                            //                            ChatRoomFontColorMode colorMode = [[dict valueForKey:kChatTextColorTypeKeyName] integerValue];
                            //                            UIColor *color = [self chatTextColor:colorMode];
                            UIColor *color = kRGBA(0, 0, 0 ,0.87);
                            
                            if (line != 0)
                            {
                                viewWidth = 16.0f;
                                if (line == 1)
                                {
                                    // First Line
                                    self.previousHeight += MAX(kChatTextHeightDefault, viewHeightMax);
                                    viewHeightMax = kChatTextHeightDefault;
                                }
                                else
                                {
                                    // > 1 line.
                                    self.previousHeight += kChatTextHeightDefault;
                                }
                            }
                            else
                            {
                                viewHeightMax = MAX(viewHeightMax, kChatTextHeightDefault);
                            }
                            
                            ChatLabel *l = [[ChatLabel alloc] initWithFrame:CGRectMake(viewWidth,
                                                                                       self.previousHeight,
                                                                                       width,
                                                                                       kChatTextHeightDefault)];
                            
                            viewWidthMax = viewWidthMax>width?viewWidthMax:width;
                            
                            l.hasUnderLine = hasUnderLine;
                            l.backgroundColor = [UIColor clearColor];
                            l.font = kFontOfSize(fontSize);
                            l.text = text;
                            l.textColor = color;
                            l.lineBreakMode = NSLineBreakByCharWrapping;
                            //                    l.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
                            [self addSubview:l];
                            
                            if (line == [sectionStrs count] - 1)
                            {
                                // Last Line, recode width.
                                viewWidth += width;
                                
                            }
                            viewWidthMax = viewWidthMax>viewWidth?viewWidthMax:viewWidth;
                            
                            line++;
                            
                        }
                    }
                }
                    break;
                case kChatRoomLocalStaticImage:
                case kChatRoomLocalDynamicImage:
                {
                    NSString *imageStr = [self chatImagePath:dict];
                    CGFloat imageWidth = [self chatImageWidth:dict];
                    CGFloat imageHeight = [self chatImageHeight:dict];
                    CGFloat imagePaddingX = [self chatImagePaddingX:dict];
                    CGFloat imagePaddingY = [self chatImagePaddingY:dict];
                    
                    
                    if (viewWidth + imageWidth > kChatViewWidthNest)
                    {
                        // new line
                        self.previousHeight += viewHeightMax;
                        
                        viewHeightMax = MAX(viewHeightMax, imageHeight);
                        viewWidth = 16.0f;
                    }
                    
                    UIImageView *imageView = [[UIImageView alloc] initWithFrame:
                                              CGRectMake(viewWidth + imagePaddingX,
                                                         self.previousHeight + imagePaddingY,
                                                         imageWidth,
                                                         imageHeight)];
                    imageView.image = [UIImage sd_animatedGIFNamed:imageStr];
                    
                    [self addSubview:imageView];
                    
                    
                    viewWidth += imageWidth;
                    viewWidth += imagePaddingX;
                    viewHeightMax = MAX(imageHeight, viewHeightMax);
                    viewWidthMax = viewWidthMax>viewWidth?viewWidthMax:viewWidth;
                }
                    break;
                case kChatRoomRemoteStaticImage:
                case kChatRoomRemoteDynamicImage:
                {
                    NSString *imageStr = [self chatImagePath:dict];
                    CGFloat imageWidth = [self chatImageWidth:dict];
                    CGFloat imageHeight = [self chatImageHeight:dict];
                    CGFloat imagePaddingX = [self chatImagePaddingX:dict];
                    CGFloat imagePaddingY = [self chatImagePaddingY:dict];
                    
                    //                LOGINFO(@"imageStr = %@", imageStr);
                    
                    if (viewWidth + imageWidth > kChatViewWidthNest)
                    {
                        // new line
                        self.previousHeight += viewHeightMax;
                        
                        viewHeightMax = MAX(viewHeightMax, imageHeight);
                        viewWidth = 16.0f;
                    }
                    
                    UIImageView *imageView = [[UIImageView alloc] initWithFrame:
                                              CGRectMake(viewWidth + imagePaddingX,
                                                         self.previousHeight + imagePaddingY,
                                                         imageWidth,
                                                         imageHeight)];
                    
                    [imageView sd_setImageWithURL:[NSURL URLWithString:imageStr] placeholderImage:nil];
                    [self addSubview:imageView];
                    
                    viewWidth += imageWidth;
                    viewWidth += imagePaddingX;
                    viewHeightMax = MAX(imageHeight, viewHeightMax);
                    viewWidthMax = viewWidthMax>viewWidth?viewWidthMax:viewWidth;
                }
                    break;
                    
                default:
                    break;
            }
        }
    }
    
    CGFloat totalHeight = self.previousHeight + viewHeightMax;
    if (totalHeight == 0.0f)
    {
        // Text Single Line;
        totalHeight = kChatTextHeightDefault;
    }
    self.frame = CGRectMake(self.padding+10.f, kChatContentPaddingY+15.f, viewWidthMax, totalHeight + kChatContentPaddingY * 2);
    
    return totalHeight;
}

- (NSArray *)splitStringNest:(NSString *)str start:(CGFloat)loc size:(CGFloat)fontSize
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSUInteger i = 1;
    NSUInteger location = 0;
    NSUInteger startPoint = 0;
    CGFloat startPaddingX = loc;
    
    while (i < str.length)
    {
        NSRange range = NSMakeRange(location, i - startPoint);
        
        NSString *str1 = [str substringWithRange:range];
        CGSize size = [str1 sizeWithFont:kFontOfSize(fontSize) constrainedToSize:CGSizeMake(MAXFLOAT, kChatTextHeightDefault)];
        CGFloat textWidth = size.width;
        
        if (textWidth + startPaddingX + kChatSplitSingleWordWidth > kChatViewWidthNest)
        {
            startPaddingX = 0.0f;
            location += str1.length;
            startPoint = i;
            
            NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
            [dictionary setValue:@(textWidth) forKey:kChatParseTextWidthKeyName];
            [dictionary setValue:str1 forKey:kChatParseTextContentKeyName];
            [dictionary setValue:@(i) forKey:kChatParseTextCutPointKeyName];
            [array addObject:dictionary];
        }
        
        i++;
    }
    
    // Last Section String.
    NSString *lastSectionStr = [str substringFromIndex:location];
    CGSize lastStrSize = [lastSectionStr sizeWithFont:kFontOfSize(fontSize) constrainedToSize:CGSizeMake(MAXFLOAT, kChatTextHeightDefault)];
    CGFloat lastStrWidth = lastStrSize.width;
    
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    [dictionary setValue:@(lastStrWidth) forKey:kChatParseTextWidthKeyName];
    [dictionary setValue:lastSectionStr forKey:kChatParseTextContentKeyName];
    [dictionary setValue:@(i) forKey:kChatParseTextCutPointKeyName];
    [array addObject:dictionary];
    
    return array;
}

- (CGFloat)chatMultiLineViewRight:(NSMutableArray *)array
{
    CGFloat viewWidth = 0.0f;
    CGFloat viewHeightMax = 0.0f;
    CGFloat viewWidthMax = 0.0f;
    
    if (self.padding == 0.0f)
    {
        self.padding = kChatContentPaddingX;
    }
    
    for (NSDictionary *dict in array)
    {
             @autoreleasepool
        {
            switch ([self contentType:dict])
            {
                case kChatFriendText:
                    break;
                case kChatRoomText:
                {
                    NSString *contentText = [self chatContentText:dict];
                    CGFloat fontSize = 15;//[self chatContentTextFont:dict];
                    BOOL hasUnderLine = [self chatContentWithUnderLine:dict];
                    
                    if (contentText != nil && contentText.length > 0)
                    {
                        
                        CGSize firstCharSize = [[contentText substringToIndex:1] sizeWithFont:kFontOfSize(fontSize) constrainedToSize:CGSizeMake(MAXFLOAT, kChatTextHeightDefault)];
                        
                        if (viewWidth + firstCharSize.width > kChatViewWidthMaxRight)
                        {
                            // insert new line if last string reach end.
                            self.previousHeight += kChatTextHeightDefault;
                            viewWidth = 0.0f;
                        }
                    }
                    
                    NSArray *sectionStrs = [self splitStringRight:contentText start:viewWidth size:fontSize];
                    
                    // Multiline.
                    NSUInteger line = 0;
                    for (NSDictionary *d in sectionStrs)
                    {
                        @autoreleasepool
                        {
                            NSUInteger width = [[d valueForKey:kChatParseTextWidthKeyName] unsignedIntegerValue];
                            NSString *text = [d valueForKey:kChatParseTextContentKeyName];
                            
                            ChatRoomFontColorMode colorMode = [[dict valueForKey:kChatTextColorTypeKeyName] integerValue];
                            UIColor *color = [self chatTextColor:colorMode];
                            
                            if (line != 0)
                            {
                                viewWidth = 0.0f;
                                if (line == 1)
                                {
                                    // First Line
                                    self.previousHeight += MAX(kChatTextHeightDefault, viewHeightMax);
                                    viewHeightMax = kChatTextHeightDefault;
                                }
                                else
                                {
                                    // > 1 line.
                                    self.previousHeight += kChatTextHeightDefault;
                                }
                            }
                            else
                            {
                                viewHeightMax = MAX(viewHeightMax, kChatTextHeightDefault);
                            }
                            
                            ChatLabel *l = [[ChatLabel alloc] initWithFrame:CGRectMake(viewWidth,
                                                                                       self.previousHeight,
                                                                                       width,
                                                                                       kChatTextHeightDefault)];
                            
                            viewWidthMax = viewWidthMax>width?viewWidthMax:width;
                            
                            l.hasUnderLine = hasUnderLine;
                            l.backgroundColor = [UIColor clearColor];
                            l.font = kFontOfSize(fontSize);
                            l.text = text;
                            l.textColor = color;
                            l.lineBreakMode = NSLineBreakByCharWrapping;
                            //                    l.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
                            [self addSubview:l];
                            
                            if (line == [sectionStrs count] - 1)
                            {
                                // Last Line, recode width.
                                viewWidth += width;
                                
                            }
                            viewWidthMax = viewWidthMax>viewWidth?viewWidthMax:viewWidth;
                            
                            line++;
                        }
                    }
                }
                    break;
                case kChatRoomLocalStaticImage:
                case kChatRoomLocalDynamicImage:
                {
                    NSString *imageStr = [self chatImagePath:dict];
                    CGFloat imageWidth = [self chatImageWidth:dict];
                    CGFloat imageHeight = [self chatImageHeight:dict];
                    CGFloat imagePaddingX = [self chatImagePaddingX:dict];
                    CGFloat imagePaddingY = [self chatImagePaddingY:dict];
                    
                    if (viewWidth + imageWidth > kChatViewWidthMaxRight)
                    {
                        // new line
                        self.previousHeight += viewHeightMax;
                        
                        viewHeightMax = MAX(viewHeightMax, imageHeight);
                        viewWidth = 0.0f;
                    }
                    
                    UIImageView *imageView = [[UIImageView alloc] initWithFrame:
                                              CGRectMake(viewWidth + imagePaddingX,
                                                         self.previousHeight + imagePaddingY,
                                                         imageWidth,
                                                         imageHeight)];
                    imageView.image = [UIImage sd_animatedGIFNamed:imageStr];
                    [self addSubview:imageView];
                    
                    
                    
                    viewWidth += imageWidth;
                    viewWidth += imagePaddingX;
                    viewHeightMax = MAX(imageHeight, viewHeightMax);
                    viewWidthMax = viewWidthMax>viewWidth?viewWidthMax:viewWidth;
                }
                    break;
                case kChatRoomRemoteStaticImage:
                case kChatRoomRemoteDynamicImage:
                {
                    NSString *imageStr = [self chatImagePath:dict];
                    CGFloat imageWidth = [self chatImageWidth:dict];
                    CGFloat imageHeight = [self chatImageHeight:dict];
                    CGFloat imagePaddingX = [self chatImagePaddingX:dict];
                    CGFloat imagePaddingY = [self chatImagePaddingY:dict];
                    
                    //                LOGINFO(@"imageStr = %@", imageStr);
                    
                    if (viewWidth + imageWidth > kChatViewWidthMaxRight)
                    {
                        // new line
                        self.previousHeight += viewHeightMax;
                        
                        viewHeightMax = MAX(viewHeightMax, imageHeight);
                        viewWidth = 0.0f;
                    }
                    
                    UIImageView *imageView = [[UIImageView alloc] initWithFrame:
                                              CGRectMake(viewWidth + imagePaddingX,
                                                         self.previousHeight + imagePaddingY,
                                                         imageWidth,
                                                         imageHeight)];
                    //                    [imageView setImageWithURL:[NSURL URLWithString:imageStr] placeholderImage:nil options:SDWebImageRefreshCached];
                    [imageView sd_setImageWithURL:[NSURL URLWithString:imageStr] placeholderImage:nil];
                    [self addSubview:imageView];
                    
                    viewWidth += imageWidth;
                    viewWidth += imagePaddingX;
                    viewHeightMax = MAX(imageHeight, viewHeightMax);
                    viewWidthMax = viewWidthMax>viewWidth?viewWidthMax:viewWidth;
                }
                    break;
                    
                default:
                    break;
            }
        }
    }
    
    CGFloat totalHeight = self.previousHeight + viewHeightMax;
    if (totalHeight == 0.0f)
    {
        // Text Single Line;
        totalHeight = kChatTextHeightDefault;
    }
    self.frame = CGRectMake(self.padding+10.f, kChatContentPaddingY+15.f, viewWidthMax, totalHeight + kChatContentPaddingY * 2);
    
    return totalHeight;
}

- (CGFloat)chatMultiLineView:(NSMutableArray *)array
{
    CGFloat viewWidth = 0.0f;
    CGFloat viewHeightMax = 0.0f;
    
    if (self.padding == 0.0f)
    {
        self.padding = kChatContentPaddingX;
    }
    
    for (NSDictionary *dict in array)
    {
        @autoreleasepool
        {
            switch ([self contentType:dict])
            {
                case kChatFriendText:
                                 break;
                case kChatRoomText:
                {
                    NSString *contentText = [self chatContentText:dict];
                    CGFloat fontSize = [self chatContentTextFont:dict];
                    BOOL hasUnderLine = [self chatContentWithUnderLine:dict];
                    
                    if (contentText != nil && contentText.length > 0)
                    {
                        CGSize firstCharSize = [[contentText substringToIndex:1] sizeWithFont:kFontOfSize(fontSize) constrainedToSize:CGSizeMake(MAXFLOAT, kChatTextHeightDefault)];
                        
                        if (viewWidth + firstCharSize.width > kChatViewWidthMax)
                        {
                            // insert new line if last string reach end.
                            self.previousHeight += kChatTextHeightDefault;
                            viewWidth = 0.0f;
                        }
                    }
                    
                    NSArray *sectionStrs = [self splitString:contentText start:viewWidth size:fontSize];
                    
                    // Multiline.
                    NSUInteger line = 0;
                    for (NSDictionary *d in sectionStrs)
                    {
                        @autoreleasepool
                        {
                            NSUInteger width = [[d valueForKey:kChatParseTextWidthKeyName] unsignedIntegerValue];
                            NSString *text = [d valueForKey:kChatParseTextContentKeyName];
                            
                            ChatRoomFontColorMode colorMode = [[dict valueForKey:kChatTextColorTypeKeyName] integerValue];
                            UIColor *color = [self chatTextColor:colorMode];
                            
                            if (line != 0)
                            {
                                viewWidth = 0.0f;
                                if (line == 1)
                                {
                                    // First Line
                                    self.previousHeight += MAX(kChatTextHeightDefault, viewHeightMax);
                                    viewHeightMax = kChatTextHeightDefault;
                                }
                                else
                                {
                                    // > 1 line.
                                    self.previousHeight += kChatTextHeightDefault;
                                }
                            }
                            else
                            {
                                viewHeightMax = MAX(viewHeightMax, kChatTextHeightDefault);
                            }
                            
                            ChatLabel *l = [[ChatLabel alloc] initWithFrame:CGRectMake(viewWidth,
                                                                                       self.previousHeight,
                                                                                       width,
                                                                                       kChatTextHeightDefault)];
                            l.hasUnderLine = hasUnderLine;
                            l.backgroundColor = [UIColor clearColor];
                            
                            
                            l.font = kFontOfSize(fontSize);
                            l.text = text;
                            l.textColor = color;
                            l.lineBreakMode = NSLineBreakByCharWrapping;
                            //                    l.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
                            
                            
                            if (line == [sectionStrs count] - 1)
                            {
                                // Last Line, recode width.
                                viewWidth += width;
                            }
                            
                            if ([dict valueForKey:@"nike_oNo"]) {
                                l.frame = CGRectMake(viewWidth,
                                                     self.previousHeight,
                                                     kScreenWidth-viewWidth,
                                                     kChatTextHeightDefault);
                                viewWidth = kScreenWidth;
                            }
                            
                            if ([dict valueForKey:@"max"]) {
                                
                                if (!self.bgView) {
                                    self.bgView = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth/2-[[dict valueForKey:@"max"] integerValue]/2-kChatContentPaddingX, self.previousHeight, [[dict valueForKey:@"max"] integerValue], kChatTextHeightDefault)];
                                    [self addSubview:self.bgView];
                                    self.bgView.layer.masksToBounds = YES;

                                    self.bgView.layer.cornerRadius = 4;
                                }
                                viewWidth = l.frame.origin.x+width;
                            }
                            if ([dict valueForKey:@"commonWordEnter"]) {
                                self.bgView.backgroundColor = kRGB(236.0f, 236.0f, 236.0f);
                                [self.bgView addSubview:l];
                            }else{
                                [self addSubview:l];
                            }
                            line++;
                        }
                    }
                }
                    break;
                case kChatRoomLocalStaticImage:
                case kChatRoomLocalDynamicImage:
                {
                    NSString *imageStr = [self chatImagePath:dict];
                    CGFloat imageWidth = [self chatImageWidth:dict];
                    CGFloat imageHeight = [self chatImageHeight:dict];
                    CGFloat imagePaddingX = [self chatImagePaddingX:dict];
                    CGFloat imagePaddingY = [self chatImagePaddingY:dict];
                    
                    if (viewWidth + imageWidth > kChatViewWidthMax)
                    {
                        // new line
                        self.previousHeight += viewHeightMax;
                        
                        viewHeightMax = MAX(viewHeightMax, imageHeight);
                        viewWidth = 0.0f;
                    }
                    
                    UIImageView *imageView = [[UIImageView alloc] initWithFrame:
                                              CGRectMake(viewWidth + imagePaddingX,
                                                         self.previousHeight + imagePaddingY,
                                                         imageWidth,
                                                         imageHeight)];
                                        
                    imageView.image = [UIImage sd_animatedGIFNamed:imageStr];
                    
                    [self addSubview:imageView];
                    
                    
                    
                    
                    
                    viewWidth += imageWidth;
                    viewWidth += imagePaddingX;
                    viewHeightMax = MAX(imageHeight, viewHeightMax);
                    

                }
                    break;
                case kChatRoomRemoteStaticImage:
                case kChatRoomRemoteDynamicImage:
                {
                    NSString *imageStr = [self chatImagePath:dict];
                    CGFloat imageWidth = [self chatImageWidth:dict];
                    CGFloat imageHeight = [self chatImageHeight:dict];
                    CGFloat imagePaddingX = [self chatImagePaddingX:dict];
                    CGFloat imagePaddingY = [self chatImagePaddingY:dict];
                    
                    //                LOGINFO(@"imageStr = %@", imageStr);
                    
                    if (viewWidth + imageWidth > kChatViewWidthMax)
                    {
                        // new line
                        self.previousHeight += viewHeightMax;
                        
                        viewHeightMax = MAX(viewHeightMax, imageHeight);
                        viewWidth = 0.0f;
                    }
                    
                    UIImageView *imageView = [[UIImageView alloc] initWithFrame:
                                              CGRectMake(viewWidth + imagePaddingX,
                                                         self.previousHeight + imagePaddingY,
                                                         imageWidth,
                                                         imageHeight)];
                    [imageView sd_setImageWithURL:[NSURL URLWithString:imageStr] placeholderImage:nil];
                    
                    if ([dict objectForKey:@"car"]) {
                        [self.bgView addSubview:imageView];
                    }else{
                    
                        [self addSubview:imageView];
                    }
                    
                    viewWidth += imageWidth;
                    viewWidth += imagePaddingX;
                    viewHeightMax = MAX(imageHeight, viewHeightMax);
                    

                    
                }
                    break;
                    
                default:
                    break;
            }
        }
    }
    
    CGFloat totalHeight = self.previousHeight + viewHeightMax;
    if (totalHeight == 0.0f)
    {
        // Text Single Line;
        totalHeight = kChatTextHeightDefault;
    }
    self.frame = CGRectMake(self.padding, kChatContentPaddingY, kChatViewWidthMax, totalHeight + kChatContentPaddingY * 2);
    
    return totalHeight;
}

- (NSArray *)splitString:(NSString *)str start:(CGFloat)loc size:(CGFloat)fontSize
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSUInteger i = 1;
    NSUInteger location = 0;
    NSUInteger startPoint = 0;
    CGFloat startPaddingX = loc;
    
    while (i < str.length)
    {
        NSRange range = NSMakeRange(location, i - startPoint);
        
        NSString *str1 = [str substringWithRange:range];
        CGSize size = [str1 sizeWithFont:kFontOfSize(fontSize) constrainedToSize:CGSizeMake(MAXFLOAT, kChatTextHeightDefault)];
        CGFloat textWidth = size.width;
        
        if (textWidth + startPaddingX + kChatSplitSingleWordWidth > kChatViewWidthMax)
        {
            startPaddingX = 0.0f;
            location += str1.length;
            startPoint = i;
            
            NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
            [dictionary setValue:@(textWidth) forKey:kChatParseTextWidthKeyName];
            [dictionary setValue:str1 forKey:kChatParseTextContentKeyName];
            [dictionary setValue:@(i) forKey:kChatParseTextCutPointKeyName];
            [array addObject:dictionary];
        }
        
        i++;
    }
    
    // Last Section String.
    NSString *lastSectionStr = [str substringFromIndex:location];
    CGSize lastStrSize = [lastSectionStr sizeWithFont:kFontOfSize(fontSize) constrainedToSize:CGSizeMake(MAXFLOAT, kChatTextHeightDefault)];
    CGFloat lastStrWidth = lastStrSize.width;
    
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    [dictionary setValue:@(lastStrWidth) forKey:kChatParseTextWidthKeyName];
    [dictionary setValue:lastSectionStr forKey:kChatParseTextContentKeyName];
    [dictionary setValue:@(i) forKey:kChatParseTextCutPointKeyName];
    [array addObject:dictionary];
    
    return array;
}

- (NSArray *)splitStringRight:(NSString *)str start:(CGFloat)loc size:(CGFloat)fontSize
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSUInteger i = 1;
    NSUInteger location = 0;
    NSUInteger startPoint = 0;
    CGFloat startPaddingX = loc;
    
    while (i < str.length)
    {
        NSRange range = NSMakeRange(location, i - startPoint);
        
        NSString *str1 = [str substringWithRange:range];
        CGSize size = [str1 sizeWithFont:kFontOfSize(fontSize) constrainedToSize:CGSizeMake(MAXFLOAT, kChatTextHeightDefault)];
        CGFloat textWidth = size.width;
        
        if (textWidth + startPaddingX + kChatSplitSingleWordWidth > kChatViewWidthMaxRight)
        {
            startPaddingX = 0.0f;
            location += str1.length;
            startPoint = i;
            
            NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
            [dictionary setValue:@(textWidth) forKey:kChatParseTextWidthKeyName];
            [dictionary setValue:str1 forKey:kChatParseTextContentKeyName];
            [dictionary setValue:@(i) forKey:kChatParseTextCutPointKeyName];
            [array addObject:dictionary];
        }
        
        i++;
    }
    
    // Last Section String.
    NSString *lastSectionStr = [str substringFromIndex:location];
    CGSize lastStrSize = [lastSectionStr sizeWithFont:kFontOfSize(fontSize) constrainedToSize:CGSizeMake(MAXFLOAT, kChatTextHeightDefault)];
    CGFloat lastStrWidth = lastStrSize.width;
    
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    [dictionary setValue:@(lastStrWidth) forKey:kChatParseTextWidthKeyName];
    [dictionary setValue:lastSectionStr forKey:kChatParseTextContentKeyName];
    [dictionary setValue:@(i) forKey:kChatParseTextCutPointKeyName];
    [array addObject:dictionary];
    
    return array;
}


#pragma mark - Life cycle.

- (void)dealloc
{
    for (UIView *v in self.subviews)
    {
        @autoreleasepool
        {
            if ([v isKindOfClass:[UIImageView class]])
            {
                [(UIImageView *)v setImage:nil];
            }
            
            [v removeFromSuperview];
        }
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
