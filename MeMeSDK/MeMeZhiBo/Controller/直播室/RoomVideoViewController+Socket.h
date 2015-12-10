//
//  RoomVideoViewController+Socket.h
//  memezhibo
//
//  Created by Xingai on 15/6/9.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "RoomVideoViewController.h"

@interface RoomVideoViewController (Socket)<SocketIODelegate>

- (void)setupSocketIO;
- (void)closeSockIO;
- (void)connectSockIO;

@end
