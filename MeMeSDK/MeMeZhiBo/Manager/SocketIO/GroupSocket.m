//
//  GroupSocket.m
//  TTShow
//
//  Created by xh on 15/3/19.
//  Copyright (c) 2015年 twb. All rights reserved.
//

#import "GroupSocket.h"
#import "Group.h"
#import "GroupMessage.h"
#import "JSONModel.h"

@implementation GroupSocket

+ (instancetype)getInstance
{
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init];
    });
    return instance;
}

- (NSString *)host
{
    return self.dataManager.filter.testModeOn ? @"test.wo.2339.com" : @"wo.2339.com";
}


- (TTShowDataManager *)dataManager
{
    return [Manager sharedInstance].dataManager;
}

- (TTShowUser *)me
{
    return [Manager sharedInstance].dataManager.me;
}

- (void)sendMessage:(NSString *)msg
{
    [self.socketIO sendMessage:msg];
}

- (void)connect:(NSInteger)groupID
{
    if (self.socketIO) {
        [self disconnect];
    }
    
    SocketIO *socketIO = [[SocketIO alloc] initWithDelegate:self];
    self.socketIO = socketIO;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:@(groupID) forKey:@"wo_id"];
    NSString *access_token = [TTShowUser access_token];
    if (access_token) {
        [params setValue:access_token forKey:@"access_token"];
    }
    NSLog(@"try connect group socket %@", [self host]);
    [self.socketIO connectToHost:[self host] onPort:100 withParams:params];
}

- (void)disconnect
{
    self.socketIO.delegate = nil;
    [self.socketIO disconnect];
    self.socketIO = nil;
}

#pragma mark - SocketIODelegate

- (void) socketIODidConnect:(SocketIO *)socket
{
    //    [self getUread];
    NSLog(@"group socket connected");
}

- (void) socketIODidDisconnect:(SocketIO *)socket disconnectedWithError:(NSError *)error
{
    NSLog(@"group socket disconnected");
}

- (void) socketIO:(SocketIO *)socket didReceiveMessage:(SocketIOPacket *)packet
{
    [self handleReceivedMessage:packet.data];
    //save to db
    NSLog(@"group socket recv");
}

- (void) socketIO:(SocketIO *)socket didReceiveJSON:(SocketIOPacket *)packet
{
    NSLog(@"group socket recv json");
}

- (void) socketIO:(SocketIO *)socket didReceiveEvent:(SocketIOPacket *)packet
{
    NSLog(@"group socket recv event");
}

- (void) socketIO:(SocketIO *)socket didSendMessage:(SocketIOPacket *)packet
{
    NSLog(@"group socket send msg out");
}

