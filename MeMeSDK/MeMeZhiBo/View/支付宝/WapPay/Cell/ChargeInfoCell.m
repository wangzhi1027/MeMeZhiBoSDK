//
//  ChargeInfoCell.m
//  TTShow
//
//  Created by twb on 13-11-22.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import "ChargeInfoCell.h"

@interface ChargeInfoCell ()

@property (weak, nonatomic) IBOutlet UILabel *subTitle;

@end

@implementation ChargeInfoCell

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
    
    [[UIGlobalKit sharedInstance] adaptCellElememt:self.subTitle];
}

@end
