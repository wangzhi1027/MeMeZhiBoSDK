//
//  PersonalHomePageViewController.m
//  memezhibo
//
//  Created by Xingai on 15/7/8.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "PersonalHomePageViewController.h"
#import "PersonalHomePageViewController+Delegate.h"
#import "PersonalHomePageViewController+Datasource.h"
#import "TTShowRemote+Friend.h"
#import "TTShowRemote+UserInfo.h"
#import "TTShowFriend.h"
#import "UIView+Utils.h"
#import "UIColor+Hex.h"
#import "PersonalHomeHeadView.h"
#import "ProfileCell.h"
#import "TTShowCar.h"
#import "BadgeCell.h"
#import "HonorViewController.h"
#import "TTShowRemote+Car.h"
#import "NSBundle+SDK.h"

static NSString * const profileCellID = @"ProfileCellReuseID";

@interface PersonalHomePageViewController ()<UIGestureRecognizerDelegate, UIActionSheetDelegate, PersonalHomeHeaderViewDelegate, UITableViewDataSource, UITableViewDelegate, AnchorHeaderViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) PersonalHomeHeadView *topView;
@property (nonatomic, strong) UITableView *profileTableView;
@property (nonatomic, strong) NSArray *profileArray;
@property (nonatomic, strong) UIActionSheet *menuActionSheet;
@property (nonatomic, strong) NSMutableArray *allCarList;
@property (nonatomic, strong) NSArray *ownedCar;
@property (nonatomic, strong) NSMutableArray *badgeList;

@end

@implementation PersonalHomePageViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.flag == 4) {
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
        //判断是否为第一个view
        if (self.navigationController && [self.navigationController.viewControllers count] == 1) {
            self.navigationController.interactivePopGestureRecognizer.enabled = NO;
        }
    }
    
    [self.view addSubview:self.topView];
    
    self.sizeArr = [NSMutableArray arrayWithCapacity:0];

    [self setupNavView];
    [self setupLeftBtnAction:@selector(goback:)];
    if (![self.navTitle isEqualToString:@""]&&self.navTitle!=nil) {
        [self.backBtn setTitle:self.navTitle forState:UIControlStateNormal];
    }

    self.nav.backgroundColor = kRGBA(0, 0, 0, 0);

    self.titleView = [[VideoTitleView alloc] init];
    self.titleView.frame = CGRectMake(kScreenWidth/2-105, 13, 210, 47);
    [self.nav addSubview:self.titleView];
    
    self.titleView.nameLabel.text = [self.currentRoom.nick_name stringByUnescapingFromHTML];
    self.titleView.idLabel.text = [NSString stringWithFormat:@"么么号：%ld",(unsigned long)self.currentRoom._id];
    self.titleLabel.hidden = YES;
    
    [self retrieveCarList];

    [self retrieveUserInfo];
    [self retrieveJiazu];
    self.isFriend = [self isAnchorFriend];
}

#pragma mark- UIGestureRecognizerDelegate
//**************方法一****************//
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    return YES;
}

-(void)retrieveJiazu
{
    
}

-(void)goback:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)setupTitles
{
    if (self.isAnchor) {
        self.titles = @[@"进入直播间"];
        
    } else {
        self.titles = @[self.isFriend ? @"发送消息" : @"添加好友"];
    }
    
    if (self.isFollowStar) {
        [self.topView.cancelWatchAnchorBtn setTitle:@"取消关注" forState:UIControlStateNormal];
    } else {
        [self.topView.cancelWatchAnchorBtn setTitle:@"关注主播" forState:UIControlStateNormal];
    }
    
    if (self.isFriend) {
        [self.topView.addFriendsBtn setTitle:@"发送消息" forState:UIControlStateNormal];
    } else {
        [self.topView.addFriendsBtn setTitle:@"添加好友" forState:UIControlStateNormal];
    }
}

