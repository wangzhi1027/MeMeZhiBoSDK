//
//  IM.h
//  TTShow
//
//  Created by xh on 15/3/13.
//  Copyright (c) 2015年 twb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChatUser.h"

#pragma mark friend send msg

@interface FriendSendMessage : JSONModel
@property (nonatomic, strong) NSString *action;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) ChatUser *to;

@end

#pragma mark friend receive msg
@interface FriendRecvMessage : JSONModel
@property (nonatomic, strong) SocketUser *from;
@property (nonatomic, strong) SocketUser *to;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, assign) long long int timestamp;

@end

#pragma mark friend apply msg
@interface FriendApplyMessage : JSONModel

@property (nonatomic, assign) NSInteger _id;
@property (nonatomic, strong) NSString *nick_name;
@property (nonatomic, strong) NSString *pic_url;
@property (nonatomic, assign) long long int timestamp;

@end

#pragma mark friend del msg
@interface FriendDelMessage : JSONModel

@property (nonatomic, assign) NSInteger _id;
@property (nonatomic, assign) long long int timestamp;

@end

#pragma mark friend agree msg
@interface FriendAgreeMessage : JSONModel

@property (nonatomic, assign) NSInteger _id;
@property (nonatomic, strong) NSString *nick_name;
@property (nonatomic, strong) NSString *pic_url;
@property (nonatomic, assign) long long int timestamp;

@end


