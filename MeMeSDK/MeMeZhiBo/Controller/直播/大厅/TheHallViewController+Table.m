//
//  TheHallViewController+Table.m
//  memezhibo
//
//  Created by Xingai on 15/5/22.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "TheHallViewController+Table.h"
#import "MainHeadCell.h"
#import "TTShowRemote+UserInfo.h"
#import "NSBundle+SDK.h"
#import "PersonalHomePageViewController.h"
#import "TuijianViewController.h"

#define kTheHallCellHeight (57+(2*kMainCellViewMinWidth+8)+ kMainCellViewMinWidth)
#define kXiaowoTuijianHeight (56.0f+kScreenWidth-24)
#define kAllAnchorHeight (34)
#define kTheHallCellSectionHeight (12.0f*kRatio)
#define kRoomcellHeight (8+(kScreenWidth-24)/2)
#define kMainScrollPaddingY (5.0f)
#define kRoomCellHeightzero (0.1f)

#define  kMainCellViewMinWidth      (kScreenWidth-32)/3

@implementation TheHallViewController (Table)

-(void)setupTheHallTable
{
    UITableViewController *tvc = [[UITableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    self.mainTableView = tvc.tableView;
    self.mainTableView.tag = kRoomTheHallTableViewTag;
    self.mainTableView.frame = CGRectMake(0.0f,
                                          kNavigationBarHeight,
                                          kScreenWidth,
                                          kScreenHeight-kNavigationBarHeight);
    
    self.mainTableView.dataSource = self;
    self.mainTableView.delegate = self;
    self.mainTableView.backgroundColor = kCommonBgColor;
    self.mainTableView.backgroundView = nil;
//    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mainTableView.separatorColor = kRGBA(0, 0, 0, 0.1);
    
    [self.view addSubview:self.mainTableView];
    
    
    
    
    self.systemRefreshView1 = [[UIRefreshControl alloc] init];
    self.systemRefreshView1.tintColor = kNavigationMainColor;
    [self.systemRefreshView1 addTarget:self action:@selector(refreshRoomList:) forControlEvents:UIControlEventValueChanged];
//    self.systemRefreshView1.attributedTitle = [[NSAttributedString alloc]initWithString:@"下拉刷新"];
    
    tvc.refreshControl = self.systemRefreshView1;
    
//     //footer
    self.loadMore1 = (LoadMore *)[self viewFromNib:@"LoadMore"];
    self.loadMore1.alpha = 0.0f;
    self.mainTableView.tableFooterView = self.loadMore1;
}

-(void)setupHitTable
{
    UITableViewController *tvc = [[UITableViewController alloc] initWithStyle:UITableViewStylePlain];
    self.HitToLoveTableView = tvc.tableView;
    self.HitToLoveTableView.tag = kRoomHitToLoveTableViewTag;
    self.HitToLoveTableView.frame = CGRectMake(0.0f,
                                          kNavigationBarHeight,
                                          kScreenWidth,
                                          kScreenHeight-kNavigationBarHeight);
    
    self.HitToLoveTableView.dataSource = self;
    self.HitToLoveTableView.delegate = self;
    self.HitToLoveTableView.backgroundColor = kCommonBgColor;
    self.HitToLoveTableView.backgroundView = nil;
    self.HitToLoveTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.HitToLoveTableView.separatorColor = kRGBA(0, 0, 0, 0.1);
    self.HitToLoveTableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 4)];
    self.HitToLoveTableView.tableHeaderView.backgroundColor = kWhiteColor;
    
    [self.view addSubview:self.HitToLoveTableView];
    
    self.systemRefreshView2 = [[UIRefreshControl alloc] init];
    self.systemRefreshView2.tintColor = kNavigationMainColor;
    [self.systemRefreshView2 addTarget:self action:@selector(refreshHitToLoveList:) forControlEvents:UIControlEventValueChanged];
//    self.systemRefreshView2.attributedTitle = [[NSAttributedString alloc]initWithString:@"下拉刷新"];
    
    tvc.refreshControl = self.systemRefreshView2;
    
    
    self.HitToLoveTableView.hidden = YES;
    
    self.loadMore2 = (LoadMore *)[self viewFromNib:@"LoadMore"];
    self.loadMore2.alpha = 0.0f;
    self.HitToLoveTableView.tableFooterView = self.loadMore2;
}

