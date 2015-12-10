//
//  GlobalDefine.h
//  memezhibo
//
//  Created by Xingai on 15/5/14.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#ifndef memezhibo_GlobalDefine_h
#define memezhibo_GlobalDefine_h

#ifndef __SETTING_TEST_MODE__
#define __SETTING_TEST_MODE__
#endif

// Debug Mode
#ifndef __TTLogDebug__
#ifdef __SETTING_TEST_MODE__
#define __TTLogDebug__
#endif
#endif

#define kAppStoreURLTemplate        @"itms-apps://itunes.apple.com/app/id%@"
#define kAppleLookupURLTemplate     @"http://itunes.apple.com/lookup?id=%@"
// UMeng App Key
#define kUMMobClickAppKey    @"544f71eafd98c5a62b002aa3"
#define kQQAppVerifyURL                    @"http://user.memeyule.com/thirdlogin/qq?"
#define kQQAppVerifyURLTest                @"http://test.user.memeyule.com/thirdlogin/qq?"
// App ID from APPStore
#define kAppID     @"933122027"
#define kAppScheme @"TTShow"


#define USER_APP_PATH                 @"/User/Applications/" 

//DDLog
//#define TTLOG(log_func, level_tag, fmt, ...) log_func(@"[%@][%@:%i]: " fmt, level_tag, @__FILE__.lastPathComponent, __LINE__, ##__VA_ARGS__)
//
//#ifdef __TTLogDebug__
//#define LOGDEBUG(fmt,...) TTLOG(DDLogVerbose, @"DEBUG", fmt, ##__VA_ARGS__)
//#define LOGINFO(fmt,...) TTLOG(DDLogInfo, @" INFO", fmt, ##__VA_ARGS__)
//#define LOGWARNING(fmt,...) TTLOG(DDLogWarn, @" WARN", fmt, ##__VA_ARGS__)
//#define LOGERROR(fmt,...) TTLOG(DDLogError, @"ERROR", fmt, ##__VA_ARGS__)
//#define LOGEXCP(fmt, excp, ...) LOGERROR(@"Exception <Class: %@><Name: %@><Reason: %@> " fmt, excp.class, excp.name, excp.reason, ##__VA_ARGS__)
//#else
//#define LOGDEBUG(fmt,...)
//#define LOGINFO(fmt,...)
//#define LOGWARNING(fmt,...)
//#define LOGERROR(fmt,...)
//#define LOGEXCP(fmt, excp, ...)
//#endif

// Color
#define kBlackColor                 [UIColor blackColor]          // 0.0 white
#define kDarkGrayColor              [UIColor darkGrayColor]       // 0.333 white
#define kLightGrayColor             [UIColor lightGrayColor]      // 0.667 white
#define kWhiteColor                 [UIColor whiteColor]          // 1.0 white
#define kGrayColor                  [UIColor grayColor]           // 0.5 white
#define kRedColor                   [UIColor redColor]            // 1.0, 0.0, 0.0 RGB
#define kGreenColor                 [UIColor greenColor]          // 0.0, 1.0, 0.0 RGB
#define kBlueColor                  [UIColor blueColor]           // 0.0, 0.0, 1.0 RGB
#define kCyanColor                  [UIColor cyanColor]           // 0.0, 1.0, 1.0 RGB
#define kYellowColor                [UIColor yellowColor]         // 1.0, 1.0, 0.0 RGB
#define kMagentaColor               [UIColor magentaColor]        // 1.0, 0.0, 1.0 RGB
#define kOrangeColor                [UIColor orangeColor]         // 1.0, 0.5, 0.0 RGB
#define kPurpleColor                [UIColor purpleColor]         // 0.5, 0.0, 0.5 RGB
#define kBrownColor                 [UIColor brownColor]          // 0.6, 0.4, 0.2 RGB
#define kClearColor                 [UIColor clearColor]          // 0.0 white, 0.0 alpha

// Data source
#define kUserInformationDataSource @"iOS_meme"

// User Manager
#define kUserManagerPasswordLengthMin (6)

// Database File.
#define kDocumentPath        NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES)[0]

// UIAlertView
#define kAlertViewCancelButtonIndex (0)

// Navigation Bar
#define kNavigationBarHeight    (64.0f)      // just for Landscape.

// Tab Bar
#define kTabBarHeight           (49.0f)

// Status Height.
#define kScreenStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height

// Screen Bounds.
#define kScreenWidth                 ([[UIScreen mainScreen] bounds].size.width)
#define kScreenHeight                ([[UIScreen mainScreen] bounds].size.height)

#define kRatio                  kScreenWidth/320.0f

#define kExpressionKeyboardHeght       240.0f

