//
//  FriendMessage.h
//  TTShow
//
//  Created by xh on 15/3/12.
//  Copyright (c) 2015年 twb. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JSONModel.h"

@interface FriendMessage : JSONModel
@property (assign, nonatomic) NSInteger messageID;
@property (assign, nonatomic) NSInteger uid;
@property (assign, nonatomic) NSInteger fid;
@property (strong, nonatomic) NSString* msg;
@property (assign, nonatomic) NSInteger sendStatus;
@property (assign, nonatomic) long long int timestamp;


- (id)initWithAttributes:(NSInteger)uid withFriendID:(NSInteger)fid withMessage:(NSString *)msg withSendStatus:(NSInteger)sendStatus withTimestamp:(long long int)timestamp;
@end
