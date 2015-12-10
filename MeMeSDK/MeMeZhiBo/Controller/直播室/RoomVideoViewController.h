//
//  RoomVideoViewController.h
//  memezhibo
//
//  Created by Xingai on 15/5/19.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTShowRoomStar.h"
#import "TTVideoTip.h"
//#import "GiftPanelView.h"
#import "VideoTitleView.h"
#import "PlayerLayerView.h"
//#import "IJKMediaPlayer.h"
#import "CyberPlayerController.h"
#import "EmptyViewController.h"
#import "EmptyView.h"
#import "SegmentBtnView.h"
#import "SocketIO.h"
#import "SocketIOPacket.h"
#import "TTLineView.h"
#import "TTMultiLineView.h"
#import "KeyboardView.h"
#import "RoomVideoChatHistoryCell.h"
#import "TTSingleLineView.h"
#import "RoomGiftViewController.h"
#import "TTExpressionKeyboard.h"
#import "LoadingView.h"
#import "LoadingViewTo.h"
#import "GiftTextView.h"
#import "ReportAlertview.h"
#import "AndWhoListView.h"
#import "RoomMyinfoViewController.h"
#import "UserPanelViewController.h"
#import "PersonalHomePageViewController.h"
#import "GuanzhuViewController.h"

// 服务器Socket.IO推送模式
typedef NS_ENUM(NSInteger, ChatRoomNotifyMode)
{
    kChatNofityModeNone = 0,
    
    // Action Part.
    kActionRoomChangeMode = 10,             //房间确认
    kActionMeRoomChangeMode,                //我的房间确认
    kActionRoomStarMode,                    //开播
    kActionRoomAdminListMode,
    kActionManageKickMode,
    kActionManageMeKickMode,
    kActionManageShutupMode,
    kActionManageMeShutupMode,
    kActionMessageBroadcastMode,
    kActionUserInfoMode,
    kActionLiveRankMode,
    kActionGiftNotifyMode,
    kActionGiftNotifyFromMeMode,
    kActionGiftNotifyToMeMode,
    kActionGiftFeatherMode,                        //送礼meme
    kActionGiftFeatherFromMeMode,
    kActionSystemNoticeMode,
    kActionGiftMarqueeMode,
    kDefaultAnnounceChargeMode,                    //me进入主播房间
    kDefaultAnnounceOfficialWebsiteMode,
    kActionLiveStatusMode,
    kActionSofaListMode,
    kActionPuzzleBeginMode,
    kActionPuzzleWinMode,
    
    // Chat Part.
    kRoomChatMeToAllMode = 50,
    kRoomChatMeToOneMode,
    kRoomChatMeToOnePrivateMode,
    kRoomChatOneToAllMode,
    kRoomChatOneToOneMode,
    kRoomChatOneToOnePrivateMode,
    kRoomChatOneToMeMode,
    kRoomChatOneToMePrivateMode
};

typedef NS_ENUM(NSInteger, ChatActionSheetTag)
{
    kChatActionSheetChooseTarget = 1000,
    kChatActionSheetLoginTip,
    kChatActionSheetReport,
    kChatActionSheetAudience,
    kChatActionSheetShutup,
    kChatActionSheetMax
};

typedef NS_ENUM(NSInteger, RoomAlertViewTag)
{
    kRoomCancelFavorAlertViewTag = 1500,
    kRoomAlertViewTagMax
};


@interface RoomVideoViewController : UIViewController<UITextFieldDelegate,segmentBtnClickDelegate>


@property (nonatomic, assign) CGFloat sum;

// Room Star.
@property (nonatomic, strong) TTShowRoomStar *currentRoomStar;
@property (nonatomic, strong) TTShowRoom *currentRoom;
@property (nonatomic, assign) VideoEnterType enterType;
@property (nonatomic, strong) TTShowAudience *currentAudience;


@property (nonatomic, strong) NSString *access_token;

@property (nonatomic, assign) BOOL isHideNavigation;
//@property (nonatomic, assign) VideoEnterType enterType;
@property (nonatomic, assign) BOOL isAudienceFirstLoading;
//@property (nonatomic, strong) TTVideoTip *mediaTip;
@property (nonatomic, strong) NSMutableArray *chatTargets;
@property (nonatomic, strong) NSMutableArray *adminList;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) UIView *segView;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UITableView *messageTable;
@property (nonatomic, strong) UITableView *giftrankingTable;
@property (nonatomic, strong) UITableView *MyMessageTable;
@property (nonatomic, strong) NSMutableArray *giftRankingList;
@property (nonatomic, strong) NSMutableArray *liveAudiences;
@property (nonatomic, assign) NSInteger curShutupMinute;
@property (nonatomic, strong) NSArray *shutupMinutes;
@property (nonatomic, strong) NSMutableArray *andWhoList;


// Aleart
@property (nonatomic, strong) AndWhoListView *andWhoView;
@property (nonatomic, strong) ReportAlertview *alertView;
@property (nonatomic, strong) UIView *vgView;

