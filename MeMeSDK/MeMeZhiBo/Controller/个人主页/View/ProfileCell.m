//
//  ProfileCell.m
//  memezhibo
//
//  Created by XIN on 15/10/22.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "ProfileCell.h"
#import "TTShowCar.h"

@implementation ProfileCell

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setupProfileWithInfo:(TTShowUserNew *)currentUser indexPath:(NSIndexPath *)indexPath 
{
    if (indexPath.section == 0) {
        
        switch (indexPath.row) {
            case 0:
            {
                self.detailTextLabel.text = [currentUser.nick_name stringByUnescapingFromHTML];
                break;
            }
            case 1:
            {
                self.detailTextLabel.text = [NSString stringWithFormat:@"%@", currentUser.sex == 0 ? @"女" : @"男"];
                break;
            }
            case 2:
            {
                NSString *constell = nil;
                NSInteger constellationIndex = currentUser.constellation - 1;
                if (constellationIndex < [DataGlobalKit constellations].count) {
                    constell = [DataGlobalKit constellations][constellationIndex];
                }
                self.detailTextLabel.text = constell ? constell : @"未设置";
                break;
            }
            case 3:
            {
                self.detailTextLabel.text = currentUser.location ? currentUser.location : @"未设置";
                break;
            }
            default:
                break;
        }
        
    } else if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
            {
                self.detailTextLabel.text = [currentUser.family objectForKey:@"family_name"] ? [currentUser.family objectForKey:@"family_name"] : @"未加入家族";
                break;
            }
            case 1: // 座驾
            {
                NSString *carString = [[NSString alloc] init];
                if (self.carList.count > 0) {
                    
                    carString = ((TTShowCar *)[self.carList objectAtIndex:0]).name;
                } else {
                    carString = @"暂无座驾";
                }
                self.detailTextLabel.text = carString;
                break;
            }
            case 2: //荣誉
            {
                self.detailTextLabel.hidden = YES;
                break;
            }
            default:
                break;
        }
    }
}

@end
