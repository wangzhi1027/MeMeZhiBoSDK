//
//  GiftListViewCell.h
//  memezhibo
//
//  Created by Xingai on 15/6/3.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GiftListViewCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UIImageView *giftImage;

@property (nonatomic, strong) IBOutlet UILabel *giftName;

@property (nonatomic, strong) IBOutlet UILabel *giftLimitNumber;

@end