- (BOOL)isAnchorFriend
{
    [self.dataManager.remote isMyFriend:self.currentRoom._id completion:^(BOOL success, NSError* error) {
        if (success) {
            self.isFriend = YES;
        } else {
            self.isFriend = NO;
        }
        [self setupTitles];
        [self setupSegment];
        if (self.isFriend) {
            self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [self setupRightBtnAction:@selector(relationBtnTapped:)];
            self.rightBtn.frame = CGRectMake(kScreenWidth-50, 18, 50.0f, 50.0f);;
            [self.rightBtn setImage:kImageNamed(@"friend_relationships") forState:UIControlStateNormal];
        }
    }];
    
    return self.isFriend;
}

-(void)setupCollection
{
//    self.layout = [[CHTCollectionViewWaterfallLayout alloc] init];
//    
//    self.layout.sectionInset = UIEdgeInsetsMake(16, 16, 16, 16);
//    self.layout.minimumColumnSpacing = 16;
//    self.layout.minimumInteritemSpacing = 16;
//    self.layout.headerHeight = 230;
//    self.layout.footerHeight = 49;
//
//    self.personalCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, -20, kScreenWidth, kScreenHeight+20) collectionViewLayout:self.layout];
//    self.personalCollection.dataSource = self;
//    self.personalCollection.delegate = self;
//    self.personalCollection.backgroundColor = kCommonBgColor;
//
//    [self.personalCollection registerNib:[UINib nibWithNibName:@"PersonalHomeCell" bundle:nil] forCellWithReuseIdentifier:@"PersonalHomeCellID"];
//
//    [self.personalCollection registerClass:[CHTCollectionViewWaterfallHeader class]
//        forSupplementaryViewOfKind:CHTCollectionElementKindSectionHeader
//               withReuseIdentifier:@"PersonalCollectionReusableView1"];
//    
//    [self.personalCollection registerClass:[CHTCollectionViewWaterfallFooter class]
//        forSupplementaryViewOfKind:CHTCollectionElementKindSectionFooter
//               withReuseIdentifier:@"PersonalCollectionReusableView2"];
    
//    [self.view addSubview:self.personalCollection];
    
}

- (void)retrieveStarPhotoList
{
    if (self.currentRoom._id== 0)
    {
        return;
    }
//    if (![DataGlobalKit networkOK])
//    {
//        if (!self.noDataView) {
//            self.noDataView = [[noDataViewController alloc] init];
//            self.noDataView.view.frame = CGRectMake(0, kNavigationBarHeight, kScreenWidth, kScreenHeight-kNavigationBarHeight);
//            [self.view addSubview:self.noDataView.view];
//        }else{
//            self.noDataView.view.hidden = NO;
//        }
//        [self.noDataView setupImage:2];
//        return;
//    }
    
    [self showProgress:@"正在载入…" animated:YES];
    [self.dataManager.remote _retrieveStarPhotoListByType:kStarLifePhoto starID:self.currentRoom._id completion:^(NSArray *array, NSInteger count, NSError *error) {
        [self hideProgressWithAnimated:YES];
        if (array.count>0) {
            for (TTShowStarPhoto *dic in array) {
                @autoreleasepool
                {
                    CGSize size = [self downloadImageSizeWithURL:[NSURL URLWithString:dic._id]];
                
                    NSString *str = [NSString stringWithFormat:@"%f",(kScreenWidth-48)/2*(size.height/size.width)];
                
                    [self.sizeArr addObject:str];
                }
            }
        }
        
        if (error == nil)
        {
            if (count < 4)
            {
                // download live photo.
                NSMutableArray *photos = [NSMutableArray arrayWithCapacity:0];
                [photos addObjectsFromArray:array];
                
                [self showProgress:@"正在载入…" animated:YES];
                [self.dataManager.remote _retrieveStarPhotoListByType:kStarLivePhoto starID:self.currentRoom._id completion:^(NSArray *array, NSInteger count, NSError *error) {
                    [self hideProgressWithAnimated:YES];
                    [photos addObjectsFromArray:array];
                    
                    [self saveRefreshPhotoList:photos];
                    
                    for (TTShowStarPhoto *dic in array) {
                        @autoreleasepool
                        {

                            CGSize size = [self downloadImageSizeWithURL:[NSURL URLWithString:dic._id]];
                            NSString *str = [NSString stringWithFormat:@"%f",(kScreenWidth-48)/2*(size.height/size.width)];
                        
                            [self.sizeArr addObject:str];
                        }
                    }
                    
                    if (self.sizeArr.count<=0) {
                        @autoreleasepool
                        {
                            self.footerImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth)];
                            self.footerImage.image = kImageNamed(@"主播无照片");
//                            [self.footerView addSubview:self.footerImage];
//                            self.layout.footerHeight = kScreenWidth;
                        }
                    }
                }];
            }
            else
            {
                [self saveRefreshPhotoList:array];
            }
        }
    }];
}

