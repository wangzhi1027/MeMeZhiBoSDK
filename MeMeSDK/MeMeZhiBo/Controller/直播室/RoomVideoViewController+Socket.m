//
//  RoomVideoViewController+Socket.m
//  memezhibo
//
//  Created by Xingai on 15/6/9.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "RoomVideoViewController+Socket.h"
#import "RoomVideoViewController+Chat.h"

#define kRoomChatRoomIDKey       @"room_id"
#define kRoomChatAccessTokenKey  @"access_token"


@implementation RoomVideoViewController (Socket)

// Socket.IO
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
    [dict setValue:[NSNumber numberWithUnsignedInteger:self.currentRoom._id] forKey:kRoomChatRoomIDKey];
    // Just for testing , null for a few days.
    self.access_token = self.me.access_token;
    
    [dict setValue:self.access_token forKey:kRoomChatAccessTokenKey];
    [self.socketIO connectToHost:self.dataManager.filter.baseSocketUrlStr onPort:self.dataManager.filter.baseSocketPort withParams:dict];
    //   [self.socketIO connectToHost:@"127.0.0.1" onPort:1337 withParams:dict];
}

// Close Socket.IO
- (void)closeSockIO
{
    if (!self.closeSocketIOWhenDisappear)
    {
        return;
    }
    
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
    
}

- (void) socketIODidDisconnect:(SocketIO *)socket disconnectedWithError:(NSError *)error
{
    
}

- (void) socketIO:(SocketIO *)socket didReceiveMessage:(SocketIOPacket *)packet
{
    [self handleReceivedMessage:packet.data];
}

- (void) socketIO:(SocketIO *)socket didReceiveJSON:(SocketIOPacket *)packet
{
    
}

- (void) socketIO:(SocketIO *)socket didReceiveEvent:(SocketIOPacket *)packet
{
    
}

- (void) socketIO:(SocketIO *)socket didSendMessage:(SocketIOPacket *)packet
{
    
}

- (void) socketIO:(SocketIO *)socket onError:(NSError *)error
{
    [self setupSocketIO];
}


@end
