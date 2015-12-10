//
//  RankListDetailsViewController.m
//  memezhibo
//
//  Created by Xingai on 15/6/2.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "RankListDetailsViewController.h"
#import "RankListDetailsViewController+Delegate.h"
#import "RankListDetailsViewController+Datasource.h"

#define kRichListCount (10)

@interface RankListDetailsViewController ()

@end

@implementation RankListDetailsViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setupNavView];
    [self setupLeftBtnAction:@selector(goback:)];
    if (self.flag!=2) {
        [self.backBtn setTitle:@"探索" forState:UIControlStateNormal];
    }else{
        [self.backBtn setTitle:@"直播" forState:UIControlStateNormal];
    }
    
    
    self.titleLabel.text = self.navTitle;
    [self setupTitles];
    [self setupTableView];

    if (self.flag==0) {
        __weak typeof(self) weakSelf = self;                self.navigationController.interactivePopGestureRecognizer.delegate = weakSelf;
        //判断是否为第一个view
        if (self.navigationController && [self.navigationController.viewControllers count] == 1) {
            self.navigationController.interactivePopGestureRecognizer.enabled = NO;
        }
        [self retrieveAnchorListFromRemote];
    }
    else if (self.flag==1)
    {
        __weak typeof(self) weakSelf = self;                self.navigationController.interactivePopGestureRecognizer.delegate = weakSelf;
        //判断是否为第一个view
        if (self.navigationController && [self.navigationController.viewControllers count] == 1) {
            self.navigationController.interactivePopGestureRecognizer.enabled = NO;
        }
        [self retrieveRichListFromRemote];
    }else{
        
        [self retrieveLiveSpentMost];
    }
    
    [self setupSegment];
}

//**************方法一****************//
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    return YES;
}

-(void)setupTitles
{
    self.rankList = [NSMutableArray arrayWithCapacity:0];
    if (self.flag!=2) {
        self.titles = @[@"日榜",@"周榜",@"月榜",@"总榜"];
    }else{
        self.titles = @[@"本场榜",@"30天榜",@"超级粉丝榜"];
    }
}


-(void)setupSegment
{
    self.segmentView = [[UIView alloc] initWithFrame:CGRectMake(0,kScreenHeight-kTabBarHeight, kScreenWidth, kTabBarHeight)];
    self.segmentView.alpha = 0.95;
    [self.view addSubview:self.segmentView];
    
    
    if (self.flag!=2) {
        for (int i = 0; i<4; i++) {
            SegmentBtnView *btn = [[SegmentBtnView alloc] init];
            btn.frame = CGRectMake(0+i*kScreenWidth/4.0, 0, kScreenWidth/4.0, 49);
            btn.segmentLabel.text = self.titles[i];
            btn.backgroundColor = kRGB(80, 72, 75);
            if (!i) {
                btn.segmentLabel.textColor = kNavigationMainColor;
            }
            btn.tag = kSegmentViewTag+i;
            btn.delegete = self;
            [self.segmentView addSubview:btn];
        }
    }else{
        for (int i = 0; i<3; i++) {
            SegmentBtnView *btn = [[SegmentBtnView alloc] init];
            btn.frame = CGRectMake(0+i*kScreenWidth/3.0, 0, kScreenWidth/3.0, 49);
            btn.segmentLabel.text = self.titles[i];
            btn.backgroundColor = kRGB(80, 72, 75);
            if (!i) {
                btn.segmentLabel.textColor = kNavigationMainColor;
            }
            btn.tag = kSegmentViewTag+i;
            btn.delegete = self;
            [self.segmentView addSubview:btn];
        }
    }
    
}

