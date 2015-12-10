//
//  ChargeRemainView.m
//  TTShow
//
//  Created by twb on 13-11-22.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import "ChargeRemainView.h"
#import "TTShowUser.h"

@implementation ChargeRemainView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
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
}

- (void)setRemainCount:(long long int)count
{
    self.remain.text = [NSString stringWithFormat:@"%lli柠檬", count];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
