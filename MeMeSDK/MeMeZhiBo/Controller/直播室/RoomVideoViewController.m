//
//  RoomVideoViewController.m
//  memezhibo
//
//  Created by Xingai on 15/5/19.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "RoomVideoViewController.h"
#import "RoomVideoViewController+Remote.h"
#import "RoomVideoViewController+Video.h"
#import "RoomVideoViewController+Socket.h"
#import "RoomVideoViewController+Keyboard.h"
#import "RoomVideoViewController+Delegate.h"
#import "RoomVideoViewController+Datasource.h"
#import "RoomVideoViewController+Timer.h"
#import "RoomVideoViewController+Gift.h"


@interface RoomVideoViewController ()

@end

@implementation RoomVideoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.isHideNavigation = NO;
        self.isAutoHideNavBar = YES;
        self.isAudienceFirstLoading = YES;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self setupTimer];
    [self retrieveUserInfo];
    [self registerKeyboardNotification];
    [self setupNavigationEvent];
    [self setupNavigation];
    [self retrieveRoomManagerList];
    [self retrieveLiveSpentMost];
    [self retrieveAudienceList];
    [self retrieveCarList];
    [UIApplication sharedApplication].idleTimerDisabled = YES;
    self.navigationController.navigationBarHidden = NO;
    [self retrieveGuanjianzi];
    [self retrieveGuanjianzi1];
    
//    int set = 1;
//    setsockopt(sd, SOL_SOCKET, SO_NOSIGPIPE, (void *)&set, sizeof(int));
    

    
    [super viewWillAppear:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self unregisterKeyboardNotification];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    if (self.autoHideNavigationTimer) {
        [self.autoHideNavigationTimer invalidate];
        self.autoHideNavigationTimer = nil;
    }
    [self.view.layer removeAllAnimations];
    [UIApplication sharedApplication].idleTimerDisabled = NO;
//    // Remote event.
    [self killTimer];
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UIApplication sharedApplication] endReceivingRemoteControlEvents];
    self.view.backgroundColor = kCommonBgColor;
    
    [kNotificationCenter addObserver:self selector:@selector(onpreparedListener:) name:CyberPlayerLoadDidPreparedNotification object:nil];
    [kNotificationCenter  addObserver:self selector:@selector(seekComplete:) name:CyberPlayerSeekingDidFinishNotification object:nil];
    [kNotificationCenter addObserver:self selector:@selector(enterBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
    
    [kNotificationCenter addObserver:self selector:@selector(becomeActive:) name:UIApplicationDidBecomeActiveNotification object:nil];
    
    
    self.currentRoom.nick_name = [self.currentRoom.nick_name stringByUnescapingFromHTML];
    
    self.lastSendTime = nil;
    [self setupTitles];
    
    
    // UI
    if (self.currentRoom.live) {
        
        
        [self setupMediaPath];
        [self setupPlayerContainer];
        [self setupLoading];
    }
    else
    {
        [self setupLoadingTo];
    }
    
    [self setupSocketIO];
    
    [self retrieveRoomStar];
    
    [self setupEmptyContainer];
    
    [self setupSegment];
    
    [self setupKeyboardView];
    
    [self setupTableView];
    
    [self setupGiftrankingTable];
    
    [self setupGiftListView];
    
    [self setupExpressionKeyboard];
    
}

- (void)seekComplete:(NSNotification*)notification
{
    
}

- (void) onpreparedListener: (NSNotification*)aNotification
{
    __weak __typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        weakSelf.loadingView.hidden = YES;
    });
    
}

-(void)setupExpressionKeyboard
{
     self.expressionKeyboard = [[TTExpressionKeyboard alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, kExpressionKeyboardHeght)];
    self.expressionKeyboard.delegate = self;
    self.expressionKeyboard.backgroundColor = kRGB(89, 80, 83);
    [self.view addSubview:self.expressionKeyboard];
}

-(void)setupTitles
{
    self.titles = @[@"综合",@"@我",@"人气"];
    self.shutupMinutes = @[@(5), @(60), @(12 * 60)];
}

- (void)setupNavigation
{
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    [self.navigationController setNavigationBarHidden:self.isHideNavigation];
    self.navigationController.navigationBar.translucent = YES;
}

