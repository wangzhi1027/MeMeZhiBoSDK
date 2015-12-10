//
//  RechargeListCell.h
//  memezhibo
//
//  Created by Xingai on 15/6/5.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RechargeListCell : UITableViewCell

@property (nonatomic,assign) IBOutlet UILabel *UCCountLabel;

@property (nonatomic,assign) IBOutlet UILabel *desc;

@property (weak, nonatomic) IBOutlet UILabel *dateTime;

@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *botton;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *width;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nmBotton;

@end
