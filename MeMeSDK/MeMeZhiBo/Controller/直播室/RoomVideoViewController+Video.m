//
//  RoomVideoViewController+Video.m
//  memezhibo
//
//  Created by Xingai on 15/6/8.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "RoomVideoViewController+Video.h"
#import "TTShowRemote+Live.h"
#import "RoomVideoViewController+Timer.h"
#import "RoomVideoViewController+Socket.h"

@implementation RoomVideoViewController (Video)

- (void)setupMediaPath
{
    [self.dataManager.remote  _retrieveVideoUrl:self.currentRoom._id completion:^(NSString *string, NSError *error){
        if (string != nil && error == nil)
        {
            self.videoURLString = string;
            [self setupMediaPlayer1];
            
        }
    }];

}

- (void)setupMediaPlayer1
{
    // Remote event.
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    
    
    if (!self.mediaPlayer1)
    {
        self.mediaPlayer1 = [[CyberPlayerController alloc] init];
        self.mediaPlayer1.initialPlaybackTime = 6.0;
        self.mediaPlayer1.view.frame = CGRectMake(0, 0, kScreenWidth, 240*kRatio);
        
        [self.view addSubview:self.mediaPlayer1.view];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        [self.mediaPlayer1.view addGestureRecognizer:tapGesture];
    }
    [self.view insertSubview:self.mediaPlayer1.view aboveSubview:self.playerContainer];
    [self startPlayback];
}


- (void)setupPlayerContainer
{
    // Player Container.
    if (!self.playerContainer) {
        PlayerLayerView *plv = [[PlayerLayerView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 240*kRatio)];
        self.playerContainer = plv;
        self.playerContainer.backgroundColor = kCyanColor;
        [self.view addSubview:self.playerContainer];
    }

    // Add Tap gesture.
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self.playerContainer addGestureRecognizer:tapGesture];
}

// Gesture event.
- (void)handleTap:(UITapGestureRecognizer *)sender
{
    [self.keyboard.textField resignFirstResponder];
    if (self.userPanel) {
        [UIView animateWithDuration:0.5 animations:^{
            self.userPanel.view.alpha = 0.0f;
        }];
    }
    if (self.giftListDisplay) {
        [UIView animateWithDuration:0.5 animations:^{
            self.giftController.view.frame = CGRectMake(0.0f, kScreenHeight, kScreenWidth, 122+240*kRatio);
            self.giftController.gifttextView.frame = CGRectMake(0, self.giftController.view.frame.size.height-50, kScreenWidth, 50);
            [self.giftController.gifttextView.giftNumberFild resignFirstResponder];
            
            
        }completion:^(BOOL finished) {
            
            finished ? self.giftListDisplay = NO : 0;
            finished ? self.self.GiftViewShow = NO : 0;
        }];
        return;
    }
    
    self.isHideNavigation = !self.isHideNavigation;
    
    
    [self.navigationController setNavigationBarHidden:self.isHideNavigation animated:YES];
}



- (void)startPlayback{
    NSURL *url = [NSURL URLWithString:self.videoURLString];
    if (!url)
    {
        url = [NSURL URLWithString:[self.videoURLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    /*
     switch (mpPlayerController.playbackState) {
     case MPMoviePlaybackStateStopped:
     [mpPlayerController setContentURL:url];
     [mpPlayerController prepareToPlay];
     break;
     case MPMoviePlaybackStatePaused:
     [mpPlayerController play];
     break;
     case MPMoviePlaybackStatePlaying:
     [mpPlayerController pause];
     break;
     default:
     break;
     }
     */
    
    switch (self.mediaPlayer1.playbackState) {
        case CBPMoviePlaybackStateStopped:
        case CBPMoviePlaybackStateInterrupted:
            [self.mediaPlayer1 setContentURL:url];
            //[cbPlayerController setExtSubtitleFile:[self getTestFilePath]];
            //初始化完成后直接播放视频，不需要调用play方法
            self.mediaPlayer1.shouldAutoplay = YES;
            //初始化视频文件
            [self.mediaPlayer1 prepareToPlay];
            break;
        case CBPMoviePlaybackStatePlaying:
            //如果当前正在播放视频时，暂停播放。
            [self.mediaPlayer1 pause];
            break;
        case CBPMoviePlaybackStatePaused:
            //如果当前播放视频已经暂停，重新开始播放。
            [self.mediaPlayer1 start];
            
            [self.mediaPlayer1 setContentURL:url];
            //[cbPlayerController setExtSubtitleFile:[self getTestFilePath]];
            //初始化完成后直接播放视频，不需要调用play方法
            self.mediaPlayer1.shouldAutoplay = YES;
            //初始化视频文件
            [self.mediaPlayer1 prepareToPlay];
            break;
        default:
            break;
    }
}

-(void)becomeActive:(NSNotification *)notification
{
    if (self.mediaPlayer1.playbackState == CBPMoviePlaybackStatePaused){

        self.loadingView.hidden = NO;
        [self.loadingView setLoadingAnimation];
        [self startPlayback];
        [self setupSocketIO];
    } else {

    }
}

-(void)enterBackground:(NSNotification *)notification
{
    
}

@end