-(void)setupTableView
{
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0, 36.0f, kScreenWidth, kScreenHeight-44.0f-240*kRatio-36.0f) style:UITableViewStylePlain];
    self.messageTable = table;
    self.messageTable.alwaysBounceVertical = YES;
    self.messageTable.dataSource = self;
    self.messageTable.delegate = self;
    self.messageTable.backgroundColor = kCommonBgColor;
    [self.messageTable setAllowsMultipleSelection:NO];
    [self.messageTable setShowsVerticalScrollIndicator:YES];
    self.messageTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    [self.empScroll addSubview:self.messageTable];
    
    
    UITableView *Mytable = [[UITableView alloc] initWithFrame:CGRectMake(kScreenWidth, 36.0f, kScreenWidth, kScreenHeight-44.0f-240*kRatio-36.0f) style:UITableViewStylePlain];
    self.MyMessageTable = Mytable;
    self.MyMessageTable.alwaysBounceVertical = YES;
    self.MyMessageTable.dataSource = self;
    self.MyMessageTable.delegate = self;
    self.MyMessageTable.backgroundColor = kCommonBgColor;
    [self.MyMessageTable setAllowsMultipleSelection:NO];
    [self.MyMessageTable setShowsVerticalScrollIndicator:YES];
    self.MyMessageTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.empScroll addSubview:self.MyMessageTable];
}

- (void)setupNavigationEvent
{
    [self.uiManager.global setNavCustomTransBg:self];
    
    // Title.
    self.titleView = [[VideoTitleView alloc] init];
    
    [self.titleView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(enterStarZone:)]];
    self.navigationItem.titleView = self.titleView;
    
    self.titleView.nameLabel.text = [self.currentRoom.nick_name stringByUnescapingFromHTML];
    self.titleView.idLabel.text = [NSString stringWithFormat:@"房间号：%ld",(unsigned long)self.currentRoom._id];
    
//    [self.uiManager.global setLiveNavBackItem:self action:@selector(goback:)];
    
    [self naviItem:self image:@"" selImage:@"" action:@selector(goback:)];
    
    [self setupNavigationRightEvent];
    
}

- (void)naviItem:(UIViewController *)v image:(NSString *)image selImage:(NSString *)selImage action:(SEL)action
{
    UIBarImageButton *item = [UIBarImageButton buttonWithType:UIButtonTypeCustom];

    item.frame = CGRectMake(0.0f, 0.0f, 25.0f, 25.0f);

    [item setImage:[UIImage imageNamed:@"Resources.bundle/pics/直播间_关闭未按下"] forState:UIControlStateNormal];
    
    [item addTarget:v action:action forControlEvents:UIControlEventTouchUpInside];

    v.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:item];
}

-(void)setupNavigationRightEvent
{
    [self retrieveFavorStatus];
    NSString *favorString = (self.isFollowStar ? @"直播间_已关注" : @"直播间_未关注");
    
    [self.uiManager.global setNavLeft:NO
                           controller:self
                                image:@[@"直播间_举报未按下", favorString]
                          highlighted:@[@"", @""]
                               action:@[[NSValue valueWithPointer:@selector(reportStar:)], [NSValue valueWithPointer:@selector(followStar:)]]];
}



- (void)recordFirstFavorStar
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self.dataManager.filter setFirstFavorStar:YES];
    });
}

- (void)reportStar:(id)sender
{
    // whether navigation bar auto is hidden?
    self.isAutoHideNavBar = NO;
    
    [self showReportActionSheet];
}

-(void)setupLoading
{
    self.loadingView = [[LoadingView alloc] init];
    self.loadingView.frame = CGRectMake(0, 0, kScreenWidth, 240*kRatio);
    self.loadingView.hidden = NO;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self.loadingView addGestureRecognizer:tapGesture];
    [self.view addSubview:self.loadingView];
    
    
    [[UIGlobalKit sharedInstance] setImageAnimationLoading:self.loadingView.picImage WithSource:self.currentRoom.pic_url];
}

-(void)setupLoadingTo
{
    
    self.loadingViewTo = [[LoadingViewTo alloc] init];
    self.loadingViewTo.frame = CGRectMake(0, 0, kScreenWidth, 240*kRatio);
    
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self.loadingViewTo addGestureRecognizer:tapGesture];
    
    [self.view addSubview:self.loadingViewTo];

    [[UIGlobalKit sharedInstance] setImageAnimationLoading:self.loadingViewTo.headImage WithSource:self.currentRoom.pic_url];
    
    NSDate *  senddate=[NSDate date];
    self.loadingViewTo.timeLabel.text = [senddate dateTimeString];
    
    [self.view insertSubview:self.loadingViewTo aboveSubview:self.mediaPlayer1.view];
}


