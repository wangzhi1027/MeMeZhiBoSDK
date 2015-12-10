//
//  RoomVideoViewController+Datasource.m
//  memezhibo
//
//  Created by Xingai on 15/6/8.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "RoomVideoViewController+Datasource.h"
#import "GitfRankListCell.h"
#import "RankListTableViewCell.h"
#import "TTShowUserRank.h"
#import "NSBundle+SDK.h"

@implementation RoomVideoViewController (Datasource)

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==self.messageTable) {
        return self.chatHistoryPublicArray.count;
    }
    if (tableView==self.MyMessageTable) {
        return self.chatHistroyPrivateArray.count;
    }
    if (tableView==self.giftrankingTable) {
        if (section==0) {
            return 1;
        }
        else
        {
            return self.giftRankingList.count;
        }
    }
    return 0;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.giftrankingTable==tableView) {
        return 2;
    }
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.giftrankingTable == tableView) {
        if (section==1) {
            return kSectionMaxHeght;
        }
        
    }
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.messageTable==tableView) {
        if (indexPath.row < self.chatHistoryPublicArray.count)
        {
            NSDictionary *dictionary = self.chatHistoryPublicArray[indexPath.row];
            TTMultiLineView *view = [dictionary valueForKey:kChatHistoryViewKey];
            return view.frame.size.height;
        }
    }
    
    if (self.MyMessageTable==tableView) {
        if (indexPath.row < self.chatHistroyPrivateArray.count)
        {
            NSDictionary *dictionary = self.chatHistroyPrivateArray[indexPath.row];
            TTMultiLineView *view = [dictionary valueForKey:kChatHistoryViewKey];
            return view.frame.size.height;
        }
    }
    

    if (tableView==self.giftrankingTable) {
        if (indexPath.section==0) {
            return 44;
        }else{
            return 76;
        }
    }

    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *defaltcell;
    if (self.messageTable==tableView) {
        RoomVideoChatHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RoomVideoChatHistoryCellID"];
        
        if (cell == nil)
        {
            cell = [[[NSBundle SDKResourcesBundle] loadNibNamed:@"RoomVideoChatHistoryCell" owner:self options:nil] lastObject];
        }
        
        
        // Set ...
        if (indexPath.row < self.chatHistoryPublicArray.count)
        {
            NSDictionary *dictionary = self.chatHistoryPublicArray[indexPath.row];
            TTMultiLineView *view = [dictionary valueForKey:kChatHistoryViewKey];
            
            
            [cell addChatContent:view];
        }
        return cell;
    }
    
    if (self.MyMessageTable==tableView) {
        RoomVideoChatHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RoomVideoChatHistoryCellID"];
        
        if (cell == nil)
        {
            cell = [[[NSBundle SDKResourcesBundle] loadNibNamed:@"RoomVideoChatHistoryCell" owner:self options:nil] lastObject];
        }
        
        
        // Set ...
        if (indexPath.row < self.chatHistroyPrivateArray.count)
        {
            NSDictionary *dictionary = self.chatHistroyPrivateArray[indexPath.row];
            TTMultiLineView *view = [dictionary valueForKey:kChatHistoryViewKey];
            
            
            [cell addChatContent:view];
        }
        return cell;
    }
    
    
    if (indexPath.section==0) {
        RankListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RankListTableViewCellID"];
        if (cell==nil) {
            cell = [[[NSBundle SDKResourcesBundle] loadNibNamed:@"RankListTableViewCell" owner:self options:nil] lastObject];
        }
        
        if (self.liveSpentMost!=nil&&indexPath.row<self.liveSpentMost.count) {
            
            TTShowUserRank *userRank = self.liveSpentMost[indexPath.row];
            [[UIGlobalKit sharedInstance] setImageAnimationLoading:cell.RankingImage WithSource:userRank.pic];
        }
        
        cell.RankProjectImage.image = kImageNamed(@"粉丝排行榜");
        cell.label.text = @"粉丝荣誉榜";
        
        
        return cell;
    }
    else
    {
        if (self.giftrankingTable==tableView) {
            GitfRankListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GitfRankListCellID"];
            if (cell==nil) {
                cell = [[[NSBundle SDKResourcesBundle] loadNibNamed:@"GitfRankListCell" owner:self options:nil] lastObject];
            }
            
            // Set....
            if (indexPath.row < self.giftRankingList.count)
            {
                TTShowAudience *audience = self.giftRankingList[indexPath.row];
                [[UIGlobalKit sharedInstance] setImageAnimationLoading:cell.headImage WithSource:audience.pic];
                cell.nameLabel.text = [audience.nick_name stringByUnescapingFromHTML];
                
                [cell setLevelImage:audience.wealthLevel];
                [cell setVipImageType:audience.vip];
                
                if (audience.manager) {
                    cell.AdminiImage.hidden = NO;
                }else{
                    cell.AdminiImage.hidden = YES;
                }
            }
            
            
            return cell;
        }

    }
    
    return defaltcell;
}

@end
