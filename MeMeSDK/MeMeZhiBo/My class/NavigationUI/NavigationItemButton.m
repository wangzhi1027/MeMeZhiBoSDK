//
//  NavigationItemButton.m
//  iCheaper
//
//  Created by twb on 13-4-12.
//  Copyright (c) 2013年 IBM. All rights reserved.
//

#import "NavigationItemButton.h"

@implementation NavigationItemButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [self setupInitailize];
        
    }
    return self;
}

#pragma mark - setup part.

- (void)setupInitailize
{
    [self.titleLabel setFont:[UIFont systemFontOfSize:18.0f]];
    [self.titleLabel setShadowColor:kBlackColor];
    [self.titleLabel setShadowOffset:CGSizeMake(0.0f, 1.0f)];
    [self setTitleColor:kWhiteColor forState:UIControlStateNormal];    

    [self setBackgroundImage:kImageNamed(@"img_navbar_bg_normal.png") forState:UIControlStateNormal];
    [self setBackgroundImage:kImageNamed(@"img_navbar_bg_press.png") forState:UIControlStateHighlighted];
}

#pragma mark - event part.

- (void)setButtonTitle:(NSString *)title
{
    [self setTitle:title forState:UIControlStateNormal];
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
