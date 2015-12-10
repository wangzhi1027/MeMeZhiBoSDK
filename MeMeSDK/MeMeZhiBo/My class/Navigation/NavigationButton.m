//
//  NavigationButton.m
//  TTCX
//
//  Created by twb on 13-5-31.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import "NavigationButton.h"

#define kBackButtonNormalImageName @"header-back.png"
#define kBackButtonHighlightedImageName @"header-back-pressed.png"

#define kButtonNormalImageName @"header-txt-btn.png"
#define kButtonHighlightedImageName @"header-txt-btn-pressed.png"

#define kLabelButtonImagePaddingX (0.0f)
#define kLabelButtonImagePaddingY (4.0f)    // for UI tuning
#define kLabelButtonImageEdgeInset UIEdgeInsetsMake(kLabelButtonImagePaddingX, kLabelButtonImagePaddingY, kLabelButtonImagePaddingX, kLabelButtonImagePaddingY)

@implementation NavigationButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

#pragma mark - setup part.

- (void)setupInitailize
{
    [self.titleLabel setFont:[UIFont systemFontOfSize:18.0f]];
    [self setTitleColor:kBlackColor forState:UIControlStateNormal];
    [self setBackgroundImage:[kImageNamed(kButtonNormalImageName) resizableImageWithCapInsets:kLabelButtonImageEdgeInset] forState:UIControlStateNormal];
    [self setBackgroundImage:[kImageNamed(kButtonHighlightedImageName) resizableImageWithCapInsets:kLabelButtonImageEdgeInset] forState:UIControlStateHighlighted];
}

#pragma mark - event part.

- (void)setButtonTitle:(NSString *)title
{
    [self setTitle:title forState:UIControlStateNormal];
}

- (void)setButtonNormalImage:(NSString *)n HighlightedImage:(NSString *)l
{
    [self setImage:kImageNamed(n) forState:UIControlStateNormal];
    [self setImage:kImageNamed(l) forState:UIControlStateHighlighted];
}

- (void)setForBackButton
{
    [self setButtonNormalImage:kBackButtonNormalImageName HighlightedImage:kBackButtonHighlightedImageName];
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
