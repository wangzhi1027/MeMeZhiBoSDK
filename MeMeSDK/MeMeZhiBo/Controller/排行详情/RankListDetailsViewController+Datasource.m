//
//  RankListDetailsViewController+Datasource.m
//  memezhibo
//
//  Created by Xingai on 15/6/3.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "RankListDetailsViewController+Datasource.h"
#import "RankingDetailsCell.h"
#import "LiveRankListCell.h"
#import "NSBundle+SDK.h"

@implementation RankListDetailsViewController (Datasource)

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.rankList.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 76;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.flag!=2) {
        RankingDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RankingDetailsCellID"];
        
        if (cell == nil)
        {
            cell = [[[NSBundle SDKResourcesBundle] loadNibNamed:@"RankingDetailsCell" owner:self options:nil] lastObject];
        }
        
        if (self.flag!=0) {
            TTShowUserRank *user = self.rankList[indexPath.row];
            
            if (indexPath.row == 0) {
                cell.firstIcon.hidden = NO;
                cell.rankNumberLabel.hidden = YES;
            }
            else
            {
                if (indexPath.row==1||indexPath.row==2) {
                    cell.rankNumberLabel.font = [UIFont boldSystemFontOfSize:15];
                    cell.rankNumberLabel.textColor = kRGB(255, 150, 0);
                    cell.rankNumberLabel.alpha = 1.0;
                }
                else
                {
                    cell.rankNumberLabel.font = [UIFont systemFontOfSize:15];
                    cell.rankNumberLabel.textColor = kBlackColor;
                    cell.rankNumberLabel.alpha = 0.4;
                }
                cell.firstIcon.hidden = YES;
                cell.rankNumberLabel.hidden = NO;
                cell.rankNumberLabel.text = [NSString stringWithFormat:@"%tu",indexPath.row+1];
            }
            
            
            cell.name.text = [NSString stringWithFormat:@"%@", [user.nick_name stringByUnescapingFromHTML]];;
            
            [[UIGlobalKit sharedInstance] setImageAnimationLoading:cell.HeadImage WithSource:user.pic];
            
            [cell setUserLevelImage:[self.dataManager wealthLevel:user.coin_spend_total]];

            return cell;
        }
        else
        {
            TTShowAnchorRank *anchorRank = self.rankList[indexPath.row];
            if (indexPath.row == 0) {
                cell.firstIcon.hidden = NO;
                cell.rankNumberLabel.hidden = YES;
            }
            else
            {
                if (indexPath.row==1||indexPath.row==2) {
                    cell.rankNumberLabel.font = [UIFont boldSystemFontOfSize:15];
                    cell.rankNumberLabel.textColor = kRGB(255, 150, 0);
                    cell.rankNumberLabel.alpha = 1.0;
                }
                else
                {
                    cell.rankNumberLabel.font = [UIFont systemFontOfSize:15];
                    cell.rankNumberLabel.textColor = kBlackColor;
                    cell.rankNumberLabel.alpha = 0.4;
                }
                cell.firstIcon.hidden = YES;
                cell.rankNumberLabel.hidden = NO;
                cell.rankNumberLabel.text = [NSString stringWithFormat:@"%tu",indexPath.row+1];
            }
            cell.name.text = [NSString stringWithFormat:@"%@", [anchorRank.nick_name stringByUnescapingFromHTML]];
            
            [[UIGlobalKit sharedInstance] setImageAnimationLoading:cell.HeadImage WithSource:anchorRank.pic];
            [cell setAnchorUserLevelImage:[self.dataManager anchorLevel:anchorRank.bean_count_total]];
            
            if (anchorRank.live) {
                cell.liveImage.hidden = NO;
            }else{
                cell.liveImage.hidden = YES;
            }
        }
        return cell;
    }else{
        LiveRankListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LiveRankListCellID"];
        if (!cell) {
            cell = [[[NSBundle SDKResourcesBundle] loadNibNamed:@"LiveRankListCell" owner:nil options:nil] lastObject];
        }
        
        TTShowUserRank *user = self.rankList[indexPath.row];
        
        if (indexPath.row == 0) {
            cell.firstIcon.hidden = NO;
            cell.rankNumberLabel.hidden = YES;
        }  else {
            cell.firstIcon.hidden = YES;
            cell.rankNumberLabel.hidden = NO;
            cell.rankNumberLabel.text = [NSString stringWithFormat:@"%tu",indexPath.row+1];
            if (indexPath.row==1||indexPath.row==2) {
                cell.rankNumberLabel.font = [UIFont boldSystemFontOfSize:15];
                cell.rankNumberLabel.textColor = kRGB(255, 150, 0);
                cell.rankNumberLabel.alpha = 1.0;
            } else {
                cell.rankNumberLabel.font = [UIFont systemFontOfSize:15];
                cell.rankNumberLabel.textColor = kBlackColor;
                cell.rankNumberLabel.alpha = 0.4;
            }
        }
        if (indexPath.row<3) {
            cell.count.textColor = kRedColor;
        }
        else
        {
            cell.count.textColor = kRGB(255.0f, 0.0f, 255.0f);
        }
        cell.name.text = [NSString stringWithFormat:@"%@", [user.nick_name stringByUnescapingFromHTML]];
        cell.count.text = [NSString stringWithFormat:@"%lu", (unsigned long)user.coin_spend];

        [[UIGlobalKit sharedInstance] setImageAnimationLoading:cell.HeadImage WithSource:user.pic];
        
        [cell setUserLevelImage:[self.dataManager wealthLevel:user.coin_spend_total]];
        
        NSDictionary *attributeDic1 = @{NSFontAttributeName:[UIFont systemFontOfSize:13.0f]};

        //计算字符串宽度
        CGRect rect1 = [cell.count.text boundingRectWithSize:CGSizeMake(200, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine attributes:attributeDic1 context:nil];
        float width = rect1.size.width+5;
        cell.widht.constant = width;
        [cell needsUpdateConstraints];

        return cell;
    }
}

@end
