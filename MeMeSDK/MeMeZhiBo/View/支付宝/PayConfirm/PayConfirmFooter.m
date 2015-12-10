//
//  PayConfirmFooter.m
//  TTShow
//
//  Created by twb on 13-11-25.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import "PayConfirmFooter.h"

@implementation PayConfirmFooter

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
    
    [[UIGlobalKit sharedInstance] setCustomButton:self.pay];
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
