//
//  TheHallViewController.m
//  memezhibo
//
//  Created by Xingai on 15/5/22.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "TheHallViewController.h"
#import "TheHallViewController+Table.h"
#import "TTShowDataManager.h"
#import "TTShowMainImageList.h"
#import "MainHeadCell.h"
#import "TheHallViewController+SearchBar.h"
#import "ActivityViewController.h"
#import "TTShowRemote+TheHall.h"

#define kMainRoomListResultPageSize (50)


@interface TheHallViewController ()<UIGestureRecognizerDelegate,noDataDelegate>
{
    UIView *_backgroundView;
}

@end

@implementation TheHallViewController

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    if (self.curSelectedCell1)
    {
        [self.curSelectedCell1 deselectCellWithAnimated:YES];
    }
    if (self.curSelectedCell2)
    {
        [self.curSelectedCell2 deselectCellWithAnimated:YES];
    }
    if (self.curSelectedCell3)
    {
        [self.curSelectedCell3 deselectCellWithAnimated:YES];
    }
    self.navigationController.navigationBarHidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
}

-(void)loadView
{
    self.view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    self.view.backgroundColor = [UIColor clearColor];
    [MainHeadCell class];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = kCommonBgColor;
    [self setupSegmentController];
    
//    [self setupNavView];
//    [self setupLeftBtnAction:@selector(goBack:)];

    [self setupScrollView];
    
    [self statusContent];
    [self setupTheHallTable];
    
    [self setupHitTable];
    [self setupXiaowoTable];
    
    [self remoteWallpaper];
    [self retrieveRoomList:NO];
    [self remoteXinren];
    
    [self retrieveHitToLoveList:NO];
    
//    [self setupRoomSheachView];
    
    [self setSearchBarView];
    
    if (self.isAnchor) {
        [self retrieveMyXiaowoInfo];
    }
}

- (void)goBack:(UIControl *)backBtn
{
    if (self.presentingViewController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)setupRoomSheachView
{
    self.roomSheachView = [[RoomSheachView alloc] init];
    self.roomSheachView.frame = CGRectMake(0, kNavigationBarHeight, kScreenWidth, 32);
    [self.view addSubview:self.roomSheachView];
}

-(void)retrieveMyXiaowoInfo
{
    [self showProgress:@"正在载入..." animated:YES];
    [self.dataManager.remote retrieveMyXiaowoInfo:^(TTShowXiaowoInfo *xiaowo, NSError *error)
     {
         if(xiaowo != nil){
             self.currentXiaowoInfo = xiaowo;
             
             [self.xiaoWoTableView reloadData];
         }
         
         [self hideProgressWithAnimated:YES];
         
     }];
}

- (void)setupScrollView
{
    self.mainScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kNavigationBarHeight, kScreenWidth, kScreenHeight-kNavigationBarHeight)];
}

- (void)remoteWallpaper
{
    if (self.noDataView) {
        self.noDataView.view.hidden = YES;
    }
    [self showProgress:@"正在载入…" animated:YES];
    [self.dataManager.remote retrieveTheHallimage:^(NSArray *array, NSError *error) {
        [self hideProgressWithAnimated:YES];
        if (!error&&array&&self.flag!=array.count) {
            if (array) {
                self.flag = array.count;
                [self.imageList removeAllObjects];
                [self.imageList addObjectsFromArray:array];
                if (self.roomList.count!=0) {
                    if (self.noDataView) {
                        self.noDataView.view.hidden = YES;
                    }
                }
            }else{

            }
        }
    }];
    
}

-(void)remoteXinren
{
    if (self.noDataView) {
        self.noDataView.view.hidden = YES;
    }
    
    [self showProgress:@"正在载入…" animated:YES];
    [self.dataManager.remote remoteXinrenList:^(NSArray *array, NSError *error) {
        [self hideProgressWithAnimated:YES];
        if (!error&&array) {
            [self.xinrenList removeAllObjects];
            [self.xinrenList addObjectsFromArray:array];
            [self.mainTableView reloadData];
        }else{
            
        }
    }];
}

- (void)showAgreement
{
    if (!self.dataManager.defaults.showAgreement)
    {
        [self.uiManager showAgreement:^(CustomIOS7AlertView *alertView, NSInteger buttonIndex) {
            self.dataManager.defaults.showAgreement = YES;
        }];
    }
}