-(void)setupXiaowoTable
{
    UITableViewController *tvc = [[UITableViewController alloc] initWithStyle:UITableViewStylePlain];
    self.xiaoWoTableView = tvc.tableView;
    self.xiaoWoTableView.tag = kRoomXiaowoTableViewTag;
    self.xiaoWoTableView.frame = CGRectMake(0.0f,
                                               kNavigationBarHeight,
                                               kScreenWidth,
                                               kScreenHeight-kNavigationBarHeight);
    
    self.xiaoWoTableView.dataSource = self;
    self.xiaoWoTableView.delegate = self;
    self.xiaoWoTableView.backgroundColor = kCommonBgColor;
    self.xiaoWoTableView.backgroundView = nil;
//    self.xiaoWoTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.xiaoWoTableView.separatorColor = kRGBA(0, 0, 0, 0.1);

    [self.xiaoWoTableView setSeparatorInset:UIEdgeInsetsMake(100, 68, 0, 0)];
//    self.xiaoWoTableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 4)];
//    self.xiaoWoTableView.tableHeaderView.backgroundColor = kWhiteColor;
    
    [self.view addSubview:self.xiaoWoTableView];
    
    [self.xiaoWoTableView registerNib:[UINib nibWithNibName:@"JoinedListCell" bundle:nil] forCellReuseIdentifier:@"BadgeCellReuseID"];
    
    self.systemRefreshView3 = [[UIRefreshControl alloc] init];
    self.systemRefreshView3.tintColor = kNavigationMainColor;
    [self.systemRefreshView3 addTarget:self action:@selector(refreshRoomXiaowoList:) forControlEvents:UIControlEventValueChanged];
    //    self.systemRefreshView2.attributedTitle = [[NSAttributedString alloc]initWithString:@"下拉刷新"];
    
    tvc.refreshControl = self.systemRefreshView3;
    
    
    self.xiaoWoTableView.hidden = YES;
    
    self.loadMore3 = (LoadMore *)[self viewFromNib:@"LoadMore"];
    self.loadMore3.alpha = 0.0f;
    self.xiaoWoTableView.tableFooterView = self.loadMore3;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (tableView.tag==kRoomTheHallTableViewTag) {
        switch (section) {
            case kZhuboSection:
            {
                return 1;
            }
                break;
            case kXiaowoSection:
            {
                
                return 1;
            }
                break;
            case kMainSection:
            {
                if (self.roomList.count > 0)
                {
                    if (self.roomList.count % 2)
                    {
                        return (self.roomList.count / 2) + 2;
                    }
                    else
                    {
                        return (self.roomList.count / 2)+1;
                    }
                }
            }
                break;
            default:
                break;
        }
    }else if(tableView.tag==kRoomHitToLoveTableViewTag){
        if (self.roomList.count > 0)
        {
            if (self.roomList.count % 2)
            {
                return (self.roomList.count / 2) + 2;
            }
            else
            {
                return (self.roomList.count / 2)+1;
            }
        }
        return 0;
    }else if(tableView.tag == kRoomXiaowoTableViewTag)
    {
        switch (section) {
            case 0:
            {
                if (self.isAnchor) {
                    return 1;
                }else{
                    return 0;
                }
                
            }
                break;
            case 1:
            {
                return self.xiaoWoList.count;
            }
                break;
            default:
                break;
        }
        return self.xiaoWoList.count;
    }
    return 0;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView.tag == kRoomTheHallTableViewTag) {
        return 3;
    }
    if (tableView.tag == kRoomXiaowoTableViewTag) {
        return 2;
    }
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView.tag == kRoomTheHallTableViewTag) {
        switch (section) {
            case kZhuboSection:
                return 0.1;
                break;
                
            default:
                break;
        }
        return kTheHallCellSectionHeight;
    }
    if (tableView.tag == kRoomXiaowoTableViewTag) {
        return 0.1;
    }

    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == kRoomTheHallTableViewTag) {
        switch (indexPath.section) {
            case kZhuboSection:
                return kTheHallCellHeight;
                break;
            case kXiaowoSection:
                
                return kXiaowoTuijianHeight;
                break;
            case kMainSection:
            {
                if (indexPath.row==0) {
                    return kAllAnchorHeight;
                }else{
                    return kRoomcellHeight;
                }
                
            }
                break;
            default:
                break;
        }
        return 0;
    }else if (tableView.tag == kRoomXiaowoTableViewTag)
    {
        return 64.0f;
    }
    else
    {
        if (indexPath.row == 0) {
            return kRoomCellHeightzero;
        }
    }
    
    return kRoomcellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *resultCell = nil;
    
    
    if (tableView.tag == kRoomTheHallTableViewTag) {
        switch (indexPath.section) {
            case kZhuboSection:
            {
                AnchorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AnChorID"];
                
                if (cell == nil)
                {
                    cell = [[[NSBundle SDKResourcesBundle] loadNibNamed:@"AnchorTableViewCell" owner:self options:nil] lastObject];
                }
                
                if (self.commendationList.count>=6) {
                    TTShowRecommendation *recommendation1 = self.commendationList[indexPath.row];
                    TTShowRecommendation *recommendation2 = self.commendationList[indexPath.row+1];
                    TTShowRecommendation *recommendation3 = self.commendationList[indexPath.row+2];
                    TTShowRecommendation *recommendation4 = self.commendationList[indexPath.row+3];
                    TTShowRecommendation *recommendation5 = self.commendationList[indexPath.row+4];
                    TTShowRecommendation *recommendation6 = self.commendationList[indexPath.row+5];
                    
                    [cell setContentWithRecommendation1:recommendation1 recommendation2:recommendation2 recommendation3:recommendation3 recommendation4:recommendation4 recommendation5:recommendation5 recommendation6:recommendation6];
                }
                

                
                
                cell.delegate = self;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }
                break;
            case kXiaowoSection:
            {
                CaveolaeTableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:@"CaveoID"];
                if (cell == nil) {
                    cell = [[[NSBundle SDKResourcesBundle] loadNibNamed:@"CaveolaeTableViewCell" owner:self options:nil] lastObject];
                }
                if (self.xinrenList.count>=4) {
                    TTShowRoom *recommendation1 = self.xinrenList[indexPath.row];
                    TTShowRoom *recommendation2 = self.xinrenList[indexPath.row+1];
                    TTShowRoom *recommendation3 = self.xinrenList[indexPath.row+2];
                    TTShowRoom *recommendation4 = self.xinrenList[indexPath.row+3];

                    
                    [cell setContentWithxinrenList1:recommendation1 xinrenList2:recommendation2 xinrenList3:recommendation3 xinrenList4:recommendation4];
                }
                cell.delegate = self;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }
                break;
            case kMainSection:
            {
                if (indexPath.row==0) {
                    MainHeadCell  *cell = [tableView dequeueReusableCellWithIdentifier:@"MainHeadCellID"];
                    if (cell == nil) {
                        cell = [[[NSBundle SDKResourcesBundle] loadNibNamed:@"MainHeadCell" owner:self options:nil] lastObject];
                    }
                    cell.separatorInset = UIEdgeInsetsMake(34*kRatio, 320*kRatio, 0, 0);
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    
                    return cell;
                }
                if (indexPath.row>=1) {
                    AllAnchorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AllAnchoID"];
                    if (cell == nil) {
                        cell = [[[NSBundle SDKResourcesBundle] loadNibNamed:@"AllAnchorTableViewCell" owner:self options:nil] lastObject];
                    }
                    cell.separatorInset = UIEdgeInsetsMake(34*kRatio, 320*kRatio, 0, 0);
                    cell.delegate = self;
                    
                    if (self.roomList.count % 2)
                    {
                        // 总数为奇数个
                        if ((indexPath.row-1) < (self.roomList.count / 2) + 1)
                        {
                            if ((indexPath.row-1) == (self.roomList.count / 2))
                            {
                                // 最后一行
                                TTShowRoom *room1 = self.roomList[(indexPath.row-1) * 2];
                                [cell setContentWithRoom1:room1 room2:nil];
                            }
                            else
                            {
                                TTShowRoom *room1 = self.roomList[(indexPath.row-1) * 2];
                                TTShowRoom *room2 = self.roomList[(indexPath.row-1) * 2 + 1];
                                [cell setContentWithRoom1:room1 room2:room2];
                            }
                        }
                    }
                    else
                    {
                        // 总数为偶数个
                        if ((indexPath.row-1) < (self.roomList.count / 2))
                        {
                            TTShowRoom *room1 = self.roomList[(indexPath.row-1) * 2];
                            TTShowRoom *room2 = self.roomList[(indexPath.row-1)* 2 + 1];
                            [cell setContentWithRoom1:room1 room2:room2];
                        }
                    }
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    return cell;
                }
            }
            default:
                break;
        }
    }else if (tableView.tag == kRoomHitToLoveTableViewTag)
    {

        AllAnchorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AllAnchoID"];
        if (cell == nil) {
            cell = [[[NSBundle SDKResourcesBundle] loadNibNamed:@"AllAnchorTableViewCell" owner:self options:nil] lastObject];
        }
        
        if (indexPath.row==0) {
            cell.hidden = YES;
        }
        
        cell.delegate = self;
        
        
        
        if (self.roomList.count % 2)
        {
            // 总数为奇数个
            if ((indexPath.row-1) < (self.roomList.count / 2) + 1)
            {
                if ((indexPath.row-1) == (self.roomList.count / 2))
                {
                    // 最后一行
                    TTShowRoom *room1 = self.roomList[(indexPath.row-1) * 2];
                    [cell setContentWithRoom1:room1 room2:nil];
                }
                else
                {
                    TTShowRoom *room1 = self.roomList[(indexPath.row-1) * 2];
                    TTShowRoom *room2 = self.roomList[(indexPath.row-1) * 2 + 1];
                    [cell setContentWithRoom1:room1 room2:room2];
                }
            }
        }
        else
        {
            // 总数为偶数个
            if ((indexPath.row-1) < (self.roomList.count / 2))
            {
                TTShowRoom *room1 = self.roomList[(indexPath.row-1) * 2];
                TTShowRoom *room2 = self.roomList[(indexPath.row-1)* 2 + 1];
                [cell setContentWithRoom1:room1 room2:room2];
            }
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    return resultCell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.roomList.count==0) {
        return;
    }
    
    if (tableView.tag==kRoomTheHallTableViewTag) {
        if (!self.loadMore1)
        {
            return;
        }
        
        if (self.roomList.count % 2)
        {
            if (indexPath.row < (self.roomList.count / 2) + 2)
            {
                
                if (indexPath.row != ((self.roomList.count / 2)+1))
                {
                    // 不等于最后一行,直接退出.
                    return;
                }
            }
        }
        else
        {
            if (indexPath.row != (self.roomList.count / 2))
            {
                return;
            }
        }
        
        
        self.loadMore1.alpha = 1.0f;
        
        if (!kMainIsloadingMore)
        {
            if (kMainIsHasNoData)
            {
                [self.loadMore1 setFooterFinish];
            }
            else
            {
                [self.loadMore1 setFooterLoading];
                
                // loading something.
                [self loadMoreItems:self.loadMore1];
            }
        }
    }else if (tableView.tag == kRoomXiaowoTableViewTag)
    {
        if (!self.loadMore3)
        {
            return;
        }
        
//        LOGDEBUG(@"row %d count %d" ,(int)indexPath.row, (int)self.xiaoWoList.count);
        if (indexPath.row < self.xiaoWoList.count - 1 || self.hasNoData)
        {
            return;
        }
        
        self.loadMore3.alpha = 1.0f;
        if (!self.isLoadingMore)
        {
            if (self.hasNoData)
            {
                [self.loadMore3 setFooterFinish];
            }
            else
            {
                [self.loadMore3 setFooterLoading];
                
                // loading something.
            }
        }
    }
    else
    {
        if (self.curSortType==2) {
            self.loadMore2.alpha = 1.0f;
            [self.loadMore2 setFooterFinish];
            return;
        }
        if (!self.loadMore2)
        {
            return;
        }
        
        if (self.roomList.count % 2)
        {
            if (indexPath.row < (self.roomList.count / 2) + 1)
            {
                
                if (indexPath.row != (self.roomList.count / 2))
                {
                    // 不等于最后一行,直接退出.
                    return;
                }
            }
        }
        else
        {
            

            if (indexPath.row != (self.roomList.count / 2) - 1)
            {
                return;
            }
        }
        
        
        
        
        self.loadMore2.alpha = 1.0f;
        if (!kMainIsloadingMore)
        {
            if (kMainIsHasNoData)
            {
                [self.loadMore2 setFooterFinish];
            }
            else
            {
                [self.loadMore2 setFooterLoading];
                
                // loading something.
                [self loadMoreItems:self.loadMore2];
            }
        }

    }
    
    
}


