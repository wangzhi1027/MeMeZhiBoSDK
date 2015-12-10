//
//  RankListDetailsViewController+Delegate.m
//  memezhibo
//
//  Created by Xingai on 15/6/3.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "RankListDetailsViewController+Delegate.h"
#import "PersonalHomePageViewController.h"

@implementation RankListDetailsViewController (Delegate)

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.rankListTable deselectRowAtIndexPath:indexPath animated:YES];
    if (self.flag==0) {
        
        TTShowAnchorRank *anchorRank = self.rankList[indexPath.row];
        TTShowRoom *room = [[TTShowRoom alloc] init];
        room.live = anchorRank.live;
        room.nick_name = anchorRank.nick_name;
        room._id = anchorRank._id;
        room.pic_url = anchorRank.pic;

        if (room.live) {
            [self.uiManager showRoomVideoEnterType:kVideoEnterOther controller:self room:room];
        }
        else
        {
            PersonalHomePageViewController *person = [[PersonalHomePageViewController alloc] init];
            person.currentRoom = room;
            [self.navigationController pushViewController:person animated:YES];
        }
    }
    if (self.flag==1) {
        TTShowAnchorRank *anchorRank = self.rankList[indexPath.row];
        TTShowRoom *room = [[TTShowRoom alloc] init];
        room.nick_name = anchorRank.nick_name;
        room._id = anchorRank._id;
        room.pic_url = anchorRank.pic;
        
        PersonalHomePageViewController *person = [[PersonalHomePageViewController alloc] init];
        person.currentRoom = room;
        [self.navigationController pushViewController:person animated:YES];
    }
}

@end
