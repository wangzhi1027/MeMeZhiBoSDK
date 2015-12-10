//
//  GiftListViewCell.m
//  memezhibo
//
//  Created by Xingai on 15/6/3.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "GiftListViewCell.h"

@implementation GiftListViewCell

- (void)awakeFromNib {
    // Initialization code
    self.giftImage.layer.masksToBounds = YES;
    self.giftImage.layer.cornerRadius = 3;
    self.giftImage.layer.borderWidth = 0.2;
    self.giftImage.layer.borderColor = kRGB(175, 175, 175).CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