#pragma mark - RefreshDelegate

- (void)refreshRoomXiaowoList:(id)sender
{
    if([self.dataManager.global isUserlogin] == 1)
        [self retrieveMyJoinXiaowoList];
        [self retrieveXiaowo:NO];
}

- (void)retrieveMyJoinXiaowoList
{
    
    [self showProgress:@"正在载入..." animated:YES];
    [self.dataManager.remote retrieveMyJoined:1 Size:200 completion:nil];
    
}

- (void)refreshHitToLoveList:(id)sender
{
    if (self.curSortType==2) {
        [self retrieveFavorStar];
    }else{
        [self retrieveHitToLoveList:NO];
    }
}

- (void)refreshRoomList:(id)sender
{
    [self retrieveRoomList:NO];
    [self retrieveHitToLoveList:NO];
}

#pragma mark - UIScrollViewDelegate Methods
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    self.hasTouchTable = YES;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.hasTouchTable = NO;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentSize.height <= scrollView.frame.size.height)
    {
        [self showControls];
    }
    else
    {
        if (self.hasTouchTable)
        {
            if (scrollView.contentOffset.y > (self.historyOffsetY + kMainScrollPaddingY) &&
                scrollView.contentOffset.y >= 0.0f)
            {
                // downwards.
                [self hideControls];
            }
            else if ((scrollView.contentOffset.y < (scrollView.contentSize.height - scrollView.frame.size.height)) &&
                     scrollView.contentOffset.y < (self.historyOffsetY - kMainScrollPaddingY))
            {
                // upwards.
                [self showControls];
            }
        }
    }
    
    self.historyOffsetY = scrollView.contentOffset.y;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    self.hasTouchTable = NO;
}

