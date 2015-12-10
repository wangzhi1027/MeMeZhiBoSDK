//
//  TTShowRemote+Friend.h
//  TTShow
//
//  Created by wangyifeng on 15-1-27.
//  Copyright (c) 2015年 twb. All rights reserved.
//

#import "TTShowRemote.h"

@interface TTShowRemote (Friend)
- (void)isMyFriend:(NSInteger)friendID completion:(RemoteCompletionBool)completion;
- (void)retrieveFriendList:(RemoteCompletionArray)completion;
- (void)_retrieveBlackListWithParams:(NSDictionary *)params completion:(RemoteCompletionArray)completion;
- (void)_retrieveFriendRequestListWithParams:(NSDictionary *)params completion:(RemoteCompletionArray)completion;
- (void)_retrieveFriendSearchListWithParams:(NSDictionary *)params authID:(NSString *)authCode completion:(RemoteCompletionArray)completion;

- (void)_delFriend:(NSInteger)friendID completion:(RemoteCompletionBool)completion;
- (void)_delFriendFromBlack:(NSInteger)friendID completion:(RemoteCompletionBool)completion;
- (void)_requestAddFriend:(NSInteger)friendID completion:(RemoteCompletionBool)completion;
- (void)_agreeAddFriend:(NSInteger)friendID completion:(RemoteCompletionBool)completion;
- (void)_refuseAddFriend:(NSInteger)friendID completion:(RemoteCompletionBool)completion;
- (void)_deleteFriendApply:(NSInteger)friendID completion:(RemoteCompletionBool)completion;
- (void)_isMyFriend:(NSInteger)friendID completion:(RemoteCompletionBool)completion;
- (void)_addFriendToBlacklist:(NSInteger)friendID completion:(RemoteCompletionBool)completion;

@end
