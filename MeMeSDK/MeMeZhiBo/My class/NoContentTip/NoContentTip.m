//
//  NoContentTip.m
//  TTShow
//
//  Created by twb on 13-9-25.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import "NoContentTip.h"

@implementation NoContentTip

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setTipText:(NSString *)text
{
    self.tip.text = text;
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
