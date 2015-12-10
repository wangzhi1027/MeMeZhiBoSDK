//
//  RoomVideoViewController+Video.h
//  memezhibo
//
//  Created by Xingai on 15/6/8.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "RoomVideoViewController.h"

@interface RoomVideoViewController (Video)<AVAudioSessionDelegate>

- (void)setupPlayerContainer;
- (void)setupMediaPath;
- (void)setupMediaPlayer1;
- (void)enterBackground:(NSNotification *)notification;
- (void)becomeActive:(NSNotification *)notification;

- (void)handleTap:(UITapGestureRecognizer *)sender;

@end
