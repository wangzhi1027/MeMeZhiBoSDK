//
//  NavigationItemImageButton.m
//  iCheaper
//
//  Created by twb on 13-4-15.
//  Copyright (c) 2013年 IBM. All rights reserved.
//

#import "NavigationItemImageButton.h"

@implementation NavigationItemImageButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundImage:[kImageNamed(@"img_navbar_bg_normal.png") resizableImageWithCapInsets:UIEdgeInsetsMake(0.0f, 4.0f, 0.0f, 4.0f)] forState:UIControlStateNormal];
        [self setBackgroundImage:[kImageNamed(@"img_navbar_bg_press.png") resizableImageWithCapInsets:UIEdgeInsetsMake(0.0f, 4.0f, 0.0f, 4.0f)] forState:UIControlStateHighlighted];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)setImageNormal:(NSString *)image
{
    [self setImage:kImageNamed(image) forState:UIControlStateNormal];
}

- (void)setImageHighlighted:(NSString *)image
{
    [self setImage:kImageNamed(image) forState:UIControlStateHighlighted];
}

@end
