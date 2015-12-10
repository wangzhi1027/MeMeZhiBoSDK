//
//  HonorViewController.m
//  memezhibo
//
//  Created by XIN on 15/10/28.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "HonorViewController.h"
#import "UserBadgeCell.h"
#import "TTShowBadge.h"
#import "TTShowRemote+UserInfo.h"
#import "NSBundle+SDK.h"

@interface HonorViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *badgeTable;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end

@implementation HonorViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupNavView];
    self.titleLabel.text = @"徽章";
    [self setupLeftBtnAction:@selector(goback:)];
    if (![self.navTitle isEqualToString:@""]&&self.navTitle!=nil) {
        [self.backBtn setTitle:self.navTitle forState:UIControlStateNormal];
    }
//    self.nav.backgroundColor = kRGBA(97, 90, 93, 1.0f);
    
    [self.badgeTable registerNib:[UINib nibWithNibName:@"UserBadgeCell" bundle:[NSBundle SDKResourcesBundle]] forCellReuseIdentifier:@"UserBadgeCellReuseID"];
    [self.view addSubview:self.badgeTable];
    [self.badgeTable addSubview:self.refreshControl];
}

-(void)goback:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark - Event Response

- (void)refreshBadge:(UIRefreshControl *)sender
{
    [self retrieveUserBadge];
}

#pragma mark - Private Methods

- (void)retrieveUserBadge
{
    [self.dataManager.remote retrieveUserBadge:self.currentUserId completion:^(NSArray *array, NSError *error) {
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
            [self.badgeTable reloadData];
            [self.refreshControl endRefreshing];
        });
    }];
}
#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.badgeList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *kUserBadgeCellReuseID = @"UserBadgeCellReuseID";
    UserBadgeCell *cell = [tableView dequeueReusableCellWithIdentifier:kUserBadgeCellReuseID];
    if (!cell)
    {
        cell = [[UserBadgeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kUserBadgeCellReuseID];
    }
    
    if (indexPath.row < self.badgeList.count)
    {
        TTShowBadge *badge = self.badgeList[indexPath.row];
        [cell setTitleText:badge.name];
        [cell setDetailText:badge.desc];
        
        if (badge.award) {
            [cell setBadgeImage:badge.pic_url];
        } else{
            [cell setBadgeImage:badge.grey_pic];
        }
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.f;
}

#pragma mark - Setter/Getter

- (UITableView *)badgeTable
{
    if (!_badgeTable) {
        _badgeTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
        _badgeTable.dataSource = self;
        _badgeTable.delegate = self;
    }
    return _badgeTable;
}

- (UIRefreshControl *)refreshControl
{
    if (!_refreshControl) {
        _refreshControl = [[UIRefreshControl alloc] init];
        _refreshControl.tintColor = kNavigationMainColor;
        [_refreshControl addTarget:self action:@selector(refreshBadge:) forControlEvents:UIControlEventValueChanged];
    }
    return _refreshControl;
}

@end
