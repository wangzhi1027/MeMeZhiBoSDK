//
//  LiveRankListCell.m
//  memezhibo
//
//  Created by XIN on 15/11/11.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "LiveRankListCell.h"

@implementation LiveRankListCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.HeadImage.layer.masksToBounds = YES;
    self.HeadImage.layer.cornerRadius = self.HeadImage.frame.size.width/2;
    self.HeadImage.layer.borderWidth = 0.5;
    self.HeadImage.layer.borderColor = kRGBA(202.0f, 202.0f, 202.0f, 0.8).CGColor;
}

- (void)setUserLevelImage:(NSUInteger)count
{
    NSString *weathGradeImage = [[DataGlobalKit sharedInstance] wealthImageString:count];
    self.LevelImage.image = [UIImage sd_animatedGIFNamed:weathGradeImage];
}

@end
