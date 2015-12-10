//
//  TTShowUIManager.h
//  memezhibo
//
//  Created by Xingai on 15/5/15.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JASidePanelController.h"
#import <UIKit/UIKit.h>
#import "TTShowRoom.h"


@class CustomIOS7AlertView;
@class RoomVideoViewController;


@interface TTShowUIManager : NSObject

@property (nonatomic, assign) BOOL isJailBreak;
@property (nonatomic, readonly) UIGlobalKit *global;
@property (nonatomic, strong) JASidePanelController *rootViewController;

+ (instancetype)sharedInstance;

// User Manager UI
// Login From Third Party Interface
- (void)showQQLogin:(UIViewController *)v enter:(EnterType)type flag:(NSInteger)flag;
- (void)exitBack:(UIViewController *)v;
- (void)exitDimiss:(UIViewController *)v;
- (void)showLightStatusBar;


- (void)showAgreement:(void (^)(CustomIOS7AlertView *alertView, NSInteger buttonIndex))onButtonTouchUpInside;
- (void)showRoomVideoEnterType:(VideoEnterType)type controller:(UIViewController *)v room:(TTShowRoom *)room;
- (void)showStarCenter:(UIViewController *)v enterType:(UCEnterType)type userID:(NSInteger)userID roomID:(NSInteger)roomID;

// IAP
- (void)showChargeUI:(UIViewController *)v;
// Third Pay
- (void)showThirdPay:(UIViewController *)v chargeMoney:(NSInteger)money;

- (void)showWapPay:(UIViewController *)v payMethod:(WapPayMethod)method amount:(NSInteger)amount;
@end
