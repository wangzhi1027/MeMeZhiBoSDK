//
//  ChargeScrollTipView.h
//  TTShow
//
//  Created by twb on 13-11-22.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kChargeScrollTipViewHeight (50.0f)

@interface ChargeScrollTipView : UIView
{
//    NSTimer *scrollTipTimer;
//    BOOL scrollFromLeftToRight;
    BOOL isAnimating;
}

@property (weak, nonatomic) IBOutlet UIImageView *bg;
@property (weak, nonatomic) IBOutlet UILabel *content;

@end
