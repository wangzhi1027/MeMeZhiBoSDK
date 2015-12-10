//
//  TTShowUIManager.m
//  memezhibo
//
//  Created by Xingai on 15/5/15.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "TTShowUIManager.h"
#import "ChargeViewController.h"
#import "ThirdPayViewController.h"
#import "ChargeFromTPViewController.h"
#import "WapPayViewController.h"
#import "NSBundle+SDK.h"
#import "RoomVideoViewController.h"

@implementation TTShowUIManager


// Login From Third Party Interface

+ (instancetype)sharedInstance
{
    static id instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init];
    });
    
    return instance;
}

- (id)init
{
    self = [super init];
    if (self) {
        
#if 0
        // Center
        _centerViewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
        _mainNavigationController = [[NavigationController alloc] initWithRootViewController:self.centerViewController];
        
        // Left
        _leftController = [[CategoriesViewController alloc] initWithNibName:nil bundle:nil];
        
        // Right
        _rightController = [[UserViewController alloc] initWithNibName:nil bundle:nil];
        
        _rootViewController = [[JASidePanelController alloc] init];
        _rootViewController.shouldDelegateAutorotateToVisiblePanel = NO;
        _rootViewController.centerPanel = self.mainNavigationController;
        _rootViewController.leftPanel = self.leftController;
        _rootViewController.rightPanel = self.rightController;
#else
        
#endif
        
        // Global Kit
        _global = [UIGlobalKit sharedInstance];
    }
    return self;
}

- (void)showAgreement:(void (^)(CustomIOS7AlertView *alertView, NSInteger buttonIndex))onButtonTouchUpInside
{
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectZero];
    NSError *error = nil;
    NSString *agreeText = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"agree" ofType:@"txt"] encoding:NSUTF8StringEncoding error:&error];
    if (error != nil)
    {
    }
    textView.text = agreeText;
    textView.font = kFontOfSize(15.0f);
    textView.textColor = kDarkGrayColor;
    textView.backgroundColor = kClearColor;
    textView.editable = NO;
    textView.layer.masksToBounds = YES;
    
    CustomIOS7AlertView *alertView = [[CustomIOS7AlertView alloc] init];
    alertView.title = @"免责声明";
    [alertView setButtonTitles:@[@"接受"]];
    [alertView setContainerView:textView];
    [alertView setOnButtonTouchUpInside:onButtonTouchUpInside];
    [alertView show];
}

- (void)showRoomVideoEnterType:(VideoEnterType)type controller:(UIViewController *)v room:(TTShowRoom *)room
{
    RoomVideoViewController *rvc = [[RoomVideoViewController alloc] initWithNibName:@"RoomVideoViewController" bundle:[NSBundle SDKResourcesBundle]];
    [rvc setCurrentRoom:room];
    [rvc setEnterType:type];
    
    NavigationController *vnc = [[NavigationController alloc] initWithRootViewController:rvc];
    
    //#ifdef __ENTER_ROOM_WITH_MODAL__
    [v presentViewController:vnc animated:YES completion:^{
        
    }];
}

- (void)showStarCenter:(UIViewController *)v enterType:(UCEnterType)type userID:(NSInteger)userID roomID:(NSInteger)roomID
{
    [self showStatusBar];
}

// Charge
- (void)showChargeUI:(UIViewController *)v
{
    [self showStatusBar];
    
    if (self.isJailBreak) {
        ChargeFromTPViewController *charge = [[ChargeFromTPViewController alloc] init];
        charge.enterFromPush = NO;
        NavigationController *navigationController = [[NavigationController alloc] initWithRootViewController:charge];
        [v presentViewController:navigationController animated:YES completion:nil];
    } else {
        // IAP.
        ChargeViewController *charge = [[ChargeViewController alloc] init];
        charge.enterFromPush = YES;
        [v.navigationController pushViewController:charge animated:YES];
    }
}

- (void)showChargeFromPush:(UIViewController *)vc
{
    [self showStatusBar];
    
    if (self.isJailBreak) {
        ChargeFromTPViewController *charge = [[ChargeFromTPViewController alloc] init];
        charge.enterFromPush = YES;
        charge.hidesBottomBarWhenPushed = YES;
        [vc.navigationController pushViewController:charge animated:YES];
    }else{
        // IAP.
        ChargeViewController *charge = [[ChargeViewController alloc] init];
        charge.enterFromPush = YES;
        charge.hidesBottomBarWhenPushed = YES;
        [vc.navigationController pushViewController:charge animated:YES];
    }
}

// Third Pay

- (void)showThirdPay:(UIViewController *)v chargeMoney:(NSInteger)money
{
    ThirdPayViewController *thirdPay = [[ThirdPayViewController alloc] initWithNibName:@"ThirdPayViewController" bundle:nil];
    thirdPay.money = money;
    [v.navigationController pushViewController:thirdPay animated:YES];
}

// WapPay/
- (void)showWapPay:(UIViewController *)v payMethod:(WapPayMethod)method amount:(NSInteger)amount
{
    WapPayViewController *wapPay = [[WapPayViewController alloc] initWithNibName:@"WapPayViewController" bundle:[NSBundle SDKResourcesBundle]];
    wapPay.payMethod = method;
    wapPay.amount = amount;
    [v.navigationController pushViewController:wapPay animated:YES];
}


- (void)showStatusBar
{
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
}

- (void)exitBack:(UIViewController *)v
{
    [v.navigationController popViewControllerAnimated:YES];
}

- (void)exitDimiss:(UIViewController *)v
{
    [v dismissViewControllerAnimated:YES completion:NULL];
}

- (void)showLightStatusBar
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
}

@end
