//
//  GuanzhuCell.m
//  memezhibo
//
//  Created by Xingai on 15/6/25.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "GuanzhuCell.h"

@implementation GuanzhuCell

- (void)awakeFromNib {
    self.HeadImage.layer.masksToBounds = YES;
    self.HeadImage.layer.cornerRadius = 24.0f;
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
