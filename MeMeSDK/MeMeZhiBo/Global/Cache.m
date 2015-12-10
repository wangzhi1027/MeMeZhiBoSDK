//
//  Cache.m
//  TTShow
//
//  Created by xh on 15/4/9.
//  Copyright (c) 2015年 twb. All rights reserved.
//

#import "Cache.h"

@implementation Cache

#pragma mark - base operator
+ (id)getCache:(NSString *)key
{
    return[[TMCache sharedCache] objectForKey:key];
}

+ (void)getCache:(NSString *)key block:(TMCacheObjectBlock)block
{
    [[TMCache sharedCache] objectForKey:key block:block];
}

+ (void)setCache:(id)object key:(NSString *)key
{
    [[TMCache sharedCache] setObject:object forKey:key block:nil];
}

+ (void)remove:(NSString *)key
{
    [[TMCache sharedCache] removeObjectForKey:key block:nil];
}

#pragma mark - caches

+ (NSArray *)getSensitiveNickNames
{
    return [self getCache:CACHE_SENSITIVE_NICK_NAMES];
}

+ (void)getSensitiveNickNamesAsync:(TMCacheObjectBlock)block
{
    [self getCache:CACHE_SENSITIVE_NICK_NAMES block:block];
}

+ (void)addSensitiveNickNames:(NSArray *)nickNames
{
    [self setCache:nickNames key:CACHE_SENSITIVE_NICK_NAMES];
}

+ (NSArray *)getSensitiveWords
{
    return [self getCache:CACHE_SENSITIVE_WORDS];
}

+ (void)getSensitiveWordsAsync:(TMCacheObjectBlock)block
{
    [self getCache:CACHE_SENSITIVE_WORDS block:block];
}

+ (void)addSensitiveWords:(NSArray *)words
{
    [self setCache:words key:CACHE_SENSITIVE_WORDS];
}

+ (NSArray *)getFriendList
{
    return [self getCache:CACHE_FRIEND_LIST];
}

+ (void)getFriendListAsync:(TMCacheObjectBlock)block
{
    [self getCache:CACHE_FRIEND_LIST block:block];
}

+ (void)addFriendList:(NSArray *)friends
{
    [self setCache:friends key:CACHE_FRIEND_LIST];
}

+ (NSInteger)getUnReadSysMsgCount
{
    return [[[TMCache sharedCache] objectForKey:CACHE_UNREAD_SYS_MSG_COUNT] intValue];
}

+ (void)getUnReadSysMsgCountAsync:(TMCacheObjectBlock)block
{
    [[TMCache sharedCache] objectForKey:CACHE_UNREAD_SYS_MSG_COUNT block:block];
}

+ (void)addUnReadSysMsgCount:(NSInteger)count
{
    [[TMCache sharedCache] setObject:[NSNumber numberWithInteger:count] forKey:CACHE_UNREAD_SYS_MSG_COUNT block:nil];
}

+ (NSInteger)getUnReadRemindCount
{
    return [[[TMCache sharedCache] objectForKey:CACHE_UNREAD_FAMILY_MSG_COUNT] intValue];
}

+ (void)getUnReadRemindCountAsync:(TMCacheObjectBlock)block
{
    [[TMCache sharedCache] objectForKey:CACHE_UNREAD_FAMILY_MSG_COUNT block:block];
}

+ (void)addUnReadRemindCount:(NSInteger)count
{
    [[TMCache sharedCache] setObject:[NSNumber numberWithInteger:count] forKey:CACHE_UNREAD_FAMILY_MSG_COUNT block:nil];
}

+ (NSArray *)getMyGroupList
{
    return [self getCache:CACHE_MY_GROUP_LIST];
}

+ (void)getMyGroupListAsync:(TMCacheObjectBlock)block
{
    [self getCache:CACHE_MY_GROUP_LIST block:block];
}

+ (void)addMyGroupList:(NSArray *)groups
{
    [self setCache:groups key:CACHE_MY_GROUP_LIST];
}

@end