-(void)enterStarZone:(id)sender
{
    PersonalHomePageViewController *homePage = [[PersonalHomePageViewController alloc] init];
    homePage.flag = 3;
    homePage.navTitle = @"房间";
    homePage.currentRoom = self.currentRoom;

    self.infoView.isModify = NO;
    self.bgView.hidden = YES;
    self.infoView.view.hidden = YES;
    self.outBtn.hidden = YES;
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    [self.navigationController pushViewController:homePage animated:YES];
}

-(void)goback:(id)sender
{
    self.closeSocketIOWhenDisappear = YES;

    [self closeSockIO];

    [self.mediaPlayer1 stop];

    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)closeSockIO
{
    if (!self.closeSocketIOWhenDisappear)
    {
        return;
    }
    
    self.socketIO.delegate = nil;
    [self.socketIO disconnect];
    self.socketIO = nil;
}

- (void)updateFloatTitleView
{

}

- (void)updateStarUpgradeNeedBeanCount:(NSInteger)count
{

}

- (void)updateFeatherCountUI:(NSInteger)count
{

}

- (NSInteger)upgradeNeedBeanCount:(long long int)totalBeanCount
{
    NSInteger needBeanUpgrade = [self.dataManager anchorUpgradeNeedBeanCount:totalBeanCount];
    NSInteger currentBeanCount = [self.dataManager anchorCurrentBeanCount:totalBeanCount];
    NSInteger needBean = needBeanUpgrade - currentBeanCount;
    if (needBean < 0)
    {
        needBean = 0;
    }
    return needBean;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)setupEmptyContainer
{
    self.emptyView = [[EmptyView alloc] init];
    
    
    self.emptyView.frame = CGRectMake(0, 240*kRatio, kScreenWidth, kScreenHeight-240*kRatio);
    self.emptyView.alpha = 0.9;
    [self.view addSubview:self.emptyView];
    
    self.empScroll = [[UIScrollView alloc] init];
    self.empScroll.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight-240*kRatio-44);
    self.empScroll.contentSize = CGSizeMake(kScreenWidth*3, kScreenHeight-240*kRatio-44);
    self.empScroll.pagingEnabled = YES;
    self.empScroll.delegate = self;
    self.empScroll.showsHorizontalScrollIndicator = NO;
    [self.emptyView addSubview:self.empScroll];
    
    self.segView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 36.0)];
    [self.emptyView addSubview:self.segView];
}

-(void)setupSegment
{
    for (int i = 0; i < 3; i++) {
        SegmentBtnView *seg = [[SegmentBtnView alloc] init];
        seg.frame = CGRectMake(0.0+i*kScreenWidth/3.0, 0.0, kScreenWidth/3.0, 36.0);
        seg.segmentLabel.text = self.titles[i];
        if (i==0) {
            seg.segmentLabel.textColor = kNavigationMainColor;
        }
        seg.tag = kTempTag+i;
        seg.delegete = self;
        [self.segView addSubview:seg];
    }
}

#pragma mark - segementDelegate
-(void)segmentBtnClick:(NSInteger)flag
{
    [self segmentClick:flag];
    
}
                        
-(void)segmentClick:(NSInteger)flag
{
    for (SegmentBtnView *seg in [self.segView subviews]) {
        if (seg.tag != flag) {
            seg.segmentLabel.textColor = kWhiteColor;
        }
        seg.image.hidden = YES;
    }
    
//    self.mChatTypeValue = flag-kTempTag;
    
    
    
    switch (flag-kTempTag) {
        case 0:
        {
            [self.messageTable reloadData];
            self.isMymessage = NO;
            
            [self.empScroll setContentOffset:CGPointMake(0, 0) animated:YES];
        }
            break;
        case 1:
        {
            self.isMymessage = YES;
            [self.MyMessageTable reloadData];
            [self.empScroll setContentOffset:CGPointMake(kScreenWidth, 0) animated:YES];
        }
            break;
        case 2:
        {
            [self.empScroll setContentOffset:CGPointMake(kScreenWidth*2, 0) animated:YES];
        }
            break;
        default:
            break;
    }
}

-(void)loadView
{
    self.view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    self.view.backgroundColor = [UIColor clearColor];
}

#pragma mark - Reconnect And Disconnect Part.

- (void)reconnectAll
{
    [self reconnectVideo];
    if (!self.appIsInBackground)
    {
        [self reconnectSocket:NO];
    }
}

