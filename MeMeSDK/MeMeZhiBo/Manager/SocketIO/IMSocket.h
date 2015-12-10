//
//  TTShowSocket.h
//  TTShow
//
//  Created by wangyifeng on 15-2-10.
//  Copyright (c) 2015年 twb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SocketIO.h"
#import "SocketIOPacket.h"
#import "IM.h"

@interface IMSocket : NSObject <SocketIODelegate>
@property (nonatomic, strong) SocketIO *socketIO;
@property (nonatomic, strong) CommonDataAccess *commonDA;


+ (instancetype)getInstance;

- (void) sendMessage:(NSString *)msg;
//- (BOOL) saveToDatabase:(NSString *)tname fields: (NSDictionary *) paras;


- (void)setupSocketIO;
- (void)closeSockIO;
@end