- (void)saveRefreshPhotoList:(NSArray *)photoList
{
    if (self.imageList == nil)
    {
        NSMutableArray *sp = [NSMutableArray arrayWithCapacity:0];
        self.imageList = sp;
    }
    else
    {
        [self.imageList removeAllObjects];
    }
    
    [self.imageList addObjectsFromArray:photoList];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.imageList.count <= 0) {
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.bgScrollView.bounds];
            imageView.image = [UIImage imageNamed:@"Resources.bundle/pics/主播无照片"];
            [self.bgScrollView addSubview:imageView];
            return ;
        }
        [self.photoWallCollectionView reloadData];
    });
}

- (void)retrieveUserInfo
{
    [self showProgress:@"正在载入…" animated:YES];
    [self.dataManager.remote _retrieveUserInfoNew:self.currentRoom._id completion:^(TTShowUserNew *user, NSError *error) {
        if (error == nil)
        {
            
            self.currentUser = user;
            self.isAnchor = (self.currentUser.priv == kUserPrivAnchor);
            if (self.isAnchor) {
                [self retrieveStarPhotoList];
                [self.photoWallCollectionView registerNib:[UINib nibWithNibName:@"PersonalHomeCell" bundle:[NSBundle SDKResourcesBundle]] forCellWithReuseIdentifier:@"PersonalHomeCellID"];
                self.topView.frame = CGRectMake(0, 0, kScreenWidth, 212);
                [self.view addSubview:self.anchorHeaderView];
            } else {
                self.topView.frame = CGRectMake(0, 0, kScreenWidth, 212 - 38);
                self.topView.watchAndAddFriendsBtnBgView.hidden = YES;
            }
            [self setupHeaderInfo:self.topView];
            [self.view addSubview:self.bgScrollView];
            [self.bgScrollView addSubview:self.profileTableView];
            if (self.isAnchor) {
                [self.bgScrollView addSubview:self.photoWallCollectionView];
            }
            [self retrieveCurrentUserAllCar];
            [self retrieveUserBadge];
        }
        [self hideProgressWithAnimated:YES];
        if (!self.dataManager.global.isUserlogin)
        {
//            [self showLoginTipActionSheet];
            return;
        }
        [self retrieveFavorStatus];
    }];
}

