//
//  ChargeRemainCell.m
//  TTShow
//
//  Created by twb on 13-9-6.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import "ChargeRemainCell.h"
#import "TTShowUser.h"

@interface ChargeRemainCell ()

@property (weak, nonatomic) IBOutlet UILabel *remain;

@end

@implementation ChargeRemainCell

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
    
    TTShowUser *user = [TTShowUser unarchiveUser];
    // update charge balance.
    long long int coin_count = 0;
    Finance *finance = [[Finance alloc] initWithAttributes:user.finance];
    coin_count = finance.coin_count;
    
    [self setRemainCount:coin_count];
    
    [[UIGlobalKit sharedInstance] adaptCellElememt:self.remain];
}

- (void)setRemainCount:(long long int)count
{
    self.remain.text = [NSString stringWithFormat:@"%lli柠檬", count];
}

@end
