//
//  ChargeScrollTipView.m
//  TTShow
//
//  Created by twb on 13-11-22.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import "ChargeScrollTipView.h"

//static void *ChargeContentContext = &ChargeContentContext;
//
//#define kKeyFrame                @"frame"
#define kChargeScrollTipDuration            (5.0f)
#define kChargeScrollPadding                (15.0f)
#define kCharegScrollLeftWaitDuration       (1.0f)
#define kCharegScrollRightWaitDuration      (3.0f)

@implementation ChargeScrollTipView

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
    
    self.bg.image = kImageNamed(@"img_seg_normal_7.png");
    
    double delayInSeconds = kCharegScrollRightWaitDuration;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self scrollToLeftEnd];
    });
}


- (void)scrollToLeftEnd
{
    if (isAnimating)
    {
        return;
    }
    
    CGRect frame = self.content.frame;
    isAnimating = YES;
    [UIView animateWithDuration:kChargeScrollTipDuration animations:^{
        self.content.frame = CGRectMake(kScreenWidth - frame.size.width - kChargeScrollPadding, frame.origin.y, frame.size.width, frame.size.height);
    } completion:^(BOOL finished) {
        isAnimating = NO;
        double delayInSeconds = kCharegScrollLeftWaitDuration;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [self scrollToRightEnd];
        });
    }];
}

- (void)scrollToRightEnd
{
    if (isAnimating)
    {
        return;
    }
    
    CGRect frame = self.content.frame;
    isAnimating = YES;
    [UIView animateWithDuration:kChargeScrollTipDuration animations:^{
        self.content.frame = CGRectMake(kChargeScrollPadding, frame.origin.y, frame.size.width, frame.size.height);
    } completion:^(BOOL finished) {
        isAnimating = NO;
        double delayInSeconds = kCharegScrollRightWaitDuration;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [self scrollToLeftEnd];
        });
    }];
}

//- (void)scrollView
//{
//    CGRect frame = self.content.frame;
//    if (scrollFromLeftToRight)
//    {
//        [UIView animateWithDuration:kChargeScrollTipDuration animations:^{
//            self.content.frame = CGRectMake(kScreenWidth - frame.size.width, frame.origin.y, frame.size.width, frame.size.height);
//        } completion:^(BOOL finished) {
//            scrollFromLeftToRight = NO;
//        }];
//    }
//    else
//    {
//        [UIView animateWithDuration:kChargeScrollTipDuration animations:^{
//            self.content.frame = CGRectMake(0.0f, frame.origin.y, frame.size.width, frame.size.height);
//        } completion:^(BOOL finished) {
//            scrollFromLeftToRight = YES;
//        }];
//    }
//}

- (void)dealloc
{
//    [self removeObserverForContent];
    
//    [scrollTipTimer invalidate];
//    scrollTipTimer = nil;
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