- (void) socketIO:(SocketIO *)socket onError:(NSError *)error
{
    NSLog(@"group socket connection error:%@", [error localizedDescription]);
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
    
    NSString *actionName = [jsonData valueForKey:@"action"];
    
    
    if ([actionName isEqualToString:@"wo.unreadList"])
    {
        NSArray *messageList = [jsonData valueForKey:@"data"];
        if (messageList.count > 0) {
            for (NSDictionary *dict in messageList) {
                GroupRecvMessage *message = [[GroupRecvMessage alloc] initWithDictionary:dict error:nil];
                if (message.from._id == self.me._id) {
                    continue;
                }
                GroupMessage *groupDBMessage = [[GroupMessage alloc] initWithAttributes:message.wo_id withUid:self.me._id withMsgType:message.msg_type withGroupName:message.wo_name withFromID:message.from._id withFromName:message.from.nick_name withFromPic:message.from.pic withSpendCoins:message.from.coin_spend withMsg:message.message.msg withPic:message.message.pic withLocation:message.message.location withAudioUrl:message.message.audio_url withSeconds:message.message.seconds withTimestamp:message.timestamp withAudioReadStatus:AUDIO_READ_STATUS_UNREAD withSendStatus:MSG_STATUS_RECEIVE withBackgroundColor:[UIColor randomRGBValue] coins:0];
                
                

                [self.dataManager.commonDA addGroupMessage:groupDBMessage];
                
                NSString *pic = @"";
                for (TTShowXiaowoInfo *groupInfo in self.dataManager.myGroupList) {
                    if (groupInfo._id == message.wo_id) {
                        pic = groupInfo.pic;
                        break;
                    }
                }
                [self addGroupConversation:message.wo_id withFromID:message.from._id withMsgType:message.msg_type withGroupName:message.wo_name withFromName:message.from.nick_name withMsg:message.message.msg withGroupPic:pic withAudioUrl:message.message.audio_url withSeconds:message.message.seconds withTimestamp:message.timestamp];
            }
            [kNotificationCenter postNotificationName:kNotificationSocketGroupUnReadList object:nil];
        }
    }
    else if ([actionName isEqualToString:@"manage.shutup"])
    {
        NSDictionary *dict = [jsonData valueForKey:@"data_d"];

        SocketShutUp *shutUp = [[SocketShutUp alloc] initWithDictionary:dict error:nil];
        NSInteger groupID = shutUp.nest_id;
        NSString *groupName = self.dataManager.currentChatGroupName;
        NSString *msg = [NSString stringWithFormat:@"%@被禁言%d分钟", shutUp.nick_name, (int)shutUp.minute];
        GroupMessage *dbMessage = [[GroupMessage alloc] initWithAttributes:groupID withUid:self.me._id withMsgType:MSG_TYPE_GROUP_SYS_MSG withGroupName:groupName withFromID:shutUp.xy_user_id withFromName:shutUp.nick_name withFromPic:@"" withSpendCoins:0 withMsg:msg withPic:@"" withLocation:@"" withAudioUrl:@"" withSeconds:0 withTimestamp:shutUp.timestamp withAudioReadStatus:0 withSendStatus:MSG_STATUS_RECEIVE withBackgroundColor:0 coins:0];
//        [self.dataManager.commonDA addGroupMessage:dbMessage];
        
        NSString *pic = @"";
        for (TTShowXiaowoInfo *groupInfo in self.dataManager.myGroupList) {
            if (groupInfo._id == shutUp.nest_id) {
                pic = groupInfo.pic;
                break;
            }
        }
        
        [self addGroupConversation:groupID withFromID:shutUp.xy_user_id withMsgType:MSG_TYPE_GROUP_SYS_MSG withGroupName:groupName withFromName:shutUp.nick_name withMsg:msg withGroupPic:pic withAudioUrl:@"" withSeconds:0 withTimestamp:shutUp.timestamp];
        [kNotificationCenter postNotificationName:kNotificationSocketGroupShutup object:dbMessage];
    }
    else if ([actionName isEqualToString:@"nest.join"] || [actionName isEqualToString:@"nest.exit"])
    {
        NSDictionary *dict = [jsonData valueForKey:@"data_d"];

        GroupJoinExit *joinExit = [[GroupJoinExit alloc] initWithDictionary:dict error:nil];
        NSString *msg = joinExit.nick_name;
        NSInteger groupID = self.dataManager.currentChatGroupID;
        NSString *groupName = self.dataManager.currentChatGroupName;
        msg = [msg stringByAppendingString:[actionName isEqualToString:@"nest.join"] ? @"加入小窝" : @"退出小窝"];
        GroupMessage *dbMessage = [[GroupMessage alloc] initWithAttributes:groupID withUid:self.me._id withMsgType:MSG_TYPE_GROUP_SYS_MSG withGroupName:groupName withFromID:joinExit.user_id withFromName:joinExit.nick_name withFromPic:@"" withSpendCoins:0 withMsg:msg withPic:@"" withLocation:@"" withAudioUrl:@"" withSeconds:0 withTimestamp:joinExit.timestamp withAudioReadStatus:0 withSendStatus:MSG_STATUS_RECEIVE withBackgroundColor:0 coins:0];
//        [self.dataManager.commonDA addGroupMessage:dbMessage];
        
        NSString *pic = @"";
        for (TTShowXiaowoInfo *groupInfo in self.dataManager.myGroupList) {
            if (groupInfo._id == groupID) {
                pic = groupInfo.pic;
                break;
            }
        }
        
        [self addGroupConversation:groupID withFromID:joinExit.user_id withMsgType:MSG_TYPE_GROUP_SYS_MSG withGroupName:groupName withFromName:joinExit.nick_name withMsg:msg withGroupPic:pic withAudioUrl:@"" withSeconds:0 withTimestamp:joinExit.timestamp];
        [kNotificationCenter postNotificationName:kNotificationSocketGroupJoinExit object:dbMessage];
    }else if ([actionName isEqualToString:@"wo.chat"])
    {
        NSDictionary *data = [jsonData valueForKey:@"data"];
        
        GroupRecvMessage *message = [[GroupRecvMessage alloc] initWithDictionary:data error:nil];
        if (message.from._id == self.me._id) {
            return;
        }
        GroupMessage *groupDBMessage = [[GroupMessage alloc] initWithAttributes:message.wo_id withUid:self.me._id withMsgType:message.msg_type withGroupName:message.wo_name withFromID:message.from._id withFromName:message.from.nick_name withFromPic:message.from.pic withSpendCoins:message.from.coin_spend withMsg:message.message.msg withPic:message.message.pic withLocation:message.message.location withAudioUrl:message.message.audio_url withSeconds:message.message.seconds withTimestamp:message.timestamp withAudioReadStatus:AUDIO_READ_STATUS_UNREAD withSendStatus:MSG_STATUS_RECEIVE withBackgroundColor:[UIColor randomRGBValue] coins:0];
        
//        [self.dataManager.commonDA addGroupMessage:groupDBMessage];
        
//        NSInteger userID = self.dataManager.me._id;
//        NSInteger unReadMsgCount = 0;
//        
//        if (message.wo_id != self.dataManager.currentChatGroupID) {
//            BOOL isGroupMessageNotifyOn = YES;
//            id on = [self.dataManager.groupSwitch objectForKey:[NSString stringWithFormat:@"%d", (int)message.wo_id]];
//            if (on) {
//                isGroupMessageNotifyOn = [on boolValue];
//            }
//            unReadMsgCount = [self.dataManager.commonDA getConversationUnReadCount:userID withConversationID:message.wo_id] + (isGroupMessageNotifyOn ? 1 : 0);
//        }
//        
//        NSString *pic = @"";
//        for (TTShowXiaowoInfo *groupInfo in self.dataManager.myGroupList) {
//            if (groupInfo._id == message.wo_id) {
//                pic = groupInfo.pic;
//                break;
//            }
//        }
//        [self.dataManager.commonDA addConversation:[[Conversation alloc] initWithAttributes:message.wo_id userID:userID friendID:message.from._id msgType:message.msg_type groupName:message.wo_name fromName:message.from.nick_name msg:message.message.msg pic:pic audioUrl:message.message.audio_url duration:message.message.seconds timestamp:message.timestamp unReadCount:unReadMsgCount]];
        
        [kNotificationCenter postNotificationName:kNotificationSocketGroupMessage object:groupDBMessage];
    }else if ([actionName isEqualToString:@"mic.on"])
    {
        NSDictionary *data = [jsonData valueForKey:@"data_d"];
        
        
        
        NSInteger usrId = [[[data valueForKey:@"user"] valueForKey:@"_id"] integerValue];
        NSString *name = [[[data valueForKey:@"user"] valueForKey:@"nick_name"] stringByUnescapingFromHTML];
        NSInteger mic = [[data valueForKey:@"mic"] integerValue];
        NSString *pic = [[data valueForKey:@"user"] valueForKey:@"pic"];
        
        NSInteger groupID = self.dataManager.currentChatGroupID;
        GroupMessage *dbMessage = [[GroupMessage alloc] initWithAttributes:groupID withUid:usrId withMsgType:MSG_TYPE_GROUP_MSG withGroupName:@"" withFromID:usrId withFromName:name withFromPic:pic withSpendCoins:0 withMsg:[NSString stringWithFormat:@"%@上麦",name] withPic:pic withLocation:@"" withAudioUrl:@"" withSeconds:0 withTimestamp:0 withAudioReadStatus:mic withSendStatus:MSG_STATUS_RECEIVE withBackgroundColor:0 coins:1];
        [kNotificationCenter postNotificationName:kNotificationSocketGroupMessage object:dbMessage];
    }else if ([actionName isEqualToString:@"wo.in"])
    {
        NSDictionary *data = [jsonData valueForKey:@"data"];
        
        NSInteger usrId = [[[data valueForKey:@"user"] valueForKey:@"_id"] integerValue];
        NSString *name = [[data valueForKey:@"nick_name"] stringByUnescapingFromHTML];
        
        NSInteger groupID = self.dataManager.currentChatGroupID;
        
        GroupMessage *dbMessage = [[GroupMessage alloc] initWithAttributes:groupID withUid:self.me._id withMsgType:MSG_TYPE_GROUP_MSG withGroupName:@"" withFromID:usrId withFromName:name withFromPic:@"" withSpendCoins:0 withMsg:[NSString stringWithFormat:@"%@进入小窝",name] withPic:@"" withLocation:@"" withAudioUrl:@"" withSeconds:0 withTimestamp:0 withAudioReadStatus:0 withSendStatus:MSG_STATUS_RECEIVE withBackgroundColor:0 coins:0];
        [kNotificationCenter postNotificationName:kNotificationSocketGroupMessage object:dbMessage];
    }else if ([actionName isEqualToString:@"mic.off"])
    {
        NSDictionary *data = [jsonData valueForKey:@"data_d"];
        
        NSInteger mic = [[data valueForKey:@"mic"] integerValue];
        
        NSInteger usrId = [[[data valueForKey:@"user"] valueForKey:@"_id"] integerValue];
        NSString *name = [[[data valueForKey:@"user"] valueForKey:@"nick_name"] stringByUnescapingFromHTML];
        
        NSInteger groupID = self.dataManager.currentChatGroupID;
        GroupMessage *dbMessage = [[GroupMessage alloc] initWithAttributes:groupID withUid:usrId withMsgType:MSG_TYPE_GROUP_MSG withGroupName:@"" withFromID:usrId withFromName:name withFromPic:@"" withSpendCoins:0 withMsg:[NSString stringWithFormat:@"%@下麦",name] withPic:@"" withLocation:@"" withAudioUrl:@"" withSeconds:0 withTimestamp:0 withAudioReadStatus:mic withSendStatus:MSG_STATUS_RECEIVE withBackgroundColor:0 coins:2];
        [kNotificationCenter postNotificationName:kNotificationSocketGroupMessage object:dbMessage];
    }else if ([actionName isEqualToString:@"mic.kick"])
    {
        NSDictionary *data = [jsonData valueForKey:@"data_d"];
        
        NSInteger mic = [[data valueForKey:@"mic"] integerValue];
        
        NSInteger usrId = [[[data valueForKey:@"user"] valueForKey:@"_id"] integerValue];
        NSString *name = [[[data valueForKey:@"user"] valueForKey:@"nick_name"] stringByUnescapingFromHTML];
        
        NSInteger groupID = self.dataManager.currentChatGroupID;
        GroupMessage *dbMessage = [[GroupMessage alloc] initWithAttributes:groupID withUid:usrId withMsgType:MSG_TYPE_GROUP_MSG withGroupName:@"" withFromID:usrId withFromName:name withFromPic:@"" withSpendCoins:0 withMsg:[NSString stringWithFormat:@"%@被踢下麦",name] withPic:@"" withLocation:@"" withAudioUrl:@"" withSeconds:0 withTimestamp:0 withAudioReadStatus:mic withSendStatus:MSG_STATUS_RECEIVE withBackgroundColor:0 coins:3];
        [kNotificationCenter postNotificationName:kNotificationSocketGroupMessage object:dbMessage];
    }else if ([actionName isEqualToString:@"redpacket.notify"])
    {
        NSDictionary *data = [jsonData valueForKey:@"data_d"];
        
        NSInteger groupID = self.dataManager.currentChatGroupID;
        NSInteger usrId = [[[data valueForKey:@"from"] valueForKey:@"_id"] integerValue];
        NSString *name = [[data valueForKey:@"from"] valueForKey:@"nick_name"];
        NSString *pic = [[data valueForKey:@"from"] valueForKey:@"pic"];
        NSInteger coins = [[[data valueForKey:@"from"] valueForKey:@"coins"] integerValue];
        NSInteger coin_spend_total = [[[[data valueForKey:@"from"] valueForKey:@"finance"] valueForKey:@"coin_spend_total"] integerValue];
        
        NSString *redpacket_id = [data valueForKey:@"redpacket_id"];
        
        
        long long int timestamp = [[data valueForKey:@"timestamp"] longLongValue];
        
        
        GroupMessage *dbMessage = [[GroupMessage alloc] initWithAttributes:groupID withUid:usrId withMsgType:MSG_TYPE_GROUP_HONGBAO withGroupName:@"" withFromID:usrId withFromName:name withFromPic:pic withSpendCoins:coin_spend_total withMsg:redpacket_id withPic:pic withLocation:0 withAudioUrl:@"" withSeconds:0 withTimestamp:timestamp withAudioReadStatus:0 withSendStatus:0 withBackgroundColor:[UIColor randomRGBValue] coins:coins];
        [kNotificationCenter postNotificationName:kNotificationSocketGroupMessage object:dbMessage];
    }else if ([actionName isEqualToString:@"wo.out"])
    {
        NSDictionary *data = [jsonData valueForKey:@"data"];
        
        NSInteger usrId = [[[data valueForKey:@"user"] valueForKey:@"_id"] integerValue];
        NSString *name = [[data valueForKey:@"nick_name"] stringByUnescapingFromHTML];
        
        NSInteger groupID = self.dataManager.currentChatGroupID;
        
        GroupMessage *dbMessage = [[GroupMessage alloc] initWithAttributes:groupID withUid:self.me._id withMsgType:MSG_TYPE_GROUP_MSG withGroupName:@"" withFromID:usrId withFromName:name withFromPic:@"" withSpendCoins:0 withMsg:[NSString stringWithFormat:@"%@进入房间",name] withPic:@"" withLocation:@"" withAudioUrl:@"" withSeconds:0 withTimestamp:0 withAudioReadStatus:0 withSendStatus:MSG_STATUS_RECEIVE withBackgroundColor:0 coins:5];
        [kNotificationCenter postNotificationName:kNotificationSocketGroupMessage object:dbMessage];
    }else if ([actionName isEqualToString:@"redpacket.draw"])
    {
        NSDictionary *data = [jsonData valueForKey:@"data_d"];
        
        NSInteger uid = [[[data valueForKey:@"user"] valueForKey:@"_id"] integerValue];
        
        
        
        NSInteger fromID = [[[data valueForKey:@"from"] valueForKey:@"_id"] integerValue];
        
        NSString *name = [[[data valueForKey:@"user"] valueForKey:@"nick_name"] stringByUnescapingFromHTML];
        
        NSString *uName = [[[data valueForKey:@"from"] valueForKey:@"nick_name"] stringByUnescapingFromHTML];
        
        NSInteger groupID = self.dataManager.currentChatGroupID;
        
        if (uid==self.me._id) {
            name = @"我";
        }
        
        if (fromID==self.me._id) {
            uName = @"我";
            if (uid==self.me._id) {
                uName = @"自己";
            }
        }
        
        GroupMessage *dbMessage = [[GroupMessage alloc] initWithAttributes:groupID withUid:uid withMsgType:MSG_TYPE_GROUP_QIANGHONGBAO withGroupName:@"" withFromID:fromID withFromName:name withFromPic:@"" withSpendCoins:0 withMsg:[NSString stringWithFormat:@"%@领取了%@发的",name,uName] withPic:@"" withLocation:@"" withAudioUrl:@"" withSeconds:0 withTimestamp:0 withAudioReadStatus:0 withSendStatus:MSG_STATUS_RECEIVE withBackgroundColor:0 coins:4];
        [kNotificationCenter postNotificationName:kNotificationSocketGroupMessage object:dbMessage];
    }else if ([actionName isEqualToString:@"nest.kick"])
    {
        NSDictionary *data = [jsonData valueForKey:@"data_d"];
        
        NSInteger uid = [[data valueForKey:@"user_id"] integerValue];
        
        
        
        NSInteger fromID = [[data valueForKey:@"f_id"] integerValue];
        
        NSString *name = [[data valueForKey:@"nick_name"] stringByUnescapingFromHTML];
        
        NSString *fName = [[data valueForKey:@"f_name"] stringByUnescapingFromHTML];
        
        NSInteger groupID = self.dataManager.currentChatGroupID;
        

        
        GroupMessage *dbMessage = [[GroupMessage alloc] initWithAttributes:groupID withUid:uid withMsgType:MSG_TYPE_GROUP_TIREN withGroupName:@"" withFromID:fromID withFromName:fName withFromPic:@"" withSpendCoins:0 withMsg:[NSString stringWithFormat:@"%@被%@踢出小窝",name,fName] withPic:@"" withLocation:@"" withAudioUrl:@"" withSeconds:0 withTimestamp:0 withAudioReadStatus:0 withSendStatus:MSG_STATUS_RECEIVE withBackgroundColor:0 coins:4];
        [kNotificationCenter postNotificationName:kNotificationSocketGroupMessage object:dbMessage];
    }else if ([actionName isEqualToString:@"gift.notify"])
    {
        NSDictionary *data = [jsonData valueForKey:@"data_d"];
        
        NSInteger usrId = [[[data valueForKey:@"from"] valueForKey:@"_id"] integerValue];
        NSString *name = [[[data valueForKey:@"from"] valueForKey:@"nick_name"] stringByUnescapingFromHTML];
        
        NSInteger toId = [[[data valueForKey:@"to"] valueForKey:@"_id"] integerValue];
        NSString *toName = [[[data valueForKey:@"to"] valueForKey:@"nick_name"] stringByUnescapingFromHTML];
        
        NSString *giftName = [[data valueForKey:@"gift"] valueForKey:@"name"];
        
        NSInteger count = [[[data valueForKey:@"gift"] valueForKey:@"count"] integerValue];
        
        NSInteger groupID = self.dataManager.currentChatGroupID;
        
        GroupMessage *dbMessage = [[GroupMessage alloc] initWithAttributes:groupID withUid:usrId withMsgType:MSG_TYPE_GROUP_GIFT withGroupName:@"" withFromID:toId withFromName:name withFromPic:@"" withSpendCoins:0 withMsg:[NSString stringWithFormat:@"%@送给%@  %ld个%@",name,toName,(long)count,giftName] withPic:@"" withLocation:@"" withAudioUrl:@"" withSeconds:0 withTimestamp:0 withAudioReadStatus:0 withSendStatus:MSG_STATUS_RECEIVE withBackgroundColor:0 coins:10];
        [kNotificationCenter postNotificationName:kNotificationSocketGroupMessage object:dbMessage];
    }
}

