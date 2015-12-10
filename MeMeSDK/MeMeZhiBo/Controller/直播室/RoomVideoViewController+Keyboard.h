//
//  RoomVideoViewController+Keyboard.h
//  memezhibo
//
//  Created by Xingai on 15/6/9.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "RoomVideoViewController.h"

@interface RoomVideoViewController (Keyboard)<sendDelegate,AndWhoListViewDelegate,MyInfoDelegate>

- (void)registerKeyboardNotification;

- (void)unregisterKeyboardNotification;

- (void)sendMessage:(NSString *)content;

-(void)giftListShow;

- (BOOL)meCanPrivateChat;

-(void)bgViewhandleTap:(UIGestureRecognizer*)sender;

-(void)outBtnClick:(id)sender;

@end