// Notification
#define kNotificationCenter          [NSNotificationCenter defaultCenter]
#define kNotificationUpdateUser            @"NotificationUpdateUser"
#define kNotificationUpdateTask            @"NotificationUpdateTask"
#define kNotificationSocketReconnect       @"NotificationSocketReconnect"
#define kNotificationSendGiftSuccess       @"NotificationSendGiftSuccess"
#define kNotificationUpdateFavorList       @"NotificationUpdateFavorList"
#define kNotificationUpdateRecentWatchList @"NotificationUpdateRecentWatchList"
#define kNotificationThirdPartyPaySuccess  @"NotificationThirdPartyPaySuccess"
#define kNotificationSettingChanged        @"NotificationSettingChanged"


#define kNotificationUnReadMsgCountChanged @"kNotificationUnReadMsgCountChanged"
#define kNotificationUnReadSysMsgCountChanged @"kNotificationUnReadSysMsgCountChanged"
#define kNotificationUnReadFamilyMsgCountChanged @"kNotificationUnReadFamilyMsgCountChanged"

#define kNotificationSocketFriendMessage @"kNotificationSocketFriendMessage"
#define kNotificationSocketFriendApply @"kNotificationSocketFriendApply"
#define kNotificationSocketFriendAgree @"kNotificationSocketFriendAgree"
#define kNotificationSocketFriendDel @"kNotificationSocketFriendDel"
#define kNotificationSocketFriendRequest @"kNotificationSocketFriendRequest"

#define kNotificationSocketFriendUnReadList @"kNotificationSocketFriendUnReadList"

#define kNotificationSocketGroupMessage @"kNotificationSocketGroupMessage"
#define kNotificationSocketGroupUnReadList @"kNotificationSocketGroupUnReadList"
#define kNotificationSocketGroupJoinExit @"kNotificationSocketGroupJoinExit"
#define kNotificationSocketGroupShutup @"kNotificationSocketGroupShutup"

//NSUserDefault key
#define kNSUserDefaultKeyMessageNotifyOn                 @"kNSUserDefaultKeyMessageNotifyOn"
#define kUserDefaultKeyGroupsNotify                      @"kUserDefaultKeyGroupsNotify"
#define kUserDefaultKeyFriendApplyTips                      @"kUserDefaultKeyFriendApplyTips"
#define kWatchAnchorOnline  @"WatchAnchorOnline"
#define kShowEnterMessage   @"HideEnterMessage"
#define kAppLanched     @"AppLaunched"
#define kSettingWatchAnchoronlineLaunched   @"SettingWatchAnchoronlineLaunched"
#define kSettingShowEnterMessageLaunched    @"SettingShowEnterMessage"

#define kRGBA(R, G, B, A)           [UIColor colorWithRed:(R)/255.0f green:(G)/255.0f blue:(B)/255.0f alpha:(A)]
#define kRGB(R, G, B)               [UIColor colorWithRed:(R)/255.0f green:(G)/255.0f blue:(B)/255.0f alpha:1.0f]


#define kImageClickColor            kRGB(169.0f, 169.0f, 169.0f)

// cell separator color
#define kCellSeparatorColor         [UIColor colorWithRed:0.90f green:0.90f blue:0.90f alpha:1.0f]
#define kNavTitleDarkColor          kBlackColor
#define kNavTitleHighlightColor     kWhiteColor
//#define kMainColor                  kRGB(51.0f, 0.0f, 51.0f)
#define kNavigationMainColor        kRGB(255.0, 193.0f, 7.0f)


#define kSectionMinHeght      12
#define kSectionMaxHeght      28
#define kCellminHeght         44
#define kCellMaxHeght         76

#define kCGRectMake(x,y,wd,hg)      CGRectMake(x*kScreenWidth/320.0, y*kScreenWidth/320.0, wd*kScreenWidth/320.0, hg*kScreenWidth/320.0)

#define kCGRectRatio(x,y,wd,hg)            CGRectMake(x*kScreenWidth/375.0f, y*kScreenWidth/375.0f, wd*kScreenWidth/375.0f, hg*kScreenWidth/375.0f)

#define kTempTag                    200
#define kSegmentViewTag 500

// Fonts.
#define kNavigationTitleFontSize    (18.0f)
#define kFontOfSize(size)           [UIFont systemFontOfSize:size]
#define kBoldFontOfSize(size)       [UIFont boldSystemFontOfSize:size]
#define kFeedbackContentFontSize    (14.0f)


#define kRoomChatGrowingTextViewOriginHeight (20.0f)

// Chat History
#define kChatHistoryModeKey         @"Chat.Mode"
#define kChatHistoryNickNameKey     @"Chat.NickName"
#define kChatHistoryUserIDKey       @"Chat.ID"
#define kChatHistoryVIPHiddingKey   @"Chat.VIPHidding"
#define kChatHistoryNickNameFromKey @"Chat.NickNameFrom"
#define kChatHistoryFromUserIDKey   @"Chat.FromID"
#define kChatHistoryNickNameToKey   @"Chat.NickNameTo"
#define kChatHistoryToUserIDKey     @"Chat.ToID"
#define kChatHistoryPrivateKey      @"Chat.Private"
#define kChatHistoryContentKey      @"Chat.Content"
#define kChatHistoryViewKey         @"Chat.View"
#define kChatHistoryViewHeightKey   @"Chat.ViewHeight"


