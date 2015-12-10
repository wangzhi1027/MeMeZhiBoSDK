//
//  TransNavImageItem.m
//  TTShow
//
//  Created by twb on 13-8-30.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import "TransNavImageItem.h"

@implementation TransNavImageItem

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundImage:kImageNamed(@"img_nav_btn_transparent_bg.png") forState:UIControlStateNormal];
    }
    return self;
}

- (void)setCurrentType:(ChatRoomNavigationItemType)currentType
{
    _currentType = currentType;
    
    switch (currentType)
    {
        case kBackNavigationItem:
            [self setImage:kImageNamed(@"img_live_back.png") forState:UIControlStateNormal];
            break;
        case kFavorNavigationItem:
            [self setImage:kImageNamed(@"img_live_favor.png") forState:UIControlStateNormal];
            break;
        case kUnfavorNavigationItem:
            [self setImage:kImageNamed(@"img_live_unfavor.png") forState:UIControlStateNormal];
            break;
        default:
            break;
    }
}

//- (UIEdgeInsets)alignmentRectInsets
//{
//    UIEdgeInsets insets;
//    if (kSystemVersionGreaterOrEqualThan(7.0))
//    {
//        if ([self isLeftButton])
//        {
//            insets = UIEdgeInsetsMake(0, 10, 0, 0);
//        }
//        else
//        {
//            insets = UIEdgeInsetsMake(0, 0, 0, 10);
//        }
//    }
//    else
//    {
//        insets = UIEdgeInsetsZero;
//    }
//    
//    return insets;
//}
//
//- (BOOL)isLeftButton
//{
//    return self.frame.origin.x < (self.superview.frame.size.width / 2);
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