-(void)statusContent
{
    isHasNoDataArray = [NSMutableArray arrayWithObjects:@(NO), @(NO), nil];
    isloadingMoreArray = [NSMutableArray arrayWithObjects:@(NO), @(NO), nil];
    currentPageNumberArray = [NSMutableArray arrayWithObjects:@(1), @(1), nil];
    
    self.imageList = [NSMutableArray arrayWithCapacity:0];
    self.commendationList = [NSMutableArray arrayWithCapacity:0];
    self.tempArray = [NSMutableArray arrayWithCapacity:0];
    self.xinrenList = [NSMutableArray arrayWithCapacity:0];
    self.roomList = [NSMutableArray arrayWithCapacity:0];
    
    TTShowUser *user = [TTShowUser unarchiveUser];
    self.isAnchor = (user.priv == kUserPrivAnchor);
}

-(void)setupSegmentController
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];

    
    CCSegmentedControl* segmentedControl = [[CCSegmentedControl alloc] initWithItems:
                                            @[@"大厅",@"房间"]];
    
    
    //设置背景图片，或者设置颜色，或者使用默认白色外观
    segmentedControl.backgroundColor = kNavigationMainColor;
    segmentedControl.alpha = 1.0;
    
    //阴影部分图片，不设置使用默认椭圆外观的stain
    segmentedControl.selectedStainView = nil;
    
    segmentedControl.selectedSegmentTextColor = kRGB(255,255,255);
    segmentedControl.segmentTextColor = kRGBA(255,255,255,0.5);
    [segmentedControl addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:segmentedControl];
    segmentedControl.frame = CGRectMake(0, 0, kScreenWidth, 64);
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:kImageNamed(@"back") forState:UIControlStateNormal];
    [leftBtn setImage:kImageNamed(@"bac_按下") forState:UIControlStateHighlighted];
    [leftBtn setTitle:@"返回" forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftBtn];
    leftBtn.frame = kCGRectMake(0, 15.0f*320/kScreenWidth, 75, 50.0f);
}

- (void)rightButtonPressed:(UIButton *)button
{
    self.curRoomShowMode = kRoomShowSearchMode;
    self.ShadowView.hidden = NO;
    [self.search.field becomeFirstResponder];
    [UIView animateWithDuration:0.3f animations:^{
        self.search.frame = CGRectMake(0, 0, kScreenWidth, kNavigationBarHeight);
    }];
}

