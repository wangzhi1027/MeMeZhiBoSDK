//
//  TuijianViewController.m
//  memezhibo
//
//  Created by Xingai on 15/6/24.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "TuijianViewController.h"
#import "TTShowRemote+TuijianList.h"
#import "TTShowRemote+TheHall.h"
#import "TuijianViewController+Delegate.h"
#import "TuijianViewController+Datasource.h"

@interface TuijianViewController ()

@end

@implementation TuijianViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    if (self.curSelectedCell) {
        [self.curSelectedCell deselectCellWithAnimated:YES];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    //判断是否为第一个view
    if (self.navigationController && [self.navigationController.viewControllers count] == 1) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    self.view.backgroundColor = kCommonBgColor;
    [self statusContent];
    [self setupNavView];
    if (self.flag==0) {
        self.titleLabel.text = @"推荐主播";
    }
    else
    {
        self.titleLabel.text = @"优秀新人";
    }
    
    
    
    [self setupLeftBtnAction:@selector(goback:)];
    [self.backBtn setTitle:@"大厅" forState:UIControlStateNormal];
    [self setupTable];
    
    if (self.flag==0) {
        [self setupRemote:NO];
    }
    else
    {
        [self remoteXinren:NO];
    }
    
}

-(void)statusContent
{
    self.roomList = [NSMutableArray arrayWithCapacity:0];
}

#pragma mark- UIGestureRecognizerDelegate
//**************方法一****************//
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    return YES;
}


-(void)loadView
{
    self.view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    self.view.backgroundColor = [UIColor clearColor];
}

-(void)setupNavgation
{
//    [self.navigationController setNavigationBarHidden:NO];
    
    [self.uiManager.global setNavigationController:self title:@"推荐主播"];
    
    // Navigation Bar Bg
    [self.uiManager.global setNavCustomNormalBg:self hasBottomLine:YES];
    
    // left
    [self.uiManager.global setNavLeftBackItem:self action:@selector(goback:)];
}

-(void)setupTable
{
    UITableViewController *tvc = [[UITableViewController alloc] initWithStyle:UITableViewStylePlain];
    self.tuijianListTable = tvc.tableView;
    self.tuijianListTable.frame = CGRectMake(0.0f,
                                               kNavigationBarHeight,
                                               kScreenWidth,
                                               kScreenHeight-kNavigationBarHeight);
    
    self.tuijianListTable.dataSource = self;
    self.tuijianListTable.delegate = self;
    self.tuijianListTable.backgroundColor = kCommonBgColor;
    self.tuijianListTable.backgroundView = nil;
    self.tuijianListTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tuijianListTable.separatorColor = kRGBA(0, 0, 0, 0.1);
    
    [self.view addSubview:self.tuijianListTable];
    
    self.systemRefreshView = [[UIRefreshControl alloc] init];
    self.systemRefreshView.tintColor = kNavigationMainColor;
    [self.systemRefreshView addTarget:self action:@selector(refreshHitToLoveList:) forControlEvents:UIControlEventValueChanged];
    //    self.systemRefreshView2.attributedTitle = [[NSAttributedString alloc]initWithString:@"下拉刷新"];
    
    tvc.refreshControl = self.systemRefreshView;
    
    
    self.tuijianListTable.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 4)];
    self.tuijianListTable.tableHeaderView.backgroundColor = kWhiteColor;
}

-(void)goback:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)setupRemote:(BOOL)loadMore
{
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
    [self.dataManager.remote getTuijianWithPage:[NSString stringWithFormat:@"%ld",self.page]  completion:^(NSArray *array, NSError *error) {
        if (!error) {
            if (self.roomList)
            {
                [self.roomList removeAllObjects];
            }
            
            NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"live" ascending:NO];
            NSArray *sortArray = [NSArray arrayWithObjects:descriptor,nil];
            
            NSArray *sortedArray = [array sortedArrayUsingDescriptors:sortArray];
            
            
            [self.roomList addObjectsFromArray:sortedArray];
            if (self.roomList.count!=0) {
                if (self.noDataView) {
                    self.noDataView.view.hidden = YES;
                }
            }
        }else{
            if (!self.noDataView) {
                self.noDataView = [[noDataViewController alloc] init];
                self.noDataView.view.frame = CGRectMake(0, kNavigationBarHeight, kScreenWidth, kScreenHeight-kNavigationBarHeight);
                [self.view addSubview:self.noDataView.view];
            }else{
                self.noDataView.view.hidden = NO;
            }
            [self.noDataView setupImage:2];
        }
        
        [self refreshUI:loadMore];
    }];
}

-(void)remoteXinren:(BOOL)loadMore
{
    
    [self showProgress:@"正在载入…" animated:YES];
    [self.dataManager.remote remoteXinrenList:^(NSArray *array, NSError *error) {
        [self hideProgressWithAnimated:YES];
        if (!error&&array) {
            [self.roomList removeAllObjects];
            [self.roomList addObjectsFromArray:array];
            [self.tuijianListTable reloadData];
        }else{
            
        }
        [self refreshUI:loadMore];
    }];
}

- (void)refreshUI:(BOOL)loadMore
{
    if (self.systemRefreshView)
    {
        [self.systemRefreshView endRefreshing];
    }

    
    [self.tuijianListTable reloadData];
    
    [self hideProgressWithAnimated:YES];
}


-(void)refreshHitToLoveList:(id)sender
{
    if (self.flag==0) {
        [self setupRemote:NO];
    }
    else
    {
        [self remoteXinren:NO];
    }
    
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
