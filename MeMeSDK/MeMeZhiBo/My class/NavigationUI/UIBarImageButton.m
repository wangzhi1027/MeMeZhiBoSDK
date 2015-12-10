//
//  UIBarImageButton.m
//  TTShow
//
//  Created by twb on 13-10-18.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import "UIBarImageButton.h"

@implementation UIBarImageButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
//        self.imageEdgeInsets = UIEdgeInsetsMake(0.0f, 16.0f, 0.0f, 0.0f);
    }
    return self;
}

- (UIEdgeInsets)alignmentRectInsets
{
    UIEdgeInsets insets = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f);
    
    if (self.isLeft)
    {
        insets = UIEdgeInsetsMake(0.0f, 10.0f, 0.0f, 0.0f);
    }
    else
    {
        // right button.
        insets = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 10.0f);
    }

    
    return insets;
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