- (void)loadMoreItems:(LoadMore *)cell
{

    kMainSetIsloadingMore(YES);
    
    // do long long time working.
    NSUInteger pageNO = kMainCurrentPageNumber + 1;
    kMainSetCurrentPageNumber(pageNO);
    
    // Loading more details.
    // Remote part.
    [self retrieveRoomList:YES];
    [self retrieveHitToLoveList:YES];
}

#pragma mark - MainCellImageDelegate
-(void)doSelectRoomCell:(UITableViewCell *)cell tag:(NSInteger)tag
{
//    if (![DataGlobalKit networkOK])
//    {
//        [UIAlertView showErrorMessage:@"连接失败,请检查网络..."];
//        return;
//    }
    
    self.curSelectedCell1 = (AnchorTableViewCell *)cell;
    [self pushVideo1:cell tag:tag];
}


#pragma mark - CaveoMainCellImageDelegate
-(void)doSelectCaveoCell:(UITableViewCell *)cell tag:(NSInteger)tag
{
//    if (![DataGlobalKit networkOK])
//    {
//        [UIAlertView showErrorMessage:@"连接失败,请检查网络..."];
//        return;
//    }
    self.curSelectedCell2 = (CaveolaeTableViewCell *)cell;
    
    [self pushVideo2:cell tag:tag];
}


