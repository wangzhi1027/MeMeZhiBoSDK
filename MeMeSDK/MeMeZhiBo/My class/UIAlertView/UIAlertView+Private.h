//
//  UIAlertView+Private.h
//  TTShow
//
//  Created by twb on 13-6-4.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertView (Private)

+ (void)showErrorMessage:(NSString *)message;
+ (void)showInfoMessage:(NSString *)message;

// Charge
+ (id)showChargeMessageWithdelegate:(id)delegate;

+ (id)showConfirmMessage:(NSString *)message delegate:(id /*<UIAlertViewDelegate>*/)delegate;
+ (id)showConfirmMessage:(NSString *)message cancelTitle:(NSString *)cancelTitle confirmTitle:(NSString *)confirmTitle delegate:(id /*<UIAlertViewDelegate>*/)delegate;
+ (id)showTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelTitle Message:(UIView *)contentView delegate:(id /*<UIAlertViewDelegate>*/)delegate;

@end
