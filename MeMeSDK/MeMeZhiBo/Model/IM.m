//
//  IM.m
//  TTShow
//
//  Created by xh on 15/3/13.
//  Copyright (c) 2015年 twb. All rights reserved.
//

#import "IM.h"


@implementation FriendSendMessage

+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"data.to" : @"to",
                                                       @"data.message" : @"message"}];
}
@end

@implementation FriendAgreeMessage

@end

@implementation FriendApplyMessage

@end

@implementation FriendDelMessage

@end

@implementation FriendRecvMessage

@end
