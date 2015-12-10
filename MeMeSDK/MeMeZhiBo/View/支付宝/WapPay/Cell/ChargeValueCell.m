//
//  ChargeValueCell.m
//  TTShow
//
//  Created by twb on 13-11-22.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import "ChargeValueCell.h"

@implementation ChargeValueCell

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

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [[UIGlobalKit sharedInstance] adaptCellElememt:self.money];
}

- (void)setTitleText:(NSString *)text
{
    self.chargeTitle.text = text;
}

- (void)setMoneyCount:(CGFloat)count
{
    self.money.text = [NSString stringWithFormat:@"%.2f元", count];
}

- (void)setCoinCount:(NSInteger)count
{
    self.money.text = [NSString stringWithFormat:@"%ld柠檬", (long)count];
}

@end