-(void)setupHeaderInfo:(PersonalHomeHeadView *)headView
{
    [[UIGlobalKit sharedInstance]setImageAnimationLoading:headView.headImage WithSource:self.currentRoom.pic_url];

    Finance *finance = [[Finance alloc] initWithAttributes:self.currentUser.finance];
    NSInteger count = [self.dataManager anchorLevel:finance.bean_count_total];
    NSInteger count1 = [self.dataManager wealthLevel:finance.coin_spend_total];
    
    NSString *weathGradeImage = [[DataGlobalKit sharedInstance] wealthImageString:count1];
    headView.userLevelImage.image = [UIImage sd_animatedGIFNamed:weathGradeImage];
    headView.starLevelmage.image = [[DataGlobalKit sharedInstance] anchorImage:count];
    
    if (self.isAnchor) {
        headView.starLevelLabel.text = [NSString stringWithFormat:@"明星等级排名：%ld",(long)count];
        if (self.currentUser.bean_rank == -1) {
            headView.starLevelLabel.text = [NSString stringWithFormat:@"明星等级排名：暂无排名"];
        } else {
            headView.starLevelLabel.text = [NSString stringWithFormat:@"明星等级排名：%zd",self.currentUser.bean_rank];
        }
    } else {
        if (self.currentUser.rank==-1) {
            headView.starLevelLabel.text = [NSString stringWithFormat:@"富豪等级排名：暂无排名"];
        }else{
            headView.starLevelLabel.text = [NSString stringWithFormat:@"富豪等级排名：%ld",(long)self.currentUser.rank];
        }
    }

//    Family *family = [[Family alloc] initWithAttributes:self.currentUser.family];
//    
//    NSString *str = family.badge_name;
//    if ([str isEqualToString:@""]||str==nil) {
//        self.headView.paimingView.familyName.text = @"暂无家族";
//        self.headView.paimingView.widht.constant = 80;
//        self.headView.paimingView.familyImage.hidden = YES;
//        [self.headView.paimingView.familyName needsUpdateConstraints];
//        self.headView.paimingView.familyName.textColor = kRGBA(0, 0, 0, 0.8);
//        self.headView.paimingView.familyNumbel.hidden = YES;
//    }else{
//        self.headView.paimingView.familyName.text = [family.badge_name stringByUnescapingFromHTML];
//    }
//    [self setupFamily];
}

-(void)setupFamily
{
//    [self.dataManager.remote retrieveFamilyListcompletianString:^(NSArray *array, NSError *error) {
//        
//    }];
}

-(void)setupSegment
{
    if (self.currentUser._id == self.me._id || !self.currentUser._id) {
        return;
    }
    if (!self.segmentView) {
        self.segmentView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight-kTabBarHeight, kScreenWidth, kTabBarHeight)];
        self.segmentView.alpha = 0.95;
        [self.view addSubview:self.segmentView];
        for (int i = 0; i<self.titles.count; i++) {
            SegmentBtnView *btn = [[SegmentBtnView alloc] init];
            btn.frame = CGRectMake(0+i*kScreenWidth/self.titles.count, 0, kScreenWidth/self.titles.count, 49);
            btn.segmentLabel.text = self.titles[i];
            btn.backgroundColor = kRGB(80, 72, 75);
            btn.tag = kSegmentViewTag+i;
            btn.delegete = self;
            [self.segmentView addSubview:btn];
        }
    }else{
        for (int i = 0; i<self.titles.count; i++) {
            SegmentBtnView *btn = (SegmentBtnView*)[self.view viewWithTag:kSegmentViewTag+i];
            btn.segmentLabel.text = self.titles[i];
        }
    }
}

