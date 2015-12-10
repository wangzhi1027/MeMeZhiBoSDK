//
//  WapPayViewController.h
//  TTShow
//
//  Created by twb on 13-11-29.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WapPayViewController : BaseViewController

@property (nonatomic, assign) NSInteger amount;
@property (nonatomic, assign) WapPayMethod payMethod;

@property (nonatomic, strong) TTShowWapPay *wapPay;

@property (nonatomic, strong) UIActivityIndicatorView *indictorView;
@property (weak, nonatomic) IBOutlet UIWebView *payWebView;

@end
