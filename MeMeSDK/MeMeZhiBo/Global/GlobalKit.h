//
//  GlobalKit.h
//  TTCX
//
//  Created by twb on 13-5-31.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "PSTCollectionView.h"

#define kChatCutOffContentSplitString                @"*$"
#define kChatCutOffContentExpression                 @"[expression]"

#define kChatTypeKeyName                             @"chat.type"
// Text
#define kChatTextKeyName                             @"chat.text"
#define kChatTextFontSizeKeyName                     @"chat.fontsize"
#define kChatTextColorTypeKeyName                    @"chat.colortype"
#define kChatTextHasUnderLineKeyName                 @"chat.underline"

// Image
#define kChatImageKeyName                            @"chat.image"
#define kChatImageWidthKeyName                       @"chat.image.width"
#define kChatImageHeightKeyName                      @"chat.image.height"
#define kChatImagePaddingXKeyName                    @"chat.image.paddingx"
#define kChatImagePaddingYKeyName                    @"chat.image.paddingy"

#define kChatExpressionGifWidth                      (28.0f)
#define kChatExpressionGifHeight                     (28.0f)
#define kChatExpressionGifPaddingX                   (0.0f)
#define kChatExpressionGifPaddingY                   (0.0f)

// Default Font Size.
#define kChatRoomFontSize                            (15.0f)
#define kChatPuzzleFontSize                          (15.0f)
#define kChatRoomSendFontSize                        (15.0f)
#define kBroadcastContentFontSize                    (15.0f)
#define kChatoNoNickNameSize                         (12.0f)
#define kChatJrSize                                  (10.0f)

typedef NS_ENUM(NSInteger, ChatRoomContentType)
{
    kChatRoomText = 0,
    kChatRoomLocalStaticImage,
    kChatRoomLocalDynamicImage,
    kChatRoomRemoteStaticImage,
    kChatRoomRemoteDynamicImage,
    kChatFriendText
};

typedef NS_ENUM(NSInteger, ChatRoomFontColorMode)
{
    kEnterNickNameColor = 0,    // 进入房间
    kFromNickNameColor,         // A
    kToColor,                   // 对
    kToNickNameColor,           // B
    kToSayColor,                // 说:
    kContentColor,              // 什么
    kEnterRoomColor,            // 进入房间
    kSystemNotifyColor,         // 系统公告
    kStopSuffer,                // 被
    kStopFrom,                  // C
    kStopTo,                    // D
    kStopContent,               // 禁言或踢出
    kSend,                      // 送给
    kSendGiftFrom,              // E
    kSendGiftTo,                // F
    kSendGiftCount,             // 共多少个
    kSendFeatherFrom,           // G
    kSendFeatherFrom1,
    kSendFeatherTo,             // H
    kSendFeatherCount,          // 共多少根
    kSystemNoticeTip,           // 系统公告
    kSystemNoticeContent,       // 系统公告内容
    kSendGiftMarqueeFrom,       // I
    kSendGiftmarquee,           // 送给
    kSendGiftMarqueeTo,         // J
    kSendGiftMarqueeContent,    // 多少礼物
    kDefaultAnnounceColor,      // [么么直播]欢迎进入房间,点击此行
    kDefaultChargeColor,        // 充值
    kFullScreenGiftNameColor,   // 全屏送礼,礼物名称颜色
    kBroadcastContentColor,     // 广播内容颜色
    kBroadcastSubmitterColor,   // 广播发布者颜色
    kBroadcastPublishTimeColor, // 广播发布时间颜色
    kPuzzleContentColor,        // 拼图获胜内容颜色
    kPuzzleTipColor,            // 拼图个数、步数颜色
    kChatColorMax,
    kZColor,                    //紫色vip
    kZColor1,                   //紫色vip说的话
    kJcNameColor,               //进场名字颜色
    kBColor                     //谁进入房间
};

@interface GlobalKit : NSObject

// Singleton for global shared functions.
+ (instancetype)sharedInstance;

@end