-(void)segmentBtnClick:(NSInteger)flag
{
    SegmentBtnView *seg = (SegmentBtnView*)[self.view viewWithTag:flag];
    seg.segmentLabel.textColor = kWhiteColor;
    
    if (!self.dataManager.global.isUserlogin)
    {
        [self showLoginTipActionSheet];
        return;
    }
    if (self.isAnchor) {
        switch (flag-kSegmentViewTag) {
            case 0:
            {
                TTShowRoom *room = [[TTShowRoom alloc] init];
                room.live = self.currentUser.live;
                room.nick_name = self.currentUser.nick_name;
                room._id = self.currentUser._id;
                room.pic_url = self.currentUser.pic;
                if (self.flag==3) {
                    [self.delegate guanzhuVideoBack:room];
                    [self.navigationController popViewControllerAnimated:YES];
                    return;
                }
                [self.uiManager showRoomVideoEnterType:kVideoEnterOther controller:self room:room];
            }
                break;
//            case 1:
//            {
//                [self followStar];
//            }
//                break;
//            case 2:
//            {
//                if (!self.isFriend) {
//                    [self.dataManager.remote _requestAddFriend:self.currentUser._id completion:^(BOOL success, NSError* error) {
//                        if (success) {
//                            [UIAlertView showInfoMessage:@"申请发送成功"];
//                        } else {
//                            if (error && [[DataGlobalKit sharedInstance] authorityNotEnoughWithCode:[error code]]) {
//                                [UIAlertView showInfoMessage:@"至少要一富才能添加好友"];
//                            } else {
//                                [UIAlertView showInfoMessage:@"加好友失败"];
//                            }
//                        }
//                    }];
//                }else{
//                    [self showFriendChatUI:self friendID:self.currentUser._id];
//                }
//            }
//                break;
            default:
                break;
        }
    }
    else
    {
        switch (flag-kSegmentViewTag) {
            case 0:
            {
                if (!self.isFriend) {
                    [self.dataManager.remote _requestAddFriend:self.currentUser._id completion:^(BOOL success, NSError* error) {
                        if (success) {
                            [UIAlertView showInfoMessage:@"申请发送成功"];
                        } else {
                            if (error && [[DataGlobalKit sharedInstance] authorityNotEnoughWithCode:[error code]]) {
                                [UIAlertView showInfoMessage:@"至少要一富才能添加好友"];
                            } else {
                                [UIAlertView showInfoMessage:@"加好友失败"];
                            }
                        }
                    }];
                }else{
                    //                TTShowFriend *chargeRecord = [[TTShowFriend alloc] init];
                    //                chargeRecord._id = self.currentUser._id;
                    //                chargeRecord.pic = self.currentUser.pic;
                    //                chargeRecord.nick = self.currentUser.nick_name;
                    //                chargeRecord.finance = self.currentUser.finance;
                    
                    [self showFriendChatUI:self friendID:self.currentUser._id];
                }
            }
                break;
            default:
                break;
        }
    }
}

- (void)showFriendChatUI:(UIViewController *)v friendID:(NSInteger)friendID
{
    //    [self showStatusBar];
//    FriendChatViewController *taskController = [[FriendChatViewController alloc] initWithNibName:@"FriendChatViewController" bundle:nil];
//    taskController.friendID = friendID;
//    NavigationController *nav = [[NavigationController alloc] initWithRootViewController:taskController];
//    [v presentViewController:nav animated:YES completion:nil];
}

#pragma mark - Favor star.

- (void)followStar
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
        [cancelFavor show];
        return;
    }
    [self.dataManager.remote followingForStar:self.currentUser._id add:!self.isFollowStar completion:^(BOOL success, NSError *error) {
        if (success)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (self.isFollowStar)
                {
                    [self.dataManager.defaults delFollowStar:self.currentUser._id];
                    //                    [UIAlertView showInfoMessage:@"取消关注成功"];
                }
                else
                {
                    [self.dataManager.defaults addFollowStar:self.currentUser._id];
                    [self recordFirstFavorStar];
                    //                    [UIAlertView showInfoMessage:@"关注成功"];
                    [self.uiManager.global showMessage:@"关注主播成功,您可以收到该主播的开播通知" in:self disappearAfter:1.5f];
                }
                [self setupSegmentTitle];
            });
        }
    }];
}

- (void)recordFirstFavorStar
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self.dataManager.filter setFirstFavorStar:YES];
    });
}


- (void)cancelFavorStar
{
    [self.dataManager.remote followingForStar:self.currentUser._id add:!self.isFollowStar completion:^(BOOL success, NSError *error) {
        if (success)
        {
            if (self.isFollowStar)
            {
                [self.dataManager.defaults delFollowStar:self.currentUser._id];
            }
            // Notify update.
//            [self setupNavigationRightEvent];
            [self setupSegmentTitle];
        }
    }];
}

-(void)setupSegmentTitle
{
    [self retrieveFavorStatus];
}

