//
//  TTVideoTip.h
//  TTShow
//
//  Created by twb on 14-1-9.
//  Copyright (c) 2014年 twb. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, VideoTipType)
{
    kVideoLoadingTip,
    kVideoBufferTip,
    kVideoPlaybackTip,
    kVideoEndTip,
    kVideoErrorTip,
    kVideoTipTypeMax
};

#define kVideoTipHeight (50.0f)

@interface TTVideoTip : UIView

@property (nonatomic, assign) VideoTipType tipType;

- (void)setOfflineMessage:(NSString *)message;
@end
