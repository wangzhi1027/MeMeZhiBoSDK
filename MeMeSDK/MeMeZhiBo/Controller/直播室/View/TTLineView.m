//
//  TTLineView.m
//  TTShow
//
//  Created by twb on 13-7-8.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import "TTLineView.h"

@implementation TTLineView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (UIColor *)chatTextColor:(ChatRoomFontColorMode)mode
{
    UIColor *color = nil;
    
    switch (mode)
    {
        case kEnterNickNameColor:
            color = kLightGrayColor;
            break;
        case kFromNickNameColor:
            color = kLightGrayColor;
            break;
        case kToNickNameColor:
            color = kRGB(27.0f, 131.0f, 251.0f);
            break;
        case kToColor:
            color = kLightGrayColor;
            break;
        case kToSayColor:
            color = kRGB(27.0f, 131.0f, 251.0f);
            break;
        case kContentColor:
            color = kBlackColor;
            break;
        case kEnterRoomColor:
            color = kLightGrayColor;
            break;
        case kSystemNotifyColor:
            color = kGreenColor;
            break;
        case kStopSuffer:
            color = kRGB(0.0f, 150.0f, 0.0f);
            break;
        case kStopFrom:
        case kStopTo:
            color = kRGB(255.0f, 20.0f, 147.0f);
            break;
        case kStopContent:
            color = kRGB(0.0f, 150.0f, 0.0f);
            break;
        case kSendGiftFrom:
        case kSendFeatherFrom:
            color = kOrangeColor;
            break;
        case kSendFeatherFrom1:
            color = kRGBA(255.0f, 160.0f, 0.0f, 0.6f);
        case kSendGiftTo:
        case kSendFeatherTo:
            color = kOrangeColor;
            break;
        case kSend:
        case kSendGiftCount:
        case kSendFeatherCount:
            color = kLightGrayColor;
            break;
        case kSystemNoticeTip:
        case kSystemNoticeContent:
            color = kRGB(0.0f, 150.0f, 0.0f);
            break;
        case kSendGiftMarqueeFrom:
        case kSendGiftMarqueeTo:
            color = kRGB(255.0f, 20.0f, 147.0f);
            break;
        case kSendGiftmarquee:
            color = kLightGrayColor;
            break;
        case kSendGiftMarqueeContent:
            color = kWhiteColor;
            break;
        case kDefaultAnnounceColor:
            color = kRedColor;
            break;
        case kDefaultChargeColor:
            color = kOrangeColor;
            break;
        case kFullScreenGiftNameColor:
            color = kRGB(255.0f, 20.0f, 147.0f);
            break;
        case kBroadcastPublishTimeColor:
            color = kLightGrayColor;
            break;
        case kBroadcastContentColor:
            color = kDarkGrayColor;
            break;
        case kBroadcastSubmitterColor:
            color = kRedColor;
            break;
        case kPuzzleContentColor:
            color = kRGB(0.0f, 150.0f, 0.0f);
            break;
        case kPuzzleTipColor:
            color = kRGB(255.0f, 20.0f, 147.0f);
            break;
        case kZColor:
            color = kRGB(180, 64, 195);
            break;
        case kZColor1:
            color = kRGBA(180, 64, 195 ,0.6);
            break;
        case kJcNameColor:
            color = kRGBA(0, 0, 0, 0.6);
            break;
        default:
            color = kBlackColor;
            break;
    }
    return color;
}

- (ChatRoomContentType)contentType:(NSDictionary *)dict
{
    NSNumber *chatTypeNumber = [dict valueForKey:kChatTypeKeyName];
    return [chatTypeNumber unsignedIntegerValue];
}

- (NSString *)chatContentText:(NSDictionary *)dict
{
    return [dict valueForKey:kChatTextKeyName];
}

- (CGFloat)chatContentTextFont:(NSDictionary *)dict
{
    NSNumber *fontsizeNumber = [dict valueForKey:kChatTextFontSizeKeyName];
    return [fontsizeNumber floatValue];
}

- (BOOL)chatContentWithUnderLine:(NSDictionary *)dict
{
    NSNumber *underlineNumber = [dict valueForKey:kChatTextHasUnderLineKeyName];
    return [underlineNumber boolValue];
}

- (ChatRoomFontColorMode)chatContentTextColor:(NSDictionary *)dict
{
    NSNumber *colorNumber = [dict valueForKey:kChatTextColorTypeKeyName];
    return [colorNumber unsignedIntegerValue];
}

- (CGFloat)chatImageWidth:(NSDictionary *)dict
{
    NSNumber *imgewidthNumber = [dict valueForKey:kChatImageWidthKeyName];
    return [imgewidthNumber floatValue];
}

- (CGFloat)chatImageHeight:(NSDictionary *)dict
{
    NSNumber *imageheightNumber = [dict valueForKey:kChatImageHeightKeyName];
    return [imageheightNumber floatValue];
}

- (CGFloat)chatImagePaddingX:(NSDictionary *)dict
{
    NSNumber *paddingxNumber = [dict valueForKey:kChatImagePaddingXKeyName];
    return [paddingxNumber floatValue];
}

- (CGFloat)chatImagePaddingY:(NSDictionary *)dict
{
    NSNumber *paddingyNumber = [dict valueForKey:kChatImagePaddingYKeyName];
    return [paddingyNumber floatValue];
}

- (NSString *)chatImagePath:(NSDictionary *)dict
{
    return [dict valueForKey:kChatImageKeyName];
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
