//
//  TTPageControl.m
//  TTShow
//
//  Created by twb on 13-7-25.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import "TTPageControl.h"

@implementation TTPageControl

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
        

        self.pageIndicatorTintColor = kLightGrayColor;
        self.currentPageIndicatorTintColor = kDarkGrayColor;


    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        

        self.pageIndicatorTintColor = kLightGrayColor;
        self.currentPageIndicatorTintColor = kDarkGrayColor;

    }
    return self;
}

- (void)swapDot
{
    UIImage *tempDot = activeImage;
    activeImage = inactiveImage;
    inactiveImage = tempDot;
}

- (void)updateDots
{
    for (int i = 0; i < [self.subviews count]; i++)
    {
        UIImageView* dot = [self.subviews objectAtIndex:i];
        if ([dot isKindOfClass:[UIImageView class]])
        {
            if (i == self.currentPage)
            {
                dot.image = activeImage;
            }
            else
            {
                dot.image = inactiveImage;
            }
        }
    }
}

- (void)setCurrentPage:(NSInteger)page
{
    [super setCurrentPage:page];
//    if (kSystemVersionGreaterOrEqualThan(7.0f))
//    {
//        // do nothing.
//    }
//    else
//    {
//        [self updateDots];
//    }
    
}

#pragma mark - Life cycle.

- (void)dealloc
{
    activeImage = nil;
    inactiveImage = nil;
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
