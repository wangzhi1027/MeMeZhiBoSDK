//
//  UserBadgeCell.h
//  TTShow
//
//  Created by twb on 14-5-14.
//  Copyright (c) 2014年 twb. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kUserBadgeCellHeight (60.0f)

@interface UserBadgeCell : UITableViewCell

- (void)setBadgeImage:(NSString *)string;
- (void)setTitleText:(NSString *)text;
- (void)setRemainTimeText:(NSString *)text;
- (void)setExpiredText:(NSString *)text;
- (void)setDetailText:(NSString *)text;

@end
