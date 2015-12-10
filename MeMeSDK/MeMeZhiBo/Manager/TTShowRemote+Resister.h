//
//  TTShowRemote+Resister.h
//  memezhibo
//
//  Created by Xingai on 15/6/19.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "TTShowRemote.h"

@interface TTShowRemote (Resister)

-(void)sendPhoneNumber:(NSString *)number completion:(RemoteCompletionBool)completion;
-(void)sendPhoneauthcode:(NSString*)number completion:(RemoteCompletionBool)completion;
-(void)sendPhoneauthcodeLogin:(NSString*)number pasword:(NSString*)pas code:(NSString*)code completion:(RemoteCompletionUser)completion;

@end
