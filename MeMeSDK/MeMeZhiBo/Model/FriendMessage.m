//
//  FriendMessage.m
//  TTShow
//
//  Created by xh on 15/3/12.
//  Copyright (c) 2015年 twb. All rights reserved.
//

#import "FriendMessage.h"

@implementation FriendMessage


- (id)initWithAttributes:(NSInteger)uid withFriendID:(NSInteger)fid withMessage:(NSString *)msg withSendStatus:(NSInteger)sendStatus withTimestamp:(long long int)timestamp
{
    self = [super init];
    if (!self) {
        return nil;
    }
    self.uid = uid;
    self.fid = fid;
    self.msg = msg;
    self.sendStatus = sendStatus;
    self.timestamp = timestamp;
    return self;
}


+(JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"id": @"messageID",
                                                       @"send_status" : @"sendStatus"}];
}
@end
