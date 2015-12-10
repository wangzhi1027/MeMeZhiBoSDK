//
//  RankingDetailsCell.m
//  memezhibo
//
//  Created by Xingai on 15/6/2.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "RankingDetailsCell.h"

@implementation RankingDetailsCell

- (void)awakeFromNib {
    
    self.label.hidden = YES;
    self.count.hidden = YES;
    self.firstIcon.hidden = YES;
    
    self.HeadImage.layer.masksToBounds = YES;
    self.HeadImage.layer.cornerRadius = self.HeadImage.frame.size.width/2;
    
    self.HeadImage.layer.borderWidth = 0.5;
    self.HeadImage.layer.borderColor = kRGBA(202.0f, 202.0f, 202.0f, 0.8).CGColor;
    
    

    self.labelWidth.constant = 130.0f*375/kScreenWidth;

    [self needsUpdateConstraints];
    
    self.liveImage.hidden = YES;
}

- (void)setUserLevelImage:(NSUInteger)count
{
    NSString *weathGradeImage = [[DataGlobalKit sharedInstance] wealthImageString:count];
    self.LevelImage.image = [UIImage sd_animatedGIFNamed:weathGradeImage];
}

- (void)setAnchorUserLevelImage:(NSUInteger)count
{
    self.AnchorLevelImage.image = [[DataGlobalKit sharedInstance] anchorImage:count];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