#pragma mark - AllAnchorMainCellImageDelegate
-(void)doSelectAllAnchorCell:(UITableViewCell *)cell tag:(NSInteger)tag
{
//    if (![DataGlobalKit networkOK])
//    {
//        [UIAlertView showErrorMessage:@"连接失败,请检查网络..."];
//        return;
//    }
    self.curSelectedCell3 = (AllAnchorTableViewCell *)cell;

    [self pushVideo:cell tag:tag];
}

-(void)pushVideo:(UITableViewCell*)cell tag:(NSInteger)tag
{    
    UITableView *selectTableView;
    
    if (self.curRoomShowMode == kRoomShowDefaultMode)
    {
        selectTableView = self.mainTableView;
    }
    else
    {
        selectTableView = self.HitToLoveTableView;
    }
    
    NSIndexPath *indexPath = [selectTableView indexPathForCell:cell];
    NSInteger index = indexPath.row * 2 + tag - 1000;

    
    if (index -2 < self.roomList.count)
    {
        TTShowRoom *room = self.roomList[index-2];

        if (room.live)
        {
            // First Check Kick out?
            [self showProgress:@"正在载入..." animated:YES];
            [self.dataManager.remote retrieveKickTtl:room._id completion:^(NSInteger count, NSError *error) {
                if (error == nil)
                {
                    if (count <= 0)
                    {
                        [self.uiManager showRoomVideoEnterType:kVideoEnterMain controller:self room:room];
                    }
                    else
                    {
                        [UIAlertView showInfoMessage:[NSString stringWithFormat:@"已被踢出房间,%ld秒后再进", (long)count]];
                    }
                } else {
                    // Not Login.
                    [self.uiManager showRoomVideoEnterType:kVideoEnterMain controller:self room:room];
                }
                [self hideProgressWithAnimated:YES];
            }];
        } else {
            // enter user center.
            PersonalHomePageViewController *person = [[PersonalHomePageViewController alloc] init];
            person.currentRoom = room;
            person.flag = 4;
            person.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:person animated:YES];
        }
    }
}

