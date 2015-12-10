//
//  TTShowRemote+UserInfo.h
//  memezhibo
//
//  Created by Xingai on 15/5/20.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "TTShowRemote.h"

@interface TTShowRemote (UserInfo)

- (void)_retrieveUserInfo:(NSInteger)userID completion:(RemoteCompletionUser)completion;

- (void)_retrieveStarPhotoNumber:(NSInteger)starID completion:(RemoteCompletionInteger)completion;

- (void)requestCostRecords:(SuccessBlock)successBlock failBlock:(FailBlock)failBlock;

- (void)retrieveUserRecordsWithParams:(NSDictionary *)params remoteType:(RemoteType)remoteType completion:(RemoteCompletionArray)completion;

- (void)_uploadUserInformation:(NSDictionary *)userInfo completion:(RemoteCompletionBool)completion;

- (void)_retrieveStarPhotoListByType:(StarPhotoType)type starID:(NSInteger)starID completion:(RemoteCompletionArrayInteger)completion;
- (void)_retrieveUserInfoNew:(NSInteger)userID completion:(RemoteCompletionUserNew)completion;

- (void)retrieveUserBadge:(NSInteger)userID completion:(RemoteCompletionArray)completion;

@end
