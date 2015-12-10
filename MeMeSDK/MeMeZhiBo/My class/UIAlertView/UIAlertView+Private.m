//
//  UIAlertView+Private.m
//  TTShow
//
//  Created by twb on 13-6-4.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import "UIAlertView+Private.h"

@implementation UIAlertView (Private)

+ (void)showErrorMessage:(NSString *)message
{
    [[[self alloc] initWithTitle:@"错误" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
}

+ (void)showInfoMessage:(NSString *)message
{
    [[[self alloc] initWithTitle:@"信息" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
}

+ (id)showChargeMessageWithdelegate:(id)delegate
{
    return [[self alloc] initWithTitle:@"信息" message:@"您的余额不足,请充值" delegate:delegate cancelButtonTitle:@"取消" otherButtonTitles:@"充值", nil];
}

+ (id)showConfirmMessage:(NSString *)message delegate:(id /*<UIAlertViewDelegate>*/)delegate
{
    return [[self class] showConfirmMessage:message cancelTitle:@"取消" confirmTitle:@"确定" delegate:delegate];
}

+ (id)showConfirmMessage:(NSString *)message cancelTitle:(NSString *)cancelTitle confirmTitle:(NSString *)confirmTitle delegate:(id /*<UIAlertViewDelegate>*/)delegate
{
    return [[self alloc] initWithTitle:@"提示" message:message delegate:delegate cancelButtonTitle:cancelTitle otherButtonTitles:confirmTitle, nil];
}

+ (id)showTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelTitle Message:(UIView *)contentView delegate:(id /*<UIAlertViewDelegate>*/)delegate
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:@"\n\n\n\n\n\n\n" delegate:delegate cancelButtonTitle:cancelTitle otherButtonTitles:nil, nil];
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(22.0f, 45.0f, 240.0f, 150.0f)];
    textView.text = @"This is what i am trying to add in alertView.\nHappy New Year Farmers! The new Winter Fantasy Limited Edition Items have arrived! Enchant your orchard with a Icy Peach Tree, and be the first farmer among your friends to have the Frosty Fairy Horse. Don't forget that the Mystery Game has been refreshed with a new Winter Fantasy Animal theme! ";
    textView.keyboardAppearance = UIKeyboardAppearanceAlert;
    textView.editable = NO;
    textView.layer.cornerRadius = 6.0f;
    textView.layer.masksToBounds = YES;
    [alert addSubview:textView];
    
    return alert;
}

@end
