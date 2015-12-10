//
//  TuijianViewController+Datasource.m
//  memezhibo
//
//  Created by Xingai on 15/6/24.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "TuijianViewController+Datasource.h"
#import "NSBundle+SDK.h"

#define CellHeight (8+(kScreenWidth-24)/2)

@implementation TuijianViewController (Datasource)

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (self.roomList.count > 0)
    {
        if (self.roomList.count % 2)
        {
            return (self.roomList.count / 2+1);
        }
        else
        {
            return (self.roomList.count / 2);
        }
    }
    return 0;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CellHeight;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AllAnchorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AllAnchoID"];
    if (cell == nil) {
        cell = [[[NSBundle SDKResourcesBundle] loadNibNamed:@"AllAnchorTableViewCell" owner:self options:nil] lastObject];
    }
    
    cell.delegate = self;
    
    
    
    if (self.roomList.count % 2)
    {
        // 总数为奇数个
        if ((indexPath.row) < (self.roomList.count / 2) + 1)
        {
            if ((indexPath.row) == (self.roomList.count / 2))
            {
                // 最后一行
                TTShowRoom *room1 = self.roomList[(indexPath.row) * 2];
                [cell setContentWithRoom1:room1 room2:nil];
            }
            else
            {
                TTShowRoom *room1 = self.roomList[(indexPath.row) * 2];
                TTShowRoom *room2 = self.roomList[(indexPath.row) * 2 + 1];
                [cell setContentWithRoom1:room1 room2:room2];
            }
        }
    }
    else
    {
        // 总数为偶数个
        if ((indexPath.row) < (self.roomList.count / 2))
        {
            TTShowRoom *room1 = self.roomList[(indexPath.row) * 2];
            TTShowRoom *room2 = self.roomList[(indexPath.row)* 2 + 1];
            
            [cell setContentWithRoom1:room1 room2:room2];
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - AllAnchorMainCellImageDelegate
-(void)doSelectAllAnchorCell:(UITableViewCell *)cell tag:(NSInteger)tag
{
//    if (![DataGlobalKit networkOK])
//    {
//        [UIAlertView showErrorMessage:@"连接失败,请检查网络..."];
//        return;
//    }
    self.curSelectedCell = (AllAnchorTableViewCell *)cell;
    
    [self pushVideo:cell tag:tag];
}

-(void)pushVideo:(UITableViewCell*)cell tag:(NSInteger)tag
{
    
    NSIndexPath *indexPath = [self.tuijianListTable indexPathForCell:cell];
    NSInteger index = indexPath.row * 2 + tag - 1000;
    [self.tuijianListTable deselectRowAtIndexPath:indexPath animated:YES];
    
    if (index < self.roomList.count)
    {
        TTShowRoom *room = self.roomList[index];
        
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
        }
    }
}


@end
