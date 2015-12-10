//
//  RoomVideoViewController+Timer.h
//  memezhibo
//
//  Created by Xingai on 15/6/10.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "RoomVideoViewController.h"

@interface RoomVideoViewController (Timer)

- (void)setupTimer;
- (void)killTimer;
- (void)handleAutoHideNavigation:(NSTimer *)timer;

@end
