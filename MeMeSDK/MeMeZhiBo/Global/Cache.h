//
//  Cache.h
//  TTShow
//
//  Created by xh on 15/4/9.
//  Copyright (c) 2015年 twb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TMCache.h"

//cache
#define CACHE_UNREAD_SYS_MSG_COUNT @"CACHE_UNREAD_SYS_MSG_COUNT"
#define CACHE_UNREAD_FAMILY_MSG_COUNT @"CACHE_UNREAD_FAMILY_MSG_COUNT"
#define CACHE_NEW_FRIEND_APPLY_IDS @"CACHE_NEW_FRIEND_APPLY_IDS"

#define CACHE_USER_INFO @"CACHE_USER_INFO"
#define CACHE_FRIEND_LIST @"CACHE_FRIEND_LIST"
#define CACHE_LAST_IM_SOCKET_DISCONNECT_TIME @"CACHE_LAST_IM_SOCKET_DISCONNECT_TIME"
#define CACHE_MY_GROUP_ID_LIST @"CACHE_MY_GROUP_ID_LIST"
#define CACHE_MY_GROUP_LIST @"CACHE_MY_GROUP_LIST"
#define CACHE_BAG @"CACHE_BAG"
#define CACHE_SENSITIVE_NICK_NAMES @"CACHE_SENSITIVE_NICK_NAMES"
#define CACHE_SENSITIVE_WORDS @"CACHE_SENSITIVE_WORDS"

@interface Cache : NSObject

//+ (void)remove:(NSString *)key;
//
//+ (NSArray *)getSensitiveNickNames;
//+ (void)getSensitiveNickNamesAsync:(TMCacheObjectBlock)block;
//+ (void)addSensitiveNickNames:(NSArray *)nickNames;
//
//+ (NSArray *)getSensitiveWords;
//+ (void)getSensitiveWordsAsync:(TMCacheObjectBlock)block;
//+ (void)addSensitiveWords:(NSArray *)words;
//
//+ (NSArray *)getFriendList;
//+ (void)getFriendListAsync:(TMCacheObjectBlock)block;
//+ (void)addFriendList:(NSArray *)friends;
//
//+ (NSInteger)getUnReadSysMsgCount;
//+ (void)getUnReadSysMsgCountAsync:(TMCacheObjectBlock)block;
//+ (void)addUnReadSysMsgCount:(NSInteger)count;
//
//+ (NSInteger)getUnReadRemindCount;
//+ (void)getUnReadRemindCountAsync:(TMCacheObjectBlock)block;
//+ (void)addUnReadRemindCount:(NSInteger)count;
//
//+ (NSArray *)getMyGroupList;
//+ (void)getMyGroupListAsync:(TMCacheObjectBlock)block;
//+ (void)addMyGroupList:(NSArray *)groups;

@end
