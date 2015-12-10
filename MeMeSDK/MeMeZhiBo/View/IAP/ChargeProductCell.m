//
//  ChargeProductCell.m
//  TTShow
//
//  Created by twb on 13-7-19.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import "ChargeProductCell.h"

@interface ChargeProductCell ()

@end

@implementation ChargeProductCell

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
    
    self.chargeLabel.layer.masksToBounds = YES;
    self.chargeLabel.layer.cornerRadius = 5;
    self.chargeLabel.layer.borderWidth = 1;
    self.chargeLabel.layer.borderColor = kRGB(255.0f, 145.0f, 9.0f).CGColor;
    
//    [[UIGlobalKit sharedInstance] setCustomButton:self.chargeBtn font:14.0f];
//    [[UIGlobalKit sharedInstance] adaptCellElememt:self.chargeBtn];
}

- (void)setProductPriceText:(NSString *)text
{
    self.chargeBtn.text = text;
}

@end