-(void)setupTableView
{
    UITableView *rankList = [[UITableView alloc] initWithFrame:CGRectMake(0, kNavigationBarHeight, kScreenWidth,kScreenHeight-kNavigationBarHeight) style:UITableViewStylePlain];
    
    self.rankListTable = rankList;
        
    self.rankListTable.dataSource = self;
    self.rankListTable.delegate = self;
    self.rankListTable.backgroundColor = kCommonBgColor;
    self.rankListTable.tableFooterView = [[UIView alloc] init];
    self.rankListTable.backgroundView = nil;
    [self.view addSubview:self.rankListTable];
    self.rankType = kRichDayRank;
    self.rankListTable.separatorColor = kRGBA(0, 0, 0, 0.1);
    [self.rankListTable setSeparatorInset:UIEdgeInsetsMake(100, 100, 0, 0)];
    
    
    self.systemRefreshView = [[UIRefreshControl alloc] init];
    self.systemRefreshView.tintColor = kNavigationMainColor;
    [self.systemRefreshView addTarget:self action:@selector(refreshList:) forControlEvents:UIControlEventValueChanged];
    [self.rankListTable addSubview:self.systemRefreshView];

    self.rankListTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 49)];
}

-(void)goback:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)refreshList:(id)sender
{
    if (self.flag==0) {
        [self retrieveAnchorListFromRemote];
    }else if (self.flag==1){
        [self retrieveRichListFromRemote];
    }else{
        [self retrieveLiveSpentMost];
    }
}

#pragma mark - segmentBtnDelegate
-(void)segmentBtnClick:(NSInteger)flag
{
    for (SegmentBtnView *seg in [self.segmentView subviews]) {
        if (seg.tag != flag) {
            seg.segmentLabel.textColor = kWhiteColor;
        }
    }
    if (self.flag!=2) {
        self.rankType = flag-kSegmentViewTag;
    }else{
        self.userRankType = flag-kSegmentViewTag;
    }
    
    if (self.flag==0) {
        [self retrieveAnchorListFromRemote];
    }else if (self.flag==1){
        [self retrieveRichListFromRemote];
    }else{
        [self retrieveLiveSpentMost];
    }
}

#pragma mark - loading data from remote.

- (void)retrieveRichListFromRemote
{
    [self showProgress:@"正在载入…" animated:YES];
    [self.dataManager.remote retrieveRichRank:self.rankType size:kRichListCount completion:^(NSArray *array, NSError *error) {
        [self hideProgressWithAnimated:YES];
        if (array != nil && error == nil)
        {
            // firstly remove all objects. all caches.
            [self.rankList removeAllObjects];
            
            [self.rankList addObjectsFromArray:array];
            
            [self.rankListTable reloadData];
        }else{
            [[UIGlobalKit sharedInstance] showMessage:@"加载富豪排行失败" in:self disappearAfter:2.0f];
        }
        if (self.systemRefreshView) {
            [self.systemRefreshView endRefreshing];
        }
    }];
}

- (void)retrieveAnchorListFromRemote
{
    [self showProgress:@"正在载入…" animated:YES];
    [self.dataManager.remote retrieveAnchorRank:kAnchorStarRank subType:self.rankType size:kRichListCount completion:^(NSArray *array, NSError *error) {
        [self hideProgressWithAnimated:YES];
        if (array != nil && error == nil)
        {
            // firstly remove all objects. all caches.
            [self.rankList removeAllObjects];
            
            [self.rankList addObjectsFromArray:array];
            
            [self.rankListTable reloadData];
        }
        else
        {
            [[UIGlobalKit sharedInstance] showMessage:@"加载主播排行失败" in:self disappearAfter:2.0f];
        }
        if (self.systemRefreshView) {
            [self.systemRefreshView endRefreshing];
        }
    }];
}

- (void)retrieveLiveSpentMost
{
//    __weak __typeof(self) weakSelf = self;
    [self showProgress:@"正在载入…" animated:YES];
    [self.dataManager.remote retrieveUserLiveRankRoom:self.currentRoom._id Size:10 UserRankType:self.userRankType completion:^(NSArray *array, NSError *error) {
        [self hideProgressWithAnimated:YES];
        if (array != nil && error == nil)
        {
            if (self.rankList == nil)
            {
                NSMutableArray *spentMost = [[NSMutableArray alloc] init];
                self.rankList = spentMost;
            }
            else
            {
                [self.rankList removeAllObjects];
            }
            [self.rankList addObjectsFromArray:array];
            [self.rankListTable reloadData];
        }else
        {
            [[UIGlobalKit sharedInstance] showMessage:@"加载送礼排行失败" in:self disappearAfter:2.0f];
        }
        if (self.systemRefreshView) {
            [self.systemRefreshView endRefreshing];
        }
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
