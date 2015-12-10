//
//  GuanzhuViewController+Datasource.m
//  memezhibo
//
//  Created by Xingai on 15/6/25.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "GuanzhuViewController+Datasource.h"
#import "GuanzhuCell.h"
#import "NSBundle+SDK.h"

@implementation GuanzhuViewController (Datasource)

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.roomList.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 76.0f;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GuanzhuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GuanzhuCellID"];
    if (cell == nil) {
        cell = [[[NSBundle SDKResourcesBundle] loadNibNamed:@"GuanzhuCell" owner:self options:nil] lastObject];
    }
    
    if (indexPath.row<self.roomList.count) {
        TTShowFollowRoomStar *room = self.roomList[indexPath.row];
        
        cell.name.text = [NSString stringWithFormat:@"%@", [room.nick_name stringByUnescapingFromHTML]];;
        
        [[UIGlobalKit sharedInstance] setImageAnimationLoading:cell.HeadImage WithSource:room.pic];
        
        [cell setAnchorUserLevelImage:[self.dataManager anchorLevel:room.bean_count_total]];
        if (room.live) {
            cell.liveImage.hidden = NO;
        }else{
            cell.liveImage.hidden = YES;
        }
    }
    

    
    return cell;
}



@end