- (void)reconnectVideo
{
//    if (self.currentRoom.live && ![self.mediaPlayer1 isPlaying])
//    {
//        [self setupMediaPath];
//    }
}

- (void)reconnectSocket:(BOOL)isForce
{
    if (!isForce)
    {
        if ([self.socketIO isConnected])
        {
            return;
        }
    }
    
    if (isForce)
    {
    }
    [self connectSockIO];
}

-(void)setupKeyboardView
{
    self.keyboard = [[KeyboardView alloc] init];
    self.keyboard.frame = CGRectMake(0, kScreenHeight-44, kScreenWidth, 80);
    self.keyboard.textField.delegate = self;
    self.keyboard.delegate = self;
    
    UISwipeGestureRecognizer *recognizer;
    recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionDown)];
    [self.keyboard addGestureRecognizer:recognizer];
    
    
    if (self.dataManager.global.isUserlogin) {
        [[UIGlobalKit sharedInstance] setImageAnimationLoading:self.keyboard.headImage WithSource:self.me.pic];
    }else{
        self.keyboard.headImage.image = kImageNamed(@"用户默认头像");
    }
    
    
    [self.view addSubview:self.keyboard];
    
    
    self.downBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.downBtn.frame = CGRectMake(kScreenWidth/2-26, self.keyboard.frame.origin.y-26, 53, 26);
    [self.downBtn setImage:kImageNamed(@"信息取消") forState:UIControlStateNormal];
    [self.downBtn addTarget:self action:@selector(keyBoardDown) forControlEvents:UIControlEventTouchUpInside];
    self.downBtn.alpha = 0.0f;
    [self.view addSubview:self.downBtn];
}

-(void)handleSwipeFrom:(UISwipeGestureRecognizer*)recognizer
{
    if (recognizer.direction==UISwipeGestureRecognizerDirectionDown) {
        [self keyBoardDown];
    }
}

-(void)keyBoardDown
{
    [self.keyboard.textField resignFirstResponder];
    [UIView animateWithDuration:0.25 animations:^{
        self.keyboard.frame = CGRectMake(0, kScreenHeight-44, kScreenWidth, 80);
        self.emptyView.frame = CGRectMake(0, 240*kRatio, kScreenWidth, kScreenHeight-240*kRatio);
        self.messageTable.frame = CGRectMake(0, 36.0f, kScreenWidth, kScreenHeight-44.0f-240*kRatio-36.0f);
        self.MyMessageTable.frame = CGRectMake(kScreenWidth, 36.0f, kScreenWidth, kScreenHeight-44.0f-240*kRatio-36.0f);
        self.giftrankingTable.frame = CGRectMake(kScreenWidth*2, 36.0f, kScreenWidth, kScreenHeight-44.0f-240*kRatio-36.0f);
        self.expressionKeyboard.frame = CGRectMake(0, kScreenHeight, kScreenWidth, kExpressionKeyboardHeght);
        self.downBtn.frame = CGRectMake(kScreenWidth/2-26, self.keyboard.frame.origin.y-26, 53, 26);
        
        self.downBtn.alpha = 0.0f;
        if (self.userPanel) {
            self.userPanel.view.alpha = 0.0f;
        }
    }];
}

-(void)setupGiftrankingTable
{
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(2*kScreenWidth, 36.0f, kScreenWidth, kScreenHeight-44.0f-240*kRatio-36.0f) style:UITableViewStyleGrouped];
    self.giftrankingTable = table;
    self.giftrankingTable.alwaysBounceVertical = YES;
    self.giftrankingTable.dataSource = self;
    self.giftrankingTable.delegate = self;
    self.giftrankingTable.backgroundColor = kCommonBgColor;
    [self.giftrankingTable setAllowsMultipleSelection:NO];
    [self.giftrankingTable setShowsVerticalScrollIndicator:YES];
    self.giftrankingTable.tableFooterView = [[UIView alloc] init];
    
    [self.giftrankingTable setSeparatorInset:UIEdgeInsetsMake(76, 95, 0, 0)];
    
    
    [self.empScroll addSubview:self.giftrankingTable];
    
}


- (void)updateAudienceCountUI:(NSInteger)count
{
    long long int vistors = [DataGlobalKit shamVistorCount:count];
    
    SegmentBtnView *view = (SegmentBtnView*)[self.view viewWithTag:kTempTag+2];
    view.segmentLabel.text = [NSString stringWithFormat:@"%lli人气",vistors];
}