- (void)leftButtonPressed:(UIButton *)btn
{
    if (self.presentingViewController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)valueChanged:(id)sender
{
    CCSegmentedControl* segmentedControl = sender;
    self.curSortType = segmentedControl.selectedSegmentIndex;
    
    self.tempFlag = self.curSortType;
    
    switch (self.tempFlag) {
        case kRoomSortDefault:
        {

            self.HitToLoveTableView.hidden = YES;
            self.xiaoWoTableView.hidden = YES;
            self.mainTableView.hidden = NO;
            [self retrieveHitToLoveList:NO];
            [self retrieveRoomList:NO];
            [self remoteWallpaper];

            self.curRoomShowMode = kRoomShowDefaultMode;
        }
            break;
        case kRoomSortHot:
        {
            self.HitToLoveTableView.hidden = NO;
            self.mainTableView.hidden = YES;
            self.xiaoWoTableView.hidden = YES;
            [self retrieveHitToLoveList:NO];
            self.curRoomShowMode = kRoomShowSearchMode;
        }
            break;
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)retrieveXiaowo:(BOOL)loadMore
{

    [self showProgress:@"正在载入..." animated:YES];

    NSInteger page = loadMore ? self.xiaoWoList.count / 20 + 1: 1;
    [self.dataManager.remote retrievePublic:page Size:20 completion:^(NSArray *array, NSError *error)
     {
         if (loadMore) {
             [self hideProgressWithAnimated:YES];
         }
         
         if (array && !error)
         {
             if (!self.xiaoWoList) {
                 self.xiaoWoList = [[NSMutableArray alloc] initWithCapacity:0];
             }
             if (loadMore) {
                 [self.xiaoWoList removeObjectsInArray:array];
             } else {
                 [self.xiaoWoList removeAllObjects];
             }
             
             [self.xiaoWoList addObjectsFromArray:array];
             if (array.count < 20)
             {
                 self.hasNoData = YES;
                 [self.loadMore3 setFooterFinish];
             } else {
                 self.hasNoData = NO;
             }
             
             if (loadMore && self.isLoadingMore) {
                 self.isLoadingMore = NO;
             }
             
         }
         [self.systemRefreshView3 endRefreshing];
         [self stopRefresh];
         [self hideProgressWithAnimated:YES];
     }];
}

- (void)stopRefresh
{
    self.isLoading = NO;
    self.loadFinished = YES;
    
    
    if (self.xiaoWoTableView != nil)
    {
        [self.xiaoWoTableView reloadData];
    }
}

//关注主播
- (void)retrieveFavorStar
{
    [self showProgress:@"正在载入…" animated:YES];
    [self.dataManager.remote followingListWithCompletion:^(NSArray *array, NSError *error) {
        [self hideProgressWithAnimated:YES];
        if (!error&&array.count>0)
        {
            // Data.
            if (!self.roomList)
            {
                self.roomList = [NSMutableArray arrayWithCapacity:0];
            }
            else
            {
                [self.roomList removeAllObjects];
            }
            
            NSMutableArray *roomList = [NSMutableArray arrayWithCapacity:0];
            for (TTShowFollowRoomStar *roomStar in array)
            {
                TTShowRoom *room = [[TTShowRoom alloc] initWithFollowStar:roomStar];
                [roomList addObject:room];
            }
            
            
            NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"live" ascending:NO];
            NSArray *sortArray = [NSArray arrayWithObjects:descriptor,nil];
            
            NSArray *sortedArray = [roomList sortedArrayUsingDescriptors:sortArray];
            
            
            [self.roomList addObjectsFromArray:sortedArray];
//            [self.roomList addObjectsFromArray:roomList];
            [self.HitToLoveTableView reloadData];
            if (self.systemRefreshView2) {
                [self.systemRefreshView2 endRefreshing];
            }
            
            if (self.roomList.count==0) {
                if (!self.noDataView) {
                    self.noDataView = [[noDataViewController alloc] init];
                    self.noDataView.view.frame = CGRectMake(0, kNavigationBarHeight, kScreenWidth, kScreenHeight-kNavigationBarHeight);
                    [self.view addSubview:self.noDataView.view];
                }else{
                    self.noDataView.view.hidden = NO;
                }
            }else{
                self.noDataView.view.hidden = YES;
            }
            [self.noDataView setupImage:0];
        }
        else
        {
            if (!self.noDataView) {
                self.noDataView = [[noDataViewController alloc] init];
                self.noDataView.view.frame = CGRectMake(0, kNavigationBarHeight, kScreenWidth, kScreenHeight-kNavigationBarHeight);
                [self.view addSubview:self.noDataView.view];
            }else{
                self.noDataView.view.hidden = NO;
            }
            
            if ([self.dataManager.global isUserlogin]==0) {
                [self.noDataView setupImage:5];
            }else{
//                [self.noDataView setupImage:2];
            }
        }
    }];
}


- (void)retrieveRoomList:(BOOL)loadMore
{
    [self showProgress:@"正在载入…" animated:YES];
    [self.dataManager.remote recommendationList:^(NSArray *array, NSError *error) {
        [self hideProgressWithAnimated:YES];
        if (!error&&array.count>0) {
            [self.tempArray removeAllObjects];
            [self.commendationList removeAllObjects];
            [self.tempArray addObjectsFromArray:array];
            for (NSDictionary *carDict in self.tempArray[0])
            {
                TTShowRecommendation *recommendation = [[TTShowRecommendation alloc]initWithAttributes:carDict];
                [self.commendationList addObject:recommendation];
            }

            if (self.roomList.count!=0) {
                if (self.noDataView) {
                    self.noDataView.view.hidden = YES;
                }
            }
            [self.mainTableView reloadData];
        }else{

        }
    }];
    
    
}

-(void)retrieveHitToLoveList:(BOOL)loadMore
{
    if (!loadMore)
    {
        kMainSetCurrentPageNumber(1);
        [self.roomList removeAllObjects];
    }
    
    self.loadingData = YES;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:0];

    if (self.curRoomShowMode == kRoomShowSearchMode)
    {
        if (self.keywords && ![self.keywords isEqualToString:@""])
        {
            if ([self.keywords isAllDigit])
            {
                [params setObject:@([self.keywords integerValue]) forKey:@"room_id"];
            }
            else
            {
                [params setObject:self.keywords forKey:@"nick_name"];
            }
        }
    }
    
    [params setObject:@(kMainCurrentPageNumber) forKey:@"page"];
    [params setObject:@(kMainRoomListResultPageSize) forKey:@"size"];
    [params setObject:@(self.curSortType) forKey:@"sort"];
    [self showProgress:@"正在载入…" animated:YES];
    [self.dataManager.remote retrieveRoomListWithParams:params completion:^(NSArray *array, NSError *error) {
        if (!error&&array.count>0) {
            [self.roomList removeObjectsInArray:array];
            [self.roomList addObjectsFromArray:array];
            if (self.roomList.count == 0)
            {
                if (self.curSortType==0) {
                    [self.loadMore1 setFooterFinish];
                }
                else
                {
                    [self hideNoContentTip];
                }
                
                if (self.curSortType==1) {
                    [self.loadMore2 setFooterFinish];
                }
                else
                {
                    [self hideNoContentTip];
                }
                if (!self.noDataView) {
                    self.noDataView = [[noDataViewController alloc] init];
                    self.noDataView.view.frame = CGRectMake(0, kNavigationBarHeight, kScreenWidth, kScreenHeight-kNavigationBarHeight);
                    [self.view addSubview:self.noDataView.view];
                }else{
                    self.noDataView.view.hidden = NO;
                }
                [self.noDataView setupImage:4];
            }else{
                if (self.noDataView) {
                    self.noDataView.view.hidden = YES;
                }
            }
            if (!self.search.frame.origin.y!=0.0f) {
                self.search.ResultLabel.text = [NSString stringWithFormat:@"%lu个结果",(unsigned long)self.roomList.count];
            }
            kMainSetIsHasNoData(array.count < kMainRoomListResultPageSize);
        }else{
            if (self.roomList)
            {
                [self.roomList removeAllObjects];
            }
            
//            if (!self.noDataView) {
//                self.noDataView = [[noDataViewController alloc] init];
//                self.noDataView.view.frame = CGRectMake(0, kNavigationBarHeight, kScreenWidth, kScreenHeight-kNavigationBarHeight);
//                [self.view addSubview:self.noDataView.view];
//            }else{
//                self.noDataView.view.hidden = NO;
//            }
//            [self.noDataView setupImage:2];
        }
        [self refreshUI:loadMore];
    }];
}


