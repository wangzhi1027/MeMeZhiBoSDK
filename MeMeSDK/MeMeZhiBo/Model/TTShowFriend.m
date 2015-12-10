//
//  TTShowFriend.m
//  TTShow
//
//  Created by wangyifeng on 15-1-27.
//  Copyright (c) 2015年 twb. All rights reserved.
//

#import "TTShowFriend.h"

@implementation TTShowFriend

- (id)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if (!self) {
        return nil;
    }
    self.priv = [attributes[@"priv"] integerValue];
    self._id = [attributes[@"_id"] integerValue];
    self.nick = attributes[@"nick_name"];
    self.pic = attributes[@"pic"];
    self.pinyin_nick = attributes[@"pinyin_name"];
    self.finance = [attributes valueForKey:@"finance"];
    return self;
}

@end

@implementation TTShowFriendRequest

- (id)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self._id = attributes[@"_id"];
    self.uid = [attributes[@"uid"] integerValue];
    self.fid = [attributes[@"fid"] integerValue];
    self.nick_name = attributes[@"nick_name"];
    self.content = attributes[@"content"];
    self.pic = attributes[@"pic"];
    self.timestamp = [attributes[@"timestamp"] longLongValue];
    self.status = [attributes[@"status"] integerValue];
    self.finance = [attributes valueForKey:@"finance"];
    return self;
}

@end