#define kChatTargetIDKey            @"_id"
#define kChatTargetNickNameKey      @"nick_name"

// Localized.
#define kLocalizedString(key)       NSLocalizedString(key, nil)

// Image
#define kImageNamed(imageString)    [UIImage imageNamed:[NSString stringWithFormat:@"Resources.bundle/pics/%@",imageString]]

// Sound
#define kSystemSoundPath(name, ext) [[NSBundle mainBundle] pathForResource:name ofType:ext]

// Info.plist object.
#define kInfoObjectForKey(key) [[NSBundle mainBundle] objectForInfoDictionaryKey:key]

#define kNotNilString(p) (p ? p : @"")

// Common bg color
#define kCommonBgColor              kRGB(245.0f, 245.0f, 247.0f)//kRGB(245.0f, 240.0f, 240.0f
// Tag Gift
#define kFormatNilString(string) ((string) ? (string) : @"")

// Time
#define kOneWeekSeconds (7 * 24 * 60 * 60)  // one week.

// Host Name
//#define kAppHostAddress @"http://test.api.2339.com"
//#define kbaseUserURL    @"http://test.user.2339.com"
#define kAppHostAddress @"http://api.memeyule.com/"
#define kBaseUserURL    @"http://api.memeyule.com/"
#define kTestUserURL    @"http://test.api.memeyule.com/"

#define kbaseUserURL  self.dataManager.filter.testModeOn ?kTestUserURL:kBaseUserURL

//friend
#define MSG_STATUS_RECEIVE 0
#define MSG_STATUS_SEND_SUCCESS 1
#define MSG_STATUS_SEND_FAIL 2
#define MSG_STATUS_SYS_MSG 100

//group
#define MSG_TYPE_GROUP_TEXT 0           //小窝文字消息
#define MSG_TYPE_GROUP_TEXT_WITH_BG 1   //小窝图片消息
#define MSG_TYPE_GROUP_PIC  2           //小窝图片消息
#define MSG_TYPE_GROUP_AUDIO  3         //消息语音消息
#define MSG_TYPE_FRIEND 4               //好友消息
#define MSG_TYPE_GROUP_SYS_MSG 5        //小窝系统消息
#define MSG_TYPE_GROUP_GIFT 6        //小窝送礼消息


#define MSG_TYPE_GROUP_MSG 7            //小窝进出场，上麦下麦踢麦
#define MSG_TYPE_GROUP_HONGBAO 8        //小窝红包信息
#define MSG_TYPE_GROUP_QIANGHONGBAO 9   //小窝抢红包信息
#define MSG_TYPE_GROUP_TIREN     10     //小窝踢人



#define AUDIO_READ_STATUS_UNREAD 0      //小窝语音消息状态：未读
#define AUDIO_READ_STATUS_READED 1      //小窝语音消息状态：已读


// iOS版本判断
#define IS_PREV_TO_IOS7     (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1)
#define IS_AT_LEAST_IOS7    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define IS_AT_LEAST_IOS8    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)


// Chat Target.
typedef NSMutableDictionary TTShowChatTarget;

// Vip
typedef NS_ENUM(NSInteger, AlertViewType)
{
    kAlertViewBuyOrRenewVip = 500,
    kAlertViewBuyOrRenewCar,
    kAlertViewCharge,
    kAlertViewTypeMax
};

// Main.
typedef NS_ENUM(NSInteger, RoomListType)
{
    kRoomListNone,
    kRoomListRed,
    kRoomListStar,
    kRoomListGiant,
    kRoomListSuper,
    kRoomListMax
};

typedef NS_ENUM(NSInteger, ExitType)
{
    kExitPop,
    kExitDismissModal,
    kExitMax
};

typedef NS_ENUM(NSInteger, EnterType)
{
    kEnterTypeMain,
    kEnterTypeOther,
    kEnterTypeMax
};

typedef NS_ENUM(NSInteger, UCEnterType)
{
    kUCEnterFromLive = 0,
    kUCEnterFromLiveUserPanel,
    kUCEnterFromSetting,
    kUCEnterFromOther,
    kUCEnterTypeMax
};

typedef NS_ENUM(NSInteger, VideoEnterType)
{
    kVideoEnterMain,
    kVideoEnterFromUC,
    kVideoEnterOther,
    kVideoEnter
};

typedef NS_ENUM(NSInteger, MemberType)
{
    kTrialVip = -1,
    kVIPNone,
    kVIPNormal,
    kVIPSuper,
    kMemberTypeMax
};

typedef NS_ENUM(NSInteger, TaskState)
{
    kTaskStateUncompleted,
    kTaskStateRetrieve,
    kTaskStateCompleted,
    kTaskStateMax
};

typedef NS_ENUM(NSInteger, WapPayMethod)
{
    kTenWapPay = 0,
    kAliWapPay,
    kWapPayMax
};


#import "UIGlobalKit.h"
#import "GlobalStatics.h"
#import "DataGlobalKit.h"
#import "MeMeZhiBo.h"
#import "Manager.h"

#endif