- (void)refreshUI:(BOOL)loadMore
{
    if (self.systemRefreshView1)
    {
        [self.systemRefreshView1 endRefreshing];
    }
    if (self.systemRefreshView2) {
        [self.systemRefreshView2 endRefreshing];
    }
    
    if (self.curSortType==0)
    {
        if (self.mainTableView != nil)
        {
            [self.mainTableView reloadData];
        }
    }
    if (_curSortType==1){
        if (self.HitToLoveTableView!=nil) {
            [self.HitToLoveTableView reloadData];
        }
    }
    
    kMainSetIsloadingMore(NO);
    [self hideProgressWithAnimated:YES];
    self.loadingData = NO;
}


#pragma mark - Hide Or Show Controls

- (void)hideControls
{
    // Hide tabs.
    [self.uiManager.global hideTabBar:self.tabBarController completion:^{
    }];

}

- (void)showControls
{
    // Show tabs.
    [self.uiManager.global showTabBar:self.tabBarController completion:^{
    }];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)checkNetWork
{
    self.noDataView.view.hidden = YES;
    
    [self reloadTable];

}

#pragma mark - Notification

- (void)playPushWithUsrInfo:(NSDictionary *)userInfo
{
    
    if ([userInfo isKindOfClass:[NSDictionary class]] && userInfo) {
        NSNumber *roomID = [userInfo objectForKey:@"room_id"];
        if ([roomID isKindOfClass:[NSNumber class]] && roomID) {
            [self.dataManager.remote retrieveUserInfo:[roomID integerValue] completion:^(TTShowUser *user, NSError *error) {
                
                if (!error) {
                    TTShowRoom *room = [[TTShowRoom alloc] init];
                    room.live = user.live;
                    room.nick_name = user.nick_name;
                    room._id = user._id;
                    room.pic_url = user.pic;
                    
                    if (room.live) {
                        // First Check Kick out?
                        [self showProgress:@"正在载入..." animated:YES];
                        [self.dataManager.remote retrieveKickTtl:room._id completion:^(NSInteger count, NSError *error) {
                            if (error == nil) {
                                if (count <= 0) {
                                    [self.uiManager showRoomVideoEnterType:kVideoEnterMain controller:self room:room];
                                } else  {
                                    [UIAlertView showInfoMessage:[NSString stringWithFormat:@"已被踢出房间,%ld秒后再进", (long)count]];
                                }
                            } else {
                                // Not Login.
                                [self.uiManager showRoomVideoEnterType:kVideoEnterMain controller:self room:room];
                            }
                            [self hideProgressWithAnimated:YES];
                        }];
                    }
                }
            }];
        }
    }

}

- (void)playAnchorFormPushWithInfoNotify:(NSNotification *)notify
{
    NSDictionary *userInfo = [notify userInfo];
    [self playPushWithUsrInfo:userInfo];
}

- (void)playAnchorFormPushWithInfo:(NSDictionary *)userInfo
{
    [self playPushWithUsrInfo:userInfo];
}

@end
