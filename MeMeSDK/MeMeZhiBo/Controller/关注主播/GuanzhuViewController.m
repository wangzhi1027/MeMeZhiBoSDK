//
//  GuanzhuViewController.m
//  memezhibo
//
//  Created by Xingai on 15/6/25.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "GuanzhuViewController.h"
#import "GuanzhuViewController+Delegate.h"
#import "GuanzhuViewController+Datasource.h"

@interface GuanzhuViewController ()

@end

@implementation GuanzhuViewController

-(void)loadView
{
    self.view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    self.view.backgroundColor = [UIColor clearColor];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = YES;
//    self.navigationController.navigationBarHidden = NO;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    //判断是否为第一个view
    if (self.navigationController && [self.navigationController.viewControllers count] == 1) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    
    [self setupNavView];
    self.titleLabel.text = self.flag!=2?@"关注主播":@"管理主播";
    
    
    
//    self.view.backgroundColor = kCommonBgColor;
    [self setupLeftBtnAction:@selector(goback:)];
//    if (self.flag == 2) {
//        [self.backBtn setTitle:@"账号" forState:UIControlStateNormal];
//    }
    
    [self.backBtn setTitle:self.navTitle forState:UIControlStateNormal];
    
    [self statusContent];
    
    [self setupTable];
    if (self.flag!=2) {
        [self setupRemoteGuanzhu];
    }
    else
    {
        [self setupRemoteGuanli];
    }
    
}

#pragma mark- UIGestureRecognizerDelegate
//**************方法一****************//
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    return YES;
}

-(void)statusContent
{
    self.roomList = [NSMutableArray arrayWithCapacity:0];
}

-(void)setupNavgation
{
    
    [self.uiManager.global setNavigationController:self title:self.flag!=2?@"关注主播":@"管理主播"];
    
    // Navigation Bar Bg
    [self.uiManager.global setNavCustomNormalBg:self hasBottomLine:YES];
    
    // left
    [self.uiManager.global setNavLeftBackItem:self action:@selector(goback:)];
}

-(void)goback:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)setupTable
{
    UITableViewController *tvc = [[UITableViewController alloc] initWithStyle:UITableViewStylePlain];
    self.GuanzhuListTable = tvc.tableView;
    self.GuanzhuListTable.frame = CGRectMake(0.0f,
                                             kNavigationBarHeight,
                                             kScreenWidth,
                                             kScreenHeight-kNavigationBarHeight);
    
    self.GuanzhuListTable.dataSource = self;
    self.GuanzhuListTable.delegate = self;
    self.GuanzhuListTable.backgroundColor = kCommonBgColor;
    self.GuanzhuListTable.backgroundView = nil;
//    self.GuanzhuListTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.GuanzhuListTable setSeparatorInset:UIEdgeInsetsMake(100, 100, 0, 0)];
    self.GuanzhuListTable.separatorColor = kRGBA(0, 0, 0, 0.1);
    
    self.GuanzhuListTable.tableFooterView = [[UIView alloc] init];
    
    [self.view addSubview:self.GuanzhuListTable];
    
    self.systemRefreshView = [[UIRefreshControl alloc] init];
    self.systemRefreshView.tintColor = kNavigationMainColor;
    [self.systemRefreshView addTarget:self action:@selector(refreshHitToLoveList:) forControlEvents:UIControlEventValueChanged];
    //    self.systemRefreshView2.attributedTitle = [[NSAttributedString alloc]initWithString:@"下拉刷新"];
    
    tvc.refreshControl = self.systemRefreshView;
}

-(void)setupRemoteGuanzhu
{
    [self showProgress:@"正在载入…" animated:YES];
    [self.dataManager.remote followingListWithCompletion:^(NSArray *array, NSError *error) {
        [self hideProgressWithAnimated:YES];
        if (!error)
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
            
            NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"live" ascending:NO];
            NSArray *sortArray = [NSArray arrayWithObjects:descriptor,nil];
            
            NSArray *sortedArray = [array sortedArrayUsingDescriptors:sortArray];
            
            
            [self.roomList addObjectsFromArray:sortedArray];
            
            
            [self.GuanzhuListTable reloadData];
            if (self.systemRefreshView) {
                [self.systemRefreshView endRefreshing];
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
//            if (!self.noDataView) {
//                self.noDataView = [[noDataViewController alloc] init];
//                self.noDataView.view.frame = CGRectMake(0, kNavigationBarHeight, kScreenWidth, kScreenHeight-kNavigationBarHeight);
//                [self.view addSubview:self.noDataView.view];
//            }else{
//                self.noDataView.view.hidden = NO;
//            }
//            [self.noDataView setupImage:2];
        }
    }];

}

-(void)refreshHitToLoveList:(id)sender
{
    if (self.flag!=2) {
        [self setupRemoteGuanzhu];
    }
    else
    {
        [self setupRemoteGuanli];
    }
}

-(void)setupRemoteGuanli
{
    [self showProgress:@"正在载入…" animated:YES];
    [self hideNoContentTip];
    [self.dataManager.remote manageStarListWithCompletion:^(NSArray *array, NSError *error) {
        [self hideProgressWithAnimated:YES];
        if (!error) {
            if (!self.roomList) {
                self.roomList = [NSMutableArray arrayWithCapacity:0];
            } else {
                [self.roomList removeAllObjects];
            }
            
            NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"live" ascending:NO];
            NSArray *sortArray = [NSArray arrayWithObjects:descriptor,nil];
            
            NSArray *sortedArray = [array sortedArrayUsingDescriptors:sortArray];
            
            
            [self.roomList addObjectsFromArray:sortedArray];

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
            [self.noDataView setupImage:3];

        } else {
//            if (!self.noDataView) {
//                self.noDataView = [[noDataViewController alloc] init];
//                self.noDataView.view.frame = CGRectMake(0, kNavigationBarHeight, kScreenWidth, kScreenHeight-kNavigationBarHeight);
//                [self.view addSubview:self.noDataView.view];
//            }else{
//                self.noDataView.view.hidden = NO;
//            }
//            [self.noDataView setupImage:2];
        }
        
        
        if (self.systemRefreshView) {
            [self.systemRefreshView endRefreshing];
        }
        [self.GuanzhuListTable reloadData];
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