-(void)pushVideo1:(UITableViewCell*)cell tag:(NSInteger)tag
{
    if (self.commendationList.count<6) {
        [self.curSelectedCell1 deselectCellWithAnimated:YES];
        return;
    }
    
    NSInteger index = tag - 1000;
    
    if (index < self.commendationList.count)
    {
        TTShowRoom *room = self.commendationList[index];
        
        if (room.live)
        {
            // First Check Kick out?
            [self showProgress:@"正在载入..." animated:YES];
            [self.dataManager.remote retrieveKickTtl:room._id completion:^(NSInteger count, NSError *error) {
                if (error == nil)
                {
                    if (count <= 0)
                    {
                        [self.uiManager showRoomVideoEnterType:kVideoEnterMain controller:self room:room];
                    }
                    else
                    {
                        [UIAlertView showInfoMessage:[NSString stringWithFormat:@"已被踢出房间,%ld秒后再进", (long)count]];
                    }
                }
                else
                {
                    // Not Login.
                    [self.uiManager showRoomVideoEnterType:kVideoEnterMain controller:self room:room];
                }
                [self hideProgressWithAnimated:YES];
            }];
        } else {
            // enter user center.
            PersonalHomePageViewController *person = [[PersonalHomePageViewController alloc] init];
            person.currentRoom = room;
            person.flag = 4;
            person.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:person animated:YES];
        }
    }
}

-(void)tuijianListPush
{
    TuijianViewController *tuijian = [[TuijianViewController alloc] init];
    tuijian.hidesBottomBarWhenPushed = YES;
    tuijian.flag = 0;
    [self.navigationController pushViewController:tuijian animated:YES];
}

-(void)pushVideo2:(UITableViewCell*)cell tag:(NSInteger)tag
{
    if (self.commendationList.count<4) {
        [self.curSelectedCell1 deselectCellWithAnimated:YES];
        return;
    }
    
    NSInteger index = tag - 1000;
    
    if (index < self.commendationList.count)
    {
        TTShowRoom *room = self.xinrenList[index];
        
        if (room.live)
        {
            // First Check Kick out?
            [self showProgress:@"正在载入..." animated:YES];
            [self.dataManager.remote retrieveKickTtl:room._id completion:^(NSInteger count, NSError *error) {
                if (error == nil)
                {
                    if (count <= 0)
                    {
                        [self.uiManager showRoomVideoEnterType:kVideoEnterMain controller:self room:room];
                    }
                    else
                    {
                        [UIAlertView showInfoMessage:[NSString stringWithFormat:@"已被踢出房间,%ld秒后再进", (long)count]];
                    }
                }
                else
                {
                    // Not Login.
                    [self.uiManager showRoomVideoEnterType:kVideoEnterMain controller:self room:room];
                }
                [self hideProgressWithAnimated:YES];
            }];
        } else {
            // enter user center.
            PersonalHomePageViewController *person = [[PersonalHomePageViewController alloc] init];
            person.currentRoom = room;
            person.flag = 4;
            person.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:person animated:YES];
        }
    }

}

-(void)pushXinren
{
    TuijianViewController *tuijian = [[TuijianViewController alloc] init];
    tuijian.hidesBottomBarWhenPushed = YES;
    tuijian.flag = 1;
    [self.navigationController pushViewController:tuijian animated:YES];
}

#pragma xiaowoTableDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.xiaoWoTableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if([self.dataManager.global isUserlogin] == 1)
    {
        
    }else{
    }
}

@end
