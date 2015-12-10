//
//  RoomVideoViewController+Timer.m
//  memezhibo
//
//  Created by Xingai on 15/6/10.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "RoomVideoViewController+Timer.h"
#import "RoomVideoViewController+Remote.h"

@implementation RoomVideoViewController (Timer)

- (void)setupTimer
{
    self.autoHideNavigationTimer = [NSTimer scheduledTimerWithTimeInterval:6.0f target:self selector:@selector(handleAutoHideNavigation:) userInfo:nil repeats:NO];
    
    self.updateAudiencesTimer = [NSTimer scheduledTimerWithTimeInterval:10.0f target:self selector:@selector(handleAudience:) userInfo:nil repeats:YES];
}

- (void)handleAutoHideNavigation:(NSTimer *)timer
{
    if (self.isHideNavigation || !self.isAutoHideNavBar)
    {
        [self.autoHideNavigationTimer invalidate];
        self.autoHideNavigationTimer = nil;
        return;
    }
    self.isHideNavigation = !self.isHideNavigation;
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)handleAudience:(NSTimer *)timer
{
    [self retrieveAudienceList];
}

- (void)killTimer
{
    if (self.updateAudiencesTimer) {
        [self.updateAudiencesTimer invalidate];
        self.updateAudiencesTimer = nil;
    }
#ifdef __LIVE_SOFA_FEATHURE_ON__
    [updateActiveValueTimer invalidate];
    updateActiveValueTimer = nil;
#endif
}

@end
