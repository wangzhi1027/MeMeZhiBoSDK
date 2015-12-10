//
//  ChargeValueCell.h
//  TTShow
//
//  Created by twb on 13-11-22.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChargeValueCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *money;
@property (weak, nonatomic) IBOutlet UILabel *chargeTitle;

- (void)setTitleText:(NSString *)text;
- (void)setMoneyCount:(CGFloat)count;
- (void)setCoinCount:(NSInteger)count;

@end
