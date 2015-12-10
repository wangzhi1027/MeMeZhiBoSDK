//
//  NavigationStyleController.h
//  TTShow
//
//  Created by twb on 14-4-21.
//  Copyright (c) 2014年 twb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NavigationStyleController : UINavigationController <UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, assign) BOOL isPopAnimating;

- (void)popWithAnimation;
//- (void)continuePopWithAnimation;
- (void)cancelPopWithAnimation;

@end

@interface UIViewController (TTNavigationController)

@property (nonatomic, strong) UIImage *backImage;

- (BOOL)isDrawerView;
- (UIBarButtonItem *)backBarButtonItem;
- (void)backToPreviousViewController;
- (void)cancelBackToPreviousViewController;

@end
