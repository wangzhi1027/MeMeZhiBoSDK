//
//  RoomVideoViewController+Delegate.h
//  memezhibo
//
//  Created by Xingai on 15/6/8.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "RoomVideoViewController.h"


typedef NS_ENUM(NSInteger, AudienceActionSheetItem)
{
    kAudienceShutupASItem,
    kAudienceCancelASItem,
    kAudienceActionSheetItemMax
};

typedef NS_ENUM(NSInteger, ShutupActionSheetItem)
{
    kShutup5MinutesASItem,
    kShutup1HourASItem,
    kShutup12HoursASItem,
    kShutupCancelASItem,
    kShutupActionSheetItemMax
};

typedef NS_ENUM(NSInteger, ChatTargetTypeSel)
{
    kChatTargetTypeFrom = 0,
    kChatTargetTypeTo,
    kChatTargetTypeCancel,
    kChatTargetTypeMax
};

typedef NS_ENUM(NSInteger, ChatLoginTipSel)
{
    kChatLoginTipLogin = 0,
    kChatLoginTipCancel,
    kChatLoginTipMax
};

typedef NS_ENUM(NSInteger, ChatReportActionSheetItem)
{
    kChatReportItem0 = 0,
    kChatReportItem1,
    kChatReportItemCancel,
    kChatReportItemMax
};

@interface RoomVideoViewController (Delegate)<AVAudioSessionDelegate,UITableViewDelegate,UIActionSheetDelegate,TTExpresionDelegate,ReportAlertviewDelegate>

- (void)showChatTargetActionSheet:(NSString *)from To:(NSString *)to;

- (void)showLoginTipActionSheet;

- (void)showReportActionSheet;

- (void)showAudienceActionSheet;

- (void)showShutupTimeActionSheet;

-(void)chargeFromDefaultAnnounceRoom;

@end
