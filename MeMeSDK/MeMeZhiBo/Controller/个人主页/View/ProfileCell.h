//
//  ProfileCell.h
//  memezhibo
//
//  Created by XIN on 15/10/22.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileCell : UITableViewCell

@property (nonatomic, strong) NSArray *carList;

- (void)setupProfileWithInfo:(TTShowUserNew *)currentUser indexPath:(NSIndexPath *)indexPath;

@end
