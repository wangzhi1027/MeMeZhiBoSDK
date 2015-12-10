//
//  TTSingleLineView.m
//  TTShow
//
//  Created by twb on 13-7-8.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import "TTSingleLineView.h"

#define kChatRoomSingleLineDefaultHeight (30.0f)

@implementation TTSingleLineView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithSubViews:(NSMutableArray *)views
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        // Initialization code
        [self chatRoomSingleLineView:views];
    }
    return self;
}

- (CGFloat)chatRoomSingleLineView:(NSMutableArray *)array
{
    CGFloat lineWidth = 0.0f;
    for (NSDictionary *dict in array)
    {
        switch ([self contentType:dict])
        {
            case kChatRoomText:
            {
                NSString *contentText = [self chatContentText:dict];
                CGFloat fontSize = [self chatContentTextFont:dict];
                CGFloat textWidth = [self getStringWidth:contentText size:fontSize];
                ChatRoomFontColorMode colorMode = [[dict valueForKey:kChatTextColorTypeKeyName] integerValue];
                UIColor *color = [self chatTextColor:colorMode];
                
                UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(lineWidth,
                                                                       0.0f,
                                                                       textWidth,
                                                                       kChatRoomSingleLineDefaultHeight)];
                l.backgroundColor = [UIColor clearColor];
                l.font = kFontOfSize(fontSize);
                l.text = contentText;
                l.textColor = color;
                l.lineBreakMode = NSLineBreakByCharWrapping;
                [self addSubview:l];
                
                lineWidth += textWidth;
            }
                break;
            case kChatRoomRemoteDynamicImage:
            case kChatRoomRemoteStaticImage:
            {
                NSString *imageStr = [self chatImagePath:dict];
                CGFloat imageWidth = [self chatImageWidth:dict];
                CGFloat imageHeight = [self chatImageHeight:dict];
                CGFloat imagePaddingX = [self chatImagePaddingX:dict];
                CGFloat imagePaddingY = [self chatImagePaddingY:dict];
                
                UIImageView *imageView = [[UIImageView alloc] initWithFrame:
                                          CGRectMake(lineWidth + imagePaddingX,
                                                     0.0f + imagePaddingY,
                                                     imageWidth,
                                                     imageHeight)];
                [imageView sd_setImageWithURL:[NSURL URLWithString:imageStr] placeholderImage:nil];
                [self addSubview:imageView];
                
                lineWidth += imageWidth;
                lineWidth += imagePaddingX;
            }
                break;
            case kChatRoomLocalDynamicImage:
            case kChatRoomLocalStaticImage:
            {
                NSString *imageStr = [self chatImagePath:dict];
                CGFloat imageWidth = [self chatImageWidth:dict];
                CGFloat imageHeight = [self chatImageHeight:dict];
                CGFloat imagePaddingX = [self chatImagePaddingX:dict];
                CGFloat imagePaddingY = [self chatImagePaddingY:dict];
                               
                UIImageView *imageView = [[UIImageView alloc] initWithFrame:
                                          CGRectMake(lineWidth + imagePaddingX,
                                                     0.0f + imagePaddingY,
                                                     imageWidth,
                                                     imageHeight)];
                imageView.image = [UIImage sd_animatedGIFNamed:imageStr];
                
                [self addSubview:imageView];
                
                lineWidth += imageWidth;
                lineWidth += imagePaddingX;
            }
                break;
                
            default:
                break;
        }
    }

    self.frame = CGRectMake(0.0f, 0.0f, lineWidth, kChatRoomSingleLineDefaultHeight);
    
    return kChatRoomSingleLineDefaultHeight;
}

- (CGFloat)getStringWidth:(NSString *)text size:(CGFloat)fontSize
{
    CGSize size = [text sizeWithFont:kFontOfSize(fontSize) constrainedToSize:CGSizeMake(MAXFLOAT, kChatRoomSingleLineDefaultHeight)];
    return size.width;
}

#pragma mark - Life Cycle.

- (void)dealloc
{
//    LOGINFO(@"release sv...");
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
