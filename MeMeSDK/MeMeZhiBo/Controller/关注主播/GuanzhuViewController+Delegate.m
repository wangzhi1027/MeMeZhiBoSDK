//
//  GuanzhuViewController+Delegate.m
//  memezhibo
//
//  Created by Xingai on 15/6/25.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "GuanzhuViewController+Delegate.h"
#import "PersonalHomePageViewController.h"

@implementation GuanzhuViewController (Delegate)

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.GuanzhuListTable deselectRowAtIndexPath:indexPath animated:YES];

    TTShowFollowRoomStar *anchorRank = self.roomList[indexPath.row];
    TTShowRoom *room = [[TTShowRoom alloc] init];
    room.live = anchorRank.live;
    room.nick_name = anchorRank.nick_name;
    room._id = anchorRank.roomID;
    room.pic_url = anchorRank.pic;
    
    
    
    if (room.live) {
        if (self.flag==3) {
            [self.delegate guanzhuVideoBack:room];
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
        }else{
            [self.uiManager showRoomVideoEnterType:kVideoEnterOther controller:self room:room];
        }
    }
    else
    {
        PersonalHomePageViewController *person = [[PersonalHomePageViewController alloc] init];
        person.currentRoom = room;
        //代表直播间进入
        person.flag = self.flag;
        person.delegate = self.delegate;
        [self.navigationController pushViewController:person animated:YES];
    }
}

@end
