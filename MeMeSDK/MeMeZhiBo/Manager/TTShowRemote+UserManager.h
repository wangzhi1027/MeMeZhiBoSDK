//
//  TTShowRemote+UserManager.h
//  TTShow
//
//  Created by twb on 13-10-10.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import "TTShowRemote.h"

@interface TTShowRemote (UserManager)

- (void)_userLogin:(NSString *)userName password:(NSString *)password key:(NSString*)key completion:(RemoteCompletionUser)completion;
- (void)_userRegister:(NSString *)nickName userName:(NSString *)userName password:(NSString *)password authkey:(NSString *)authkey completion:(RemoteCompletionUser)completion;

- (void)_loginFromThirdParty:(NSString *)urlString completion:(RemoteCompletionUser)completion;
- (void)_loginFrom3rdPartySDK:(NSDictionary *)param completion:(RemoteCompletionUser)completion;

- (void)updateUserInfo:(NSString *)access_token completion:(RemoteCompletionUser)completion;
- (void)_updateUserInformationWithCompletion:(RemoteCompletionUser)completion;

//- (void)requestBagGifts:(SuccessBlock)successBlock failBlock:(FailBlock)failBlock;
- (void)_loginWhenAppStart;

//- (void)_userLogin:(NSString *)userName password:(NSString *)password completion:(RemoteCompletionUser)completion;


@end
