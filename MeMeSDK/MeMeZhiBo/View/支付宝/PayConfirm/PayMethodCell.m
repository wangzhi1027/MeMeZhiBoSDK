//
//  PayMethodCell.m
//  TTShow
//
//  Created by twb on 13-11-25.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import "PayMethodCell.h"

@implementation PayMethodCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:[[UIGlobalKit sharedInstance] groupCellSuitFrame:frame]];
}

- (void)setTitleText:(NSString *)text
{
    self.title.text = text;
}

- (void)setSubTitleText:(NSString *)text
{
    self.subTitle.text = text;
}

@end
