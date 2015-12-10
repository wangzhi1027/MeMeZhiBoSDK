//
//  TTLineView.h
//  TTShow
//
//  Created by twb on 13-7-8.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kChatDefaultChargeAnnounce            @"[么么直播]   "
#define kChatDefaultChargeKeyword             @"欢迎来到%@"
#define kChatDefaultOfficialWebAnnounce       @"[么么直播]网页版地址:www.imeme.tv"
#define kChatCommonWordMe                     @"我"
#define kChatCommonWordMystical               @"神秘人"
#define kChatCommonAll                        @"所有人"
#define kChatCommonWordMy                     @"@"
#define kChatCommonWordTo                     @":"
#define kChatCommonWordSay                    @":"
#define kChatCommonCarRide                    @"骑着"
#define kChatCommonCarDrive                   @"开着"
#define kChatCommonWordEnter                  @" 进入房间"
#define kChatCommonWordYou                    @"您"
#define kChatCommonWordWhisper                @"悄悄"
// Shutup
#define kChatCommonSuffer                     @"被"
#define kChatCommonShutup                     @"禁言%ld分钟"
// Kick
#define kChatCommonKickOut                    @"踢出房间"
// Gift
#define kChatCommonSend                       @"送给"
#define kChatCommonSendGiftCount              @" %ld个"
// Feather.
#define kChatCommonSendFeatherCount           @" 1个"
#define kChatCommonSystemNotice               @"系统公告:"
//%@仅发%d秒%d步率先完成了本次拼图，恭喜！有请主播颁奖！
#define kChatPuzzleOnlySpend                  @"仅发"
#define kChatPuzzleSecond                     @"秒"
#define kChatPuzzleStep                       @"步"
#define kChatPuzzleTip                        @"率先完成了本次拼图, 恭喜! 有请主播颁奖!"

#define kChatSpentMostImageName               @"spent_most.png"
#define kChatSpentMostImageWidth              (13.0f)
#define kChatSpentMostImageHeight             (12.0f)
#define kChatSpentMostImagePaddingX           (1.0f)
#define kChatSpentMostImagePaddingY           (7.0f)

#define kChatStarImageName                    @"star.png"
#define kChatStarImageWidth                   (12.0f)
#define kChatStarImageHeight                  (12.0f)
#define kChatStarImagePaddingX                (1.0f)
#define kChatStarImagePaddingY                (7.0f)

#define kChatVipImageName                     @"vip.png"
#define kChatVipImageWidth                    (12.0f)
#define kChatVipImageHeight                   (12.0f)
#define kChatVipImagePaddingX                 (1.0f)
#define kChatVipImagePaddingY                 (7.0f)

#define kChatTrialVipImageName                 @"vip_trial.png"
#define kChatTrialVipImageWidth                (12.0f)
#define kChatTrialVipImageHeight               (12.0f)
#define kChatTrialVipImagePaddingX             (1.0f)
#define kChatTrialVipImagePaddingY             (7.0f)

#define kChatExtremeVipImageName              @"vip_extreme1.png"
#define kChatExtremeVipImageWidth             (12.0f)
#define kChatExtremeVipImageHeight            (12.0f)
#define kChatExtremeVipImagePaddingX          (1.0f)
#define kChatExtremeVipImagePaddingY          (7.0f)

#define kChatFlameImageName                   @"img_live_flame.png"
#define kChatFlameImageWidth                  (10.0f)
#define kChatFlameImageHeight                 (12.0f)
#define kChatFlameImagePaddingX               (1.0f)
#define kChatFlameImagePaddingY               (7.0f)

#define kChatManagerImageName                 @"管理.png"
#define kChatManagerImageWidth                (12.0f)
#define kChatManagerImageHeight               (12.0f)
#define kChatManagerImagePaddingX             (1.0f)
#define kChatManagerImagePaddingY             (7.0f)

#define kChatAgentImageName                   @"agent.png"
#define kChatAgentImageWidth                  (22.0f)
#define kChatAgentImageHeight                 (12.0f)
#define kChatAgentImagePaddingX               (1.0f)
#define kChatAgentImagePaddingY               (7.0f)

#define kChatBusinessImageName                @"business.png"
#define kChatBusinessImageWidth               (22.0f)
#define kChatBusinessImageHeight              (12.0f)
#define kChatBusinessImagePaddingX            (1.0f)
#define kChatBusinessImagePaddingY            (7.0f)

#define kChatCServiceImageName                @"cservice.png"
#define kChatCServiceImageWidth               (22.0f)
#define kChatCServiceImageHeight              (12.0f)
#define kChatCServiceImagePaddingX            (1.0f)
#define kChatCServiceImagePaddingY            (7.0f)

#define kChatStarLevelImageWidth              (18.0f)
#define kChatStarLevelImageHeight             (18.0f)
#define kChatStarLevelImagePaddingX           (1.0f)
#define kChatStarLevelImagePaddingY           (8.5f)

#define kChatWealthLevelImageWidth            (28.0f)
#define kChatWealthLevelImageHeight           (12.0f)
#define kChatWealthLevelImagePaddingX         (1.0f)
#define kChatWealthLevelImagePaddingY         (7.0f)

#define kChatCarImageWidth                    (40.0f)
#define kChatCarImageHeight                   (24.0f)
#define kChatCarImagePaddingX                 (0.0f)
#define kChatCarImagePaddingY                 (0.0f)

// Gift
#define kChatFeatherImageName                 @"img_animation_feather.png"
#define kChatFeatherImageWidth                (20.0f)
#define kChatFeatherImageHeight               (24.0f)
#define kChatFeatherImagePaddingX             (0.0f)
#define kChatFeatherImagePaddingY             (0.0f)

#define kChatGiftImageWidth                   (24.0f)
#define kChatGiftImageHeight                  (24.0f)
#define kChatGiftImagePaddingX                (0.0f)
#define kChatGiftImagePaddingY                (0.0f)

#define kChatFullScreenGiftImageWidth         (30.0f)
#define kChatFullScreenGiftImageHeight        (30.0f)
#define kChatFullScreenGiftImagePaddingX      (0.0f)
#define kChatFullScreenGiftImagePaddingY      (0.0f)

@interface TTLineView : UIView

- (UIColor *)chatTextColor:(ChatRoomFontColorMode)mode;
- (ChatRoomContentType)contentType:(NSDictionary *)dict;
- (NSString *)chatContentText:(NSDictionary *)dict;
- (CGFloat)chatContentTextFont:(NSDictionary *)dict;
- (BOOL)chatContentWithUnderLine:(NSDictionary *)dict;
- (ChatRoomFontColorMode)chatContentTextColor:(NSDictionary *)dict;
- (CGFloat)chatImageWidth:(NSDictionary *)dict;
- (CGFloat)chatImageHeight:(NSDictionary *)dict;
- (CGFloat)chatImagePaddingX:(NSDictionary *)dict;
- (CGFloat)chatImagePaddingY:(NSDictionary *)dict;
- (NSString *)chatImagePath:(NSDictionary *)dict;

@end
