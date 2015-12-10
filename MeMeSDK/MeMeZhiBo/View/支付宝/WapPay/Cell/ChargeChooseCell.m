//
//  ChargeChooseCell.m
//  TTShow
//
//  Created by twb on 13-11-22.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import "ChargeChooseCell.h"

@implementation ChargeChooseCell

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
    
    CGRect frame = self.stepView.frame;
    TTStepView *sv = (TTStepView *)[self viewFromNib:@"TTStepView"];
    sv.frame = frame;
    self.stepView = sv;
    [self addSubview:self.stepView];
    
    [[UIGlobalKit sharedInstance] adaptCellElememt:self.stepView];
}

@end
