//
//  RankListTableViewCell.m
//  memezhibo
//
//  Created by Xingai on 15/5/26.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "RankListTableViewCell.h"

@implementation RankListTableViewCell

- (void)awakeFromNib {
    self.RankingImage.layer.masksToBounds = YES;
    self.RankingImage.layer.cornerRadius = 16.0f;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