- (void)showLoginTipActionSheet
{
    UIActionSheet *as = [[UIActionSheet alloc] initWithTitle:@"请登录后操作" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"登录", nil];
    [as showInView:self.navigationController.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(actionSheet == self.menuActionSheet) {
        switch (buttonIndex)
        {
            case 0:
            {
                UIActionSheet *as = [[UIActionSheet alloc] initWithTitle:@"确认解除好友关系?"
                                                                delegate:self
                                                       cancelButtonTitle:@"取消"
                                                  destructiveButtonTitle:@"解除"
                                                       otherButtonTitles:nil, nil];
                as.tag = 1;
                [as showInView:self.navigationController.view];
            }
                break;
            case 1:
            {
                UIActionSheet *as = [[UIActionSheet alloc] initWithTitle:@"确认加入黑名单?" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"确定" otherButtonTitles:nil, nil];
                as.tag = 2;
                [as showInView:self.navigationController.view];
            }
                break;
            default:
                break;
        }
    } else  {
        switch (actionSheet.tag)
        {
            case 0:
            {
                switch (buttonIndex)
                {
                    case 0:
                        [self.dataManager.remote _delFriend:self.currentUser._id completion:^(BOOL success, NSError *error) {
                            if (success) {
                                //
                            } else {
                                [UIAlertView showInfoMessage:@"解除好友关系失败，请检查网络"];
                            }
                        }];
                        break;
                    default:
                        break;
                }
            }
                break;
            case 1:
            {
                switch (buttonIndex)
                {
                    case 0:
                        [self.dataManager.remote _addFriendToBlacklist:self.currentUser._id completion:^(BOOL success, NSError *error) {
                            if (success) {
                                //
                            } else {
                                [UIAlertView showInfoMessage:@"添加好友到黑名单失败，请检查网络"];
                            }
                        }];
                        break;
                    default:
                        break;
                }
            }
                break;
            default:
                break;
        }
    }

//    if (!buttonIndex) {
//        MoreLogInViewController *more = [[MoreLogInViewController alloc] init];
//        more.flag = 2;
//        
//        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:more];
//        
//        [[UIApplication sharedApplication] endReceivingRemoteControlEvents];
//        
//        [self presentViewController:nav animated:YES completion:^{
//            
//        }];
//    }
}

- (void)retrieveFavorStatus
{
    NSInteger starid = self.currentUser._id;
    if (starid == 0)
    {
        starid = self.currentRoom._id;
    }
    self.isFollowStar = [self.dataManager.defaults hasFollowStar:starid];
    
    if (self.currentUser._id == self.me._id) {
        return;
    }
    
    [self setupTitles];
    
//    [self setupSegment];
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == kAlertViewCancelButtonIndex)
    {
        return;
    }

    [self cancelFavorStar];
}

#pragma mark - UIAlertViewDelegate


#pragma mark - PersonalHomeHeaderViewDelegate

- (void)cancelWatchBtnTapped:(UIButton *)sender headerView:(PersonalHomeHeadView *)headerView
{
    [self followStar];
}

- (void)addFriendsBtnTapped:(UIButton *)sender headerView:(PersonalHomeHeadView *)headerView
{
    [self addFriends];
}

- (void)relationBtnTapped:(UIButton *)sender
{
    // 弹出窗口，提示处理好友关系
    self.menuActionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                         destructiveButtonTitle:nil
                                              otherButtonTitles:@"删除好友" , @"加入黑名单", nil];
    [self.menuActionSheet showFromTabBar:self.tabBarController.tabBar];
}

#pragma mark - AnchorHeaderViewDelegate