-(void)dealloc
{
    [kNotificationCenter removeObserver:self name:CyberPlayerLoadDidPreparedNotification object:nil];
    [kNotificationCenter removeObserver:self name:CyberPlayerSeekingDidFinishNotification object:nil];
    
    [kNotificationCenter removeObserver:self name:UIApplicationDidEnterBackgroundNotification object:nil];
    [kNotificationCenter removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
}


#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == kAlertViewCancelButtonIndex)
    {
        return;
    }
    
    switch (alertView.tag)
    {
        case kRoomCancelFavorAlertViewTag:
        {
            [self cancelFavorStar];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - Favor star.

- (void)followStar:(id)sender
{
    // Login Tips.
    if (!self.dataManager.global.isUserlogin)
    {
        [self showLoginTipActionSheet];
        return;
    }
    
    if (self.isFollowStar)
    {
        UIAlertView *cancelFavor = [UIAlertView showConfirmMessage:@"取消关注后将很难再找到我哟" cancelTitle:@"继续关注" confirmTitle:@"取消关注" delegate:self];
        cancelFavor.tag = kRoomCancelFavorAlertViewTag;
        [cancelFavor show];
        return;
    }
    
    [self.dataManager.remote followingForStar:self.currentRoomStar._id add:!self.isFollowStar completion:^(BOOL success, NSError *error) {
        if (success)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (self.isFollowStar)
                {
                    [self.dataManager.defaults delFollowStar:self.currentRoomStar._id];
                    //                    [UIAlertView showInfoMessage:@"取消关注成功"];
                }
                else
                {
                    [self.dataManager.defaults addFollowStar:self.currentRoomStar._id];
                    [self recordFirstFavorStar];
                    //                    [UIAlertView showInfoMessage:@"关注成功"];
                    [self.uiManager.global showMessage:@"关注主播成功,您可以收到该主播的开播通知" in:self disappearAfter:1.5f];
                }
                
                [self setupNavigationRightEvent];
                // Notify update.
            });
        }
    }];
}


- (void)cancelFavorStar
{
    [self.dataManager.remote followingForStar:self.currentRoomStar._id add:!self.isFollowStar completion:^(BOOL success, NSError *error) {
        if (success)
        {
            if (self.isFollowStar)
            {
                [self.dataManager.defaults delFollowStar:self.currentRoomStar._id];
            }
            
            // Notify update.
            [self setupNavigationRightEvent];
        }
    }];
}


- (void)releaseAll
{
    [self killTimer];
    self.loadingView = nil;
    self.loadingViewTo = nil;
    
    // player.
    [_playerContainer removeFromSuperview];
      _playerContainer = nil;
    
    
    _videoURLString = nil;
    
    // SocketIO.
    if (_socketIO)
    {
        _socketIO.delegate = nil;
        _socketIO = nil;
    }
    
    // Data Containner.
    for (NSDictionary *chatDictionary in _chatHistoryPublicArray)
    {
        __weak NSDictionary *dict = chatDictionary;
        TTMultiLineView *mv = [chatDictionary valueForKey:kChatHistoryViewKey];
        if (mv)
        {
            [mv removeFromSuperview];
        }
        mv = nil;
        dict = nil;
    }
    
    if (_chatHistoryPublicArray)
    {
        [_chatHistoryPublicArray removeAllObjects];
    }
    _chatHistoryPublicArray = nil;
    _chatHistroyPrivateArray = nil;
    
    self.userPanel.delegate = nil;
    self.userPanel = nil;
    
    
    [self.emptyView removeFromSuperview];
    self.emptyView = nil;
    
    [self.giftController.view removeFromSuperview];
    self.giftController = nil;
    
    _liveSpentMost = nil;
    
    _adminList = nil;
    
    _liveAudiences = nil;
    
    // publish message.

    _mChatTargetValue = nil;
    
    NSArray *views = [self.view subviews];
    for(UIView* view in views)
    {
        [view removeFromSuperview];

    }
    self.bgView = nil;
    self.infoView = nil;
    
    self.keyboard.delegate = nil;
#ifdef __LIVE_SOFA_FEATHURE_ON__
    // Sofa
    _sofaController = nil;
#endif
    

    
    // Chat Targets Cache.
    _chatTargets = nil;
    
    NSString *path = NSHomeDirectory();//主目录
    NSLog(@"NSHomeDirectory:%@",path);

    
#ifdef __ROOM_VIDEO_FLOAT_REPORT_VIEW_FEATURE_ON__
    // Report Star View.
    _reportView = nil;
#endif
    

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
