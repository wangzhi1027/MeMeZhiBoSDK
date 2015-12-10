//
//  GitfRankListCell.m
//  memezhibo
//
//  Created by Xingai on 15/6/10.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "GitfRankListCell.h"

@implementation GitfRankListCell

- (void)awakeFromNib {
    // Initialization code
    
    
    
    self.headImage.layer.masksToBounds = YES;
    self.headImage.layer.borderWidth = 0.1;
    self.headImage.layer.borderColor = kRGB(175, 175, 175).CGColor;
    self.headImage.layer.cornerRadius = 24;
    
}

- (void)setLevelImage:(NSUInteger)levelCount
{
    // clear zero.
    self.sum = 0.0f;
    
    NSString *weatherLevlString = [[DataGlobalKit sharedInstance] wealthImageString:levelCount];
    self.levelImageView.image = [UIImage sd_animatedGIFNamed:weatherLevlString];
    
    self.sum += (self.levelImageView.frame.size.width + 5.0);
}

- (void)setVipImageType:(MemberType)memberType
{
    self.vipImage.hidden = (memberType == kVIPNone);
    
//    CGRect vipFrame = self.vipImage.frame;
//    self.vipImage.frame = CGRectMake(58.0f + self.sum,
//                                     vipFrame.origin.y,
//                                     vipFrame.size.width,
//                                     vipFrame.size.height);
    
    if (memberType != kVIPNone)
    {
        self.sum += (self.vipImage.frame.size.width + 5.0);
    }
    self.vipImage.image = kImageNamed([[DataGlobalKit sharedInstance] vipImageString:memberType]);
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