- (void)photoWallBtnTapped:(UIButton *)btn ahchorHeaderView:(AnchorHederView *)headerView
{
    [self.bgScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    [headerView.photoWallBtn setTitleColor:[UIColor colorWithHexString:@"#FFC107" alpha:1.0] forState:UIControlStateNormal];
    [headerView.profileBtn setTitleColor:[UIColor colorWithHexString:@"#333333" alpha:1.0] forState:UIControlStateNormal];
}

- (void)profileBtnTapped:(UIButton *)btn anchorHeaderView:(AnchorHederView *)headerView
{
    [self.bgScrollView setContentOffset:CGPointMake(kScreenWidth, 0) animated:YES];
    [headerView.photoWallBtn setTitleColor:[UIColor colorWithHexString:@"#333333" alpha:1.0] forState:UIControlStateNormal];
    [headerView.profileBtn setTitleColor:[UIColor colorWithHexString:@"#FFC107" alpha:1.0] forState:UIControlStateNormal];
}

#pragma mark - UITableViewDataSource & UITableVieDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.profileArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.profileArray[section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (0 == section) {
        return 12.f;
    } else {
        return 28.f;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.section == 1 && indexPath.row == 2) {
        static NSString *badgeCellID = @"BadgeCell";
        BadgeCell *cell = [tableView dequeueReusableCellWithIdentifier:badgeCellID];
        if (!cell) {
            cell = [[[NSBundle SDKResourcesBundle] loadNibNamed:@"BadgeCell" owner:nil options:nil] firstObject];
        }
        [cell setBadges:self.badgeList];
        [self.uiManager.global set4CornerBGCell:cell];
        return cell;
    } else {
        ProfileCell *cell = [tableView dequeueReusableCellWithIdentifier:profileCellID];
        if (!cell) {
            cell = [[[NSBundle SDKResourcesBundle] loadNibNamed:@"ProfileCell" owner:nil options:nil] lastObject];
        }
        cell.textLabel.text = self.profileArray[indexPath.section][indexPath.row];
        cell.carList = self.ownedCar;
        [cell setupProfileWithInfo:self.currentUser indexPath:indexPath];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1 && indexPath.row == 2) {
        // TODO 跳转到 徽章页面
        HonorViewController *honorVC = [[HonorViewController alloc] initWithNibName:@"HonorViewController" bundle:[NSBundle SDKResourcesBundle]];
        honorVC.badgeList = self.badgeList;
        honorVC.currentUserId = self.currentUser._id;
        [self.navigationController pushViewController:honorVC animated:YES];
    }
}

#pragma mark - Setter/Getter

- (UIScrollView *)bgScrollView
{
    if (!_bgScrollView) {
        
        _bgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, (self.isAnchor ? self.anchorHeaderView.bottom : self.topView.bottom), kScreenWidth, kScreenHeight - (self.isAnchor ? self.anchorHeaderView.bottom : self.topView.bottom))];
        _bgScrollView.contentSize = CGSizeMake(kScreenWidth * (self.isAnchor ? 2 : 1), kScreenHeight - (self.isAnchor ? self.anchorHeaderView.bottom : self.topView.bottom));
        _bgScrollView.pagingEnabled = YES;
        _bgScrollView.showsHorizontalScrollIndicator = NO;
        _bgScrollView.delegate = self;
    }
    return _bgScrollView;
}

- (PersonalHomeHeadView *)topView
{
    if (!_topView) {
        _topView = [[[NSBundle SDKResourcesBundle] loadNibNamed:@"PersonalHomeHeadView" owner:nil options:nil] lastObject];
        _topView.delegate = self;
    }
    return _topView;
}

- (AnchorHederView *)anchorHeaderView
{
    if (!_anchorHeaderView) {
        _anchorHeaderView = [[[NSBundle SDKResourcesBundle] loadNibNamed:@"AnchorHederView" owner:nil options:nil] lastObject];
        _anchorHeaderView.delegate = self;
        _anchorHeaderView.frame = CGRectMake(0, (self.isAnchor ? 212 : 212 - 38), kScreenWidth, 40);
    }
    return _anchorHeaderView;
}

- (UITableView *)profileTableView
{
    if (!_profileTableView) {
        _profileTableView = [[UITableView alloc] initWithFrame:CGRectMake((self.isAnchor ? kScreenWidth : 0), 0, kScreenWidth, self.bgScrollView.height) style:UITableViewStyleGrouped];
        _profileTableView.showsVerticalScrollIndicator = NO;
        self.profileTableView.delegate = self;
        self.profileTableView.dataSource = self;
    }
    return _profileTableView;
}

