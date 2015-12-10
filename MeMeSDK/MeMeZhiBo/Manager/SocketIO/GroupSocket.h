//
//  GroupSocket.h
//  TTShow
//
//  Created by xh on 15/3/19.
//  Copyright (c) 2015年 twb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SocketIO.h"

@interface GroupSocket : NSObject <SocketIODelegate>

@property (nonatomic, strong)SocketIO* socketIO;

+ (instancetype)getInstance;

- (void)sendMessage:(NSString *)msg;

- (void)connect:(NSInteger)groupID;
- (void)disconnect;
@end
