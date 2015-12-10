//
//  RoomVideoViewController+Chat.h
//  memezhibo
//
//  Created by Xingai on 15/6/9.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "RoomVideoViewController.h"

typedef NS_ENUM(NSInteger, ChatRoomUserPriv)
{
    kChatManager = 1,
    kChatAnchor,
    kChatNormal,
    kChatCService,
    kChatAgent,
    kChatMax
};

@interface RoomVideoViewController (Chat)

- (void)handleReceivedMessage:(id)data;

- (void)oneToOne:(NSDictionary *)json isFromMe:(BOOL)fromMe isToMe:(BOOL)toMe isPrivate:(BOOL)private mode:(ChatRoomNotifyMode)mode;
- (void)updateChatHistoryUI;

@end