- (UICollectionView *)photoWallCollectionView
{
    if (!_photoWallCollectionView) {
//        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//        layout.sectionInset = UIEdgeInsetsMake(16, 16, 16, 16);
//        layout.minimumLineSpacing = 16;
//        layout.minimumInteritemSpacing = 16;
//        
        self.layout = [[CHTCollectionViewWaterfallLayout alloc] init];
        self.layout.sectionInset = UIEdgeInsetsMake(16, 16, 16, 16);
        self.layout.minimumColumnSpacing = 16;
        self.layout.minimumInteritemSpacing = 16;
//        self.layout.headerHeight = 0;
//        self.layout.footerHeight = 49;
        
//        self.personalCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, -20, kScreenWidth, kScreenHeight+20) collectionViewLayout:self.layout];
//        self.personalCollection.dataSource = self;
//        self.personalCollection.delegate = self;
//        self.personalCollection.backgroundColor = kCommonBgColor;
        _photoWallCollectionView = [[UICollectionView alloc] initWithFrame:self.bgScrollView.bounds collectionViewLayout:self.layout];
        _photoWallCollectionView.delegate = self;
        _photoWallCollectionView.dataSource = self;
        _photoWallCollectionView.backgroundColor = kCommonBgColor;
    }
    return _photoWallCollectionView;
}

- (NSArray *)profileArray
{
    if (!_profileArray) {
        _profileArray = @[@[@"昵称", @"性别", @"星座", @"城市"], @[@"家族", @"座驾", @"荣誉"]];
    }
    return _profileArray;
}

#pragma mark - Private Methods

- (void)retrieveCarList
{
    __weak __typeof(self) weakSelf = self;
    [self.dataManager.remote retrieveCarList:^(NSArray *array1, NSArray *array2, NSError *error) {
        if (array1 && !error)
        {
            if (!weakSelf.allCarList) {
                NSMutableArray *allCar = [[NSMutableArray alloc] init];
                weakSelf.allCarList = allCar;
            } else {
                [weakSelf.allCarList removeAllObjects];
            }
            [weakSelf.allCarList addObjectsFromArray:array1];
        }
    }];
}

- (void)retrieveCurrentUserAllCar
{
    NSArray *ownedCarIDArray = [self.currentUser.car allKeys];
    NSMutableArray *tempOwnedCar = [NSMutableArray array];
    for (TTShowCar *car in self.allCarList) {
        for (NSNumber *ownedCarID in ownedCarIDArray) {
            if (car._id == [ownedCarID integerValue]) {
                [tempOwnedCar addObject:car];
            }
        }
    }
    self.ownedCar = [NSArray arrayWithArray:tempOwnedCar];
    [self.profileTableView reloadData];
}

- (void)retrieveUserBadge
{
    [self.dataManager.remote retrieveUserBadge:self.currentUser._id completion:^(NSArray *array, NSError *error) {
        if (error == nil)
        {
            if (self.badgeList == nil)
            {
                self.badgeList = [[NSMutableArray alloc] init];
            }
            [self.badgeList removeAllObjects];
            
            //            // deal with results.
            //            NSArray *results = [array filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF.award = YES"]];
            
            [self.badgeList addObjectsFromArray:array];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.profileTableView reloadData];
        });
    }];
}

- (void)addFriends
{
    if (!self.isFriend) {
        [self.dataManager.remote _requestAddFriend:self.currentUser._id completion:^(BOOL success, NSError* error) {
            if (success) {
                [UIAlertView showInfoMessage:@"申请发送成功"];
            } else {
                if (error && [[DataGlobalKit sharedInstance] authorityNotEnoughWithCode:[error code]]) {
                    [UIAlertView showInfoMessage:@"至少要一富才能添加好友"];
                } else {
                    [UIAlertView showInfoMessage:@"加好友失败"];
                }
            }
        }];
    }else{
        [self showFriendChatUI:self friendID:self.currentUser._id];
    }
}

@end
