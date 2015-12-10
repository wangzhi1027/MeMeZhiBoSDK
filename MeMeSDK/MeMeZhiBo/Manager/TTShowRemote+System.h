//
//  TTShowRemote+System.h
//  memezhibo
//
//  Created by Xingai on 15/5/14.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "TTShowRemote.h"

@interface TTShowRemote (System)

// Collect iOS Client Logs.
- (void)_collectLog;

- (void)_dayLoginWith:(NSString *)deviceUID;

- (void)_registerDeviceToken:(NSString *)deviceToken;

- (void)_requestSensitiveNickNames:(SuccessBlock)successBlock failBlock:(FailBlock)failBlock;

- (void)_requestSensitiveWords:(SuccessBlock)successBlock failBlock:(FailBlock)failBlock;

- (NSDictionary *)parseJson:(id)responseObject;

- (void)_sendSuggestion:(NSString *)contact content:(NSString *)content completion:(RemoteCompletionBool)completion;

@end