- (void)addGroupConversation:(NSInteger)groupID withFromID:(NSInteger)fromID withMsgType:(NSInteger)msgType withGroupName:(NSString *)groupName withFromName:(NSString *)fromName withMsg:(NSString *)msg withGroupPic:(NSString *)pic withAudioUrl:(NSString *)audioUrl withSeconds:(NSInteger)seconds withTimestamp:(long long int)timestamp
{
    NSInteger userID = self.dataManager.me._id;
    NSInteger unReadMsgCount = 0;
    if (groupID != self.dataManager.currentChatGroupID) {
        BOOL isGroupMessageNotifyOn = YES;
        id on = [self.dataManager.groupSwitch objectForKey:[NSString stringWithFormat:@"%d", (int)groupID]];
        if (on) {
            isGroupMessageNotifyOn = [on boolValue];
        }
        unReadMsgCount = [self.dataManager.commonDA getConversationUnReadCount:userID withConversationID:groupID] + (isGroupMessageNotifyOn ? 1 : 0);
    }
    [self.dataManager.commonDA addConversation:[[Conversation alloc] initWithAttributes:groupID userID:userID friendID:fromID msgType:msgType groupName:groupName fromName:fromName msg:msg pic:pic audioUrl:audioUrl duration:seconds timestamp:timestamp unReadCount:unReadMsgCount]];
}

@end