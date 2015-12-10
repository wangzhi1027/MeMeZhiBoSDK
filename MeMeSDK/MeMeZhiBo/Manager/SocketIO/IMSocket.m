//
//  TTShowSocket.m
//  TTShow
//
//  Created by wangyifeng on 15-2-10.
//  Copyright (c) 2015年 twb. All rights reserved.
//

#import "IMSocket.h"
#import "IM.h"
#import "Group.h"
#import "CommonDataAccess.h"
#import "TTShowFriend.h"

@implementation IMSocket

+ (instancetype)getInstance
{
    static id instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init];
    });
    
    return instance;
}

- (id)init
{
    [self setupSocketIO];
    return [super init];
}

- (NSString *)baseSocketUrlStr
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"testMode"] ? @"test.im.2339.com" : @"im.2339.com";
}

- (TTShowDataManager *)dataManager
{
    return [Manager sharedInstance].dataManager;
}

- (TTShowUser *)me
{
    return [Manager sharedInstance].dataManager.me;
}
- (void)setupSocketIO
{
    if (self.socketIO)
    {
        self.socketIO.delegate = nil;
        [self.socketIO disconnect];
        self.socketIO = nil;
    }
    
    SocketIO *socket = [[SocketIO alloc] initWithDelegate:self];
    self.socketIO = socket;
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSString *access_token = [TTShowUser access_token];
    [dict setValue:access_token forKey:@"access_token"];
    [self.socketIO connectToHost:[self baseSocketUrlStr] onPort:90 withParams:dict];
    
}

- (void) sendMessage:(NSString *)msg
{
    [self.socketIO sendMessage:msg];
}


// Close Socket.IO
- (void)closeSockIO
{
    self.socketIO.delegate = nil;
    [self.socketIO disconnect];
    self.socketIO = nil;
}

- (void)connectSockIO
{
    [self setupSocketIO];
}

#pragma mark - SocketIODelegate

- (void) socketIODidConnect:(SocketIO *)socket
{
    //    [self getUread];
    NSLog(@"im socket connected");

    
    [self sendMessage:@"{\"action\":\"im.get_unread\"}"]; //请求未接收消息列表
    [self sendMessage:@"{\"action\":\"friend.get_unread\"}"]; //请求未接收好友操作消息列表(好友申请、同意好友申请、删除好友)
    long long int latestGroupMessageTimestamp = [self.dataManager.commonDA getLatestUserGroupsMessageTime:self.dataManager.me._id];
    [[TMCache sharedCache] objectForKey:CACHE_LAST_IM_SOCKET_DISCONNECT_TIME block:^(TMCache *cache, NSString *key, id object) {
        long long int latestSocketDisconnectTimestamp = [object longLongValue];
    }];
}

- (void) socketIODidDisconnect:(SocketIO *)socket disconnectedWithError:(NSError *)error
{

    if (self.socketIO) {
        long long int timestamp = (long long int) [[NSDate date] timeIntervalSince1970] * 1000;
        [[TMCache sharedCache] setObject:[NSNumber numberWithLongLong:timestamp] forKey:CACHE_LAST_IM_SOCKET_DISCONNECT_TIME];
    }
    NSLog(@"im socket disconnected");
}

- (void) socketIO:(SocketIO *)socket didReceiveMessage:(SocketIOPacket *)packet
{
    [self handleReceivedMessage:packet.data];
    //save to db
    NSLog(@"im socket recv");
}

- (void) socketIO:(SocketIO *)socket didReceiveJSON:(SocketIOPacket *)packet
{
    NSLog(@"im socket recv json");
}

- (void) socketIO:(SocketIO *)socket didReceiveEvent:(SocketIOPacket *)packet
{
    NSLog(@"im socket recv event");
}

- (void) socketIO:(SocketIO *)socket didSendMessage:(SocketIOPacket *)packet
{

    // NSLog(@"im socket send msg out");
}

- (void) socketIO:(SocketIO *)socket onError:(NSError *)error
{
    NSLog(@"im socket connection error:%@", [error localizedDescription]);
}