//myInfoView
@property (nonatomic, strong) RoomMyinfoViewController *infoView;
@property (nonatomic, strong) UIButton *outBtn;

// KeyboardView
@property (nonatomic, strong) KeyboardView *keyboard;

@property (nonatomic, strong) TTExpressionKeyboard *expressionKeyboard;
@property (nonatomic, assign) BOOL GiftViewShow;

// socketIO
@property (nonatomic, strong) SocketIO *socketIO;
@property (nonatomic, assign) BOOL closeSocketIOWhenDisappear;
@property (nonatomic, assign) BOOL needScroolChatHistroy;

// Chat contents weak pointer.
@property (nonatomic, weak) NSMutableArray *chatHistoryArray;
// Chat Contents. (The array is operated frequently)
@property (nonatomic, strong) NSMutableArray *chatHistoryPublicArray;
@property (nonatomic, strong) NSMutableArray *chatHistroyPrivateArray;
@property (nonatomic, weak) NSDictionary *chatTargetDict;


// Auto Hide Navigation bar.
@property (nonatomic, assign) BOOL isAutoHideNavBar;
@property (nonatomic, strong) VideoTitleView *titleView;


// shortcut.
//@property (nonatomic, weak) ShortcutView *shortcutView;
@property (nonatomic, assign) BOOL commonerChangeRoomDisplay;

// Gift
@property (nonatomic, strong) RoomGiftViewController *giftController;
//@property (nonatomic, strong) GiftPlayContainerView *giftPlayContainer;
@property (nonatomic, strong) EmptyView *emptyView;
@property (nonatomic, strong) UIScrollView *empScroll;
@property (nonatomic, strong) NSMutableArray *broadcastCaches;
@property (nonatomic, strong) NSMutableArray *giftGifCaches;
@property (nonatomic, strong) NSMutableArray *giftMarqueeCaches;
@property (nonatomic, assign) BOOL giftListDisplay;
@property (nonatomic, strong) GiftTextView *giftTextView;

// publish message.
@property (nonatomic, strong) TTShowChatTarget *mChatTargetValue;
@property (nonatomic, assign) BOOL mChatPrivateValue;
//@property (nonatomic, assign) NSUInteger mChatTypeValue;
@property (nonatomic, strong) NSDate *lastSendTime;
@property (nonatomic, assign) BOOL isMymessage;

// Car
@property (nonatomic, strong) NSMutableArray *carList;

// Background multi-task
@property (nonatomic, assign) BOOL appIsInBackground;
@property (nonatomic, assign) BOOL mediaPlayerPaused;

// player
//@property (nonatomic, strong) UIView *playerContainer1;
@property (nonatomic, strong) PlayerLayerView *playerContainer;
@property (nonatomic, strong) NSString *videoURLString;
@property (nonatomic, strong) LoadingView *loadingView;
@property (nonatomic, strong) LoadingViewTo *loadingViewTo;

// VLC media player
//@property(atomic, strong) id<IJKMediaPlayback> mediaPlayer1;
//@property(nonatomic, strong) IJKFFMoviePlayerController *mediaPlayer1;
@property(nonatomic, strong) CyberPlayerController *mediaPlayer1;

@property (nonatomic, strong) NSMutableArray *liveSpentMost;


// Timer
@property (nonatomic, weak) NSTimer *autoHideNavigationTimer;
@property (nonatomic, weak) NSTimer *updateAudiencesTimer;

// 关注
@property (nonatomic, assign) BOOL isFollowStar;
@property (nonatomic, strong) GuanzhuViewController *guanzhu;

//个人主页
@property (nonatomic, strong) PersonalHomePageViewController *personal;

//UserPanel
@property (nonatomic, strong) UserPanelViewController *userPanel;

@property (nonatomic, assign) NSInteger flag;


//DownBtn
@property (nonatomic, strong) UIButton *downBtn;

@property (nonatomic, strong) NSString *qqhD;


@property (nonatomic, strong) NSMutableArray *guanjianziList;

@property (nonatomic, strong) NSMutableArray *guanjianziList1;

//- (void)retrieveUserInfo;
- (void)updateFloatTitleView;
- (void)updateStarUpgradeNeedBeanCount:(NSInteger)count;
- (void)updateFeatherCountUI:(NSInteger)count;
- (NSInteger)upgradeNeedBeanCount:(long long int)totalBeanCount;

- (void)reconnectAll;
- (void)updateAudienceCountUI:(NSInteger)count;
- (void)setupLoading;
- (void)setupLoadingTo;
- (void)releaseAll;
- (void)setupNavigation;
- (void)setupNavigationEvent;
- (void)setupEmptyContainer;
- (void)setupSegment;
- (void)setupTableView;
- (void)setupExpressionKeyboard;
- (void)setupKeyboardView;
- (void)setupGiftrankingTable;
-(void)segmentClick:(NSInteger)flag;
@end
