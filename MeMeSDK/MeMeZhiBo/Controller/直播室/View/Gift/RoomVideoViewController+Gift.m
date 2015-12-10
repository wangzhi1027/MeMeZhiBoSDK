//
//  RoomVideoViewController+Gift.m
//  memezhibo
//
//  Created by Xingai on 15/6/12.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "RoomVideoViewController+Gift.h"
#import "RoomVideoViewController+Delegate.h"
#import "RoomVideoViewController+Timer.h"
#import "NSBundle+SDK.h"
#define kRoomShowGiftListViewAnimationDuration (0.30f)
#define kRoomHideGiftListViewAnimationDuration (0.30f)

@implementation RoomVideoViewController (Gift)

#pragma mark - setup part.

- (void)setupGiftListView
{
    RoomGiftViewController *giftListView = [[RoomGiftViewController alloc] initWithNibName:@"RoomGiftViewController" bundle:[NSBundle SDKResourcesBundle]];
    self.giftController = giftListView;
    self.giftController.currentRoom = self.currentRoom;
    self.giftController.view.frame = CGRectMake(0.0f, kScreenHeight, kScreenWidth, 122+240*kRatio);
    self.giftController.delegate = self;

    
    [self.view addSubview:self.giftController.view];
    
    [self addChildViewController:self.giftController];
    
    
//    self.giftTextView = [[GiftTextView alloc] init];
//    self.giftTextView.backgroundColor = kBlackColor;
//    self.giftTextView.frame = CGRectMake(0, kScreenHeight-50, kScreenWidth, 50);
//    [self.view addSubview:self.giftTextView];
    
}

- (void)setupGiftReceiverID:(NSInteger)receiverID
{
    if (self.giftController)
    {
        self.giftController.receiverID = receiverID;
    }
}

- (void)setupGiftReceiver:(NSString *)receiver
{
    if (self.giftController)
    {
        self.giftController.receiver = receiver;
    }
}

#pragma mark - event part.

- (void)charge:(UITapGestureRecognizer *)sender
{
//    [self killTimer];
    [self.uiManager showChargeUI:self];
}

@end