- (void)handleReceivedMessage:(id)data
{
    if (![data isKindOfClass:[NSString class]])
    {
        return;
    }
    
    NSDictionary *jsonData = [data JSONValue];
    if (![jsonData isKindOfClass:[NSDictionary class]])
    {
        return;
    }
    
    NSLog(@"im socket jsonData = %@", jsonData);
    
    
    // Parse Nofity Mode.
    NSString *actionName = [jsonData valueForKey:@"action"];
    
    if ([actionName isEqualToString:@"im.chat"])
    {
        NSDictionary *data = [jsonData valueForKey:@"data"];
        NSInteger userID = self.dataManager.me._id;
        FriendRecvMessage* message = [[FriendRecvMessage alloc] initWithDictionary:data error:nil];
        FriendMessage *dbMessage = [[FriendMessage alloc] initWithAttributes:userID withFriendID:message.from._id withMessage:message.message withSendStatus:MSG_STATUS_RECEIVE withTimestamp:message.timestamp];
        if (!message.from.pic && self.dataManager.friendList) {
            for (TTShowFriend *friend in self.dataManager.friendList) {
                if (friend._id == message.from._id) {
                    message.from.pic = friend.pic;
                }
            }
        }
        
        
        [self.dataManager.commonDA addFriendMessage:dbMessage];
        
        [self addFriendConversation:message.from._id friendName:message.from.nick_name friendPic:message.from.pic msgContent:message.message timestamp:message.timestamp msgCount:1];
        
        [kNotificationCenter postNotificationName:kNotificationSocketFriendMessage object:dbMessage];
    }
    else if ([actionName isEqualToString:@"friend.add"])
    {
        BOOL isFriendApplyNotifyOn = true;
        if (isFriendApplyNotifyOn) {
            NSDictionary *data = [jsonData valueForKey:@"data"];
            FriendApplyMessage *message = [[FriendApplyMessage alloc] initWithDictionary:data error:nil];
            
            [[TMCache sharedCache] objectForKey:CACHE_NEW_FRIEND_APPLY_IDS block:^(TMCache *cache, NSString *key, id object) {
                    NSMutableSet *set = (NSMutableSet *) object;
                    if (!set) {
                        set = [[NSMutableSet alloc] initWithCapacity:0];
                    }
                    [set addObject:@(message._id)];
                    [[TMCache sharedCache] setObject:set forKey:CACHE_NEW_FRIEND_APPLY_IDS];
                    [kNotificationCenter postNotificationName:kNotificationSocketFriendApply object:message];
            }];
        }
    }
    else if ([actionName isEqualToString:@"friend.del"])
    {
        NSDictionary *data = [jsonData valueForKey:@"data"];
        FriendDelMessage *message = [[FriendDelMessage alloc] initWithDictionary:data error:nil];
        [kNotificationCenter postNotificationName:kNotificationSocketFriendDel object:message];
    }
    else if ([actionName isEqualToString:@"friend.agree"])
    {
        NSDictionary *data = [jsonData valueForKey:@"data"];
        FriendAgreeMessage *message = [[FriendAgreeMessage alloc] initWithDictionary:data error:nil];
        NSInteger userID = self.dataManager.me._id;
        NSString *msgContent = @"我同意了你的好友申请，快来和我聊天吧！";
        if (!message.pic_url && self.dataManager.friendList) {
            for (TTShowFriend *friend in self.dataManager.friendList) {
                if (friend._id == message._id) {
                    message.pic_url = friend.pic;
                }
            }
        }
        FriendMessage *dbMessage = [[FriendMessage alloc] initWithAttributes:userID withFriendID:message._id withMessage:msgContent withSendStatus:MSG_STATUS_SYS_MSG withTimestamp:message.timestamp];
        
        [self.dataManager.commonDA addFriendMessage:dbMessage];
        
        [self addFriendConversation:message._id friendName:message.nick_name friendPic:message.pic_url msgContent:msgContent timestamp:message.timestamp msgCount:1];
        
        [kNotificationCenter postNotificationName:kNotificationSocketFriendAgree object:dbMessage];
    }
    else if ([actionName isEqualToString:@"im.unread_list"])
    {
        NSDictionary *data = [jsonData valueForKey:@"data"];

        if ((NSNull *)data == [NSNull null]) {
            return;
        }
        for (NSString* key in data) {
            NSInteger friendID = [key intValue];
            NSInteger userID = self.dataManager.me._id;
            NSArray *msgList = [data valueForKey:key];

            if ((NSNull *)msgList != [NSNull null] && msgList.count > 0) {
                
                for (NSDictionary *dict in msgList) {
                    FriendRecvMessage* message = [[FriendRecvMessage alloc] initWithDictionary:dict error:nil];
                    [self.dataManager.commonDA addFriendMessage:[[FriendMessage alloc] initWithAttributes:userID withFriendID:friendID withMessage:message.message withSendStatus:MSG_STATUS_RECEIVE withTimestamp:message.timestamp]];
                }
                
                FriendRecvMessage* latestMsg = [[FriendRecvMessage alloc] initWithDictionary:msgList[msgList.count - 1] error:nil];
                if (!latestMsg.from.pic && self.dataManager.friendList) {
                    for (TTShowFriend *friend in self.dataManager.friendList) {
                        if (friend._id == latestMsg.from._id) {
                            latestMsg.from.pic = friend.pic;
                        }
                    }
                }
                [self addFriendConversation:friendID friendName:latestMsg.from.nick_name friendPic:latestMsg.from.pic msgContent:latestMsg.message timestamp:latestMsg.timestamp msgCount:msgList.count];
                [kNotificationCenter postNotificationName:kNotificationSocketFriendUnReadList object:nil];
            }
            
        }
    }
    else if ([actionName isEqualToString:@"friend.unread_list"])
    {
        NSArray *msgList = [jsonData valueForKey:@"data"];

        if ((NSNull *)msgList != [NSNull null] && msgList.count > 0) {
            for (NSString *msg in msgList) {
                if ([msg isKindOfClass:[NSString class]]) {
                    [self handleReceivedMessage:msg];
                }
            }
        }
    }
    else if ([actionName isEqualToString:@"wo.chat"])
    {
        NSDictionary *data = [jsonData valueForKey:@"data"];

        GroupRecvMessage *message = [[GroupRecvMessage alloc] initWithDictionary:data error:nil];
        if (message.from._id == self.me._id) {
            return;
        }
        GroupMessage *groupDBMessage = [[GroupMessage alloc] initWithAttributes:message.wo_id withUid:self.me._id withMsgType:message.msg_type withGroupName:message.wo_name withFromID:message.from._id withFromName:message.from.nick_name withFromPic:message.from.pic withSpendCoins:message.from.coin_spend withMsg:message.message.msg withPic:message.message.pic withLocation:message.message.location withAudioUrl:message.message.audio_url withSeconds:message.message.seconds withTimestamp:message.timestamp withAudioReadStatus:AUDIO_READ_STATUS_UNREAD withSendStatus:MSG_STATUS_RECEIVE withBackgroundColor:[UIColor randomRGBValue] coins:0];
        
        [self.dataManager.commonDA addGroupMessage:groupDBMessage];
        
        NSInteger userID = self.dataManager.me._id;
        NSInteger unReadMsgCount = 0;

        if (message.wo_id != self.dataManager.currentChatGroupID) {
            BOOL isGroupMessageNotifyOn = YES;
            id on = [self.dataManager.groupSwitch objectForKey:[NSString stringWithFormat:@"%d", (int)message.wo_id]];
            if (on) {
                isGroupMessageNotifyOn = [on boolValue];
            }
            unReadMsgCount = [self.dataManager.commonDA getConversationUnReadCount:userID withConversationID:message.wo_id] + (isGroupMessageNotifyOn ? 1 : 0);
        }
        
        NSString *pic = @"";
        for (TTShowXiaowoInfo *groupInfo in self.dataManager.myGroupList) {
            if (groupInfo._id == message.wo_id) {
                pic = groupInfo.pic;
                break;
            }
        }
//        [self.dataManager.commonDA addConversation:[[Conversation alloc] initWithAttributes:message.wo_id userID:userID friendID:message.from._id msgType:message.msg_type groupName:message.wo_name fromName:message.from.nick_name msg:message.message.msg pic:pic audioUrl:message.message.audio_url duration:message.message.seconds timestamp:message.timestamp unReadCount:unReadMsgCount]];
        
        [kNotificationCenter postNotificationName:kNotificationSocketGroupMessage object:groupDBMessage];
    }
}

- (void)addFriendConversation:(NSInteger)fid friendName:(NSString *)friendName friendPic:(NSString *)pic msgContent:(NSString *)content timestamp:(long long int)timestamp msgCount:(NSInteger)msgCount
{
    NSInteger userID = self.dataManager.me._id;
    NSInteger unReadMsgCount = 0;
    if (fid != self.dataManager.currentChatFriendID) {
        BOOL isFriendMessageNotifyOn = YES;
        unReadMsgCount = [self.dataManager.commonDA getConversationUnReadCount:userID withConversationID:fid] + (isFriendMessageNotifyOn ? msgCount : 0);
    }
    [self.dataManager.commonDA addConversation:[[Conversation alloc] initWithAttributes:fid userID:userID friendID:fid msgType:MSG_TYPE_FRIEND groupName:@"" fromName:friendName msg:content pic:pic audioUrl:@"" duration:0 timestamp:timestamp unReadCount:unReadMsgCount]];
}

@end
