//
//  TTShowRemote+Friend.m
//  TTShow
//
//  Created by wangyifeng on 15-1-27.
//  Copyright (c) 2015年 twb. All rights reserved.
//

#import "TTShowRemote+Friend.h"
#import "MMAFAppDotNetAPIClient.h"
#import "MMAFHTTPRequestOperation.h"
#import "TTShowFriend.h"

@implementation TTShowRemote (Friend)

- (void)retrieveFriendList:(RemoteCompletionArray)completion
{
    // retrieve_msg_list_index
    NSString *access_token = [TTShowUser access_token];
    if ([TTShowUser access_token] == nil)
    {
        completion(nil, [NSError errorMsg:@"token 为空"]);
        return;
    }
    
    NSString *param = [NSString stringWithFormat:urlArray[friend_friend_list], access_token];
    NSString *fullURL = [self.baseURLStr stringByAppendingString:param];
    [[MMAFAppDotNetAPIClient sharedClient] getPath:fullURL parameters:nil
                                         success:^(MMAFHTTPRequestOperation *operation, id responseObject)
     {
         NSDictionary *jsonData = [self parseJson:responseObject];
         NSMutableArray *msgList = [[NSMutableArray alloc] init];
         if ([jsonData isRightKind])
         {
             if (![(NSDictionary *)jsonData statusCodeOK])
             {
                 return;
             }
             
             NSDictionary *followListDict = [jsonData valueForKey:kFollowListNodeName];
             NSArray *userList = [followListDict valueForKey:@"users"];
             
             for (NSDictionary *msgDict in userList)
             {
                 TTShowFriend *msg = [[TTShowFriend alloc] initWithAttributes:msgDict];
                 [msgList addObject:msg];
             }
             if (msgList.count > 0) {
//                 [Cache addFriendList:msgList];
                 self.dataManager.friendList = msgList;
             } else {
//                 [Cache remove:CACHE_FRIEND_LIST];
                 self.dataManager.friendList = nil;
             }
         }
         else
         {
         }
         
         if (completion)
         {
             completion(msgList, nil);
         }
         
     }failure:^(MMAFHTTPRequestOperation *operation, NSError *error)
     {
         if (completion)
         {
             completion(nil, error);
         }
     }];
}


- (void)_retrieveBlackListWithParams:(NSDictionary *)params completion:(RemoteCompletionArray)completion
{
    // retrieve_msg_list_index
    NSString *access_token = [TTShowUser access_token];
    if ([TTShowUser access_token] == nil)
    {
        completion(nil, [NSError errorMsg:@"token 为空"]);
        return;
    }
    
    NSString *param = [NSString stringWithFormat:urlArray[friend_black_list], access_token];
    NSString *fullURL = [self.baseURLStr stringByAppendingString:param];
    [[MMAFAppDotNetAPIClient sharedClient] getPath:fullURL parameters:nil
                                         success:^(MMAFHTTPRequestOperation *operation, id responseObject)
     {
         NSDictionary *jsonData = [self parseJson:responseObject];
         NSMutableArray *msgList = [[NSMutableArray alloc] init];
         if ([jsonData isRightKind])
         {
             if (![(NSDictionary *)jsonData statusCodeOK])
             {
                 completion(0, [NSError errorMsg:[DataGlobalKit messageWithStatus:[jsonData statusCode]]
                                            code:[jsonData statusCode]]);
                 return;
             }
             
             NSDictionary *followListDict = [jsonData valueForKey:kFollowListNodeName];
             NSArray *userList = [followListDict valueForKey:@"users"];
             
             for (NSDictionary *msgDict in userList)
             {
                 TTShowFriend *msg = [[TTShowFriend alloc] initWithAttributes:msgDict];
                 [msgList addObject:msg];
             }
         }
         else
         {
         }
         
         if (completion)
         {
             completion(msgList, nil);
         }
         
     }failure:^(MMAFHTTPRequestOperation *operation, NSError *error)
     {
         if (completion)
         {
             completion(nil, error);
         }
     }];
}


- (void)_retrieveFriendRequestListWithParams:(NSDictionary *)params completion:(RemoteCompletionArray)completion
{
    // retrieve_msg_list_index
    NSString *access_token = [TTShowUser access_token];
    if ([TTShowUser access_token] == nil)
    {
        completion(nil, [NSError errorMsg:@"token 为空"]);
        return;
    }
    
    NSString *param = [NSString stringWithFormat:urlArray[friend_request_list], access_token,1,10];
    NSString *fullURL = [self.baseURLStr stringByAppendingString:param];
    [[MMAFAppDotNetAPIClient sharedClient] getPath:fullURL parameters:nil
                                         success:^(MMAFHTTPRequestOperation *operation, id responseObject)
     {
         NSDictionary *jsonData = [self parseJson:responseObject];
         NSMutableArray *msgList = [[NSMutableArray alloc] init];
         if ([jsonData isRightKind])
         {
             if (![(NSDictionary *)jsonData statusCodeOK])
             {
                 completion(0, [NSError errorMsg:[DataGlobalKit messageWithStatus:[jsonData statusCode]]
                                            code:[jsonData statusCode]]);
                 return;
             }
             
             // msgList
             NSArray *msgs = jsonData[@"data"];
             for (NSDictionary *msgDict in msgs)
             {
                 TTShowFriendRequest *msg = [[TTShowFriendRequest alloc] initWithAttributes:msgDict];
                 [msgList addObject:msg];
             }
         }
         else
         {
         }
         
         if (completion)
         {
             completion(msgList, nil);
         }
         
     }failure:^(MMAFHTTPRequestOperation *operation, NSError *error)
     {
         if (completion)
         {
             completion(nil, error);
         }
     }];
}


- (void)_retrieveFriendSearchListWithParams:(NSDictionary *)params authID:(NSString *)authCode completion:(RemoteCompletionArray)completion
{
    // retrieve_msg_list_index
    NSString *access_token = [TTShowUser access_token];
    if ([TTShowUser access_token] == nil)
    {
        completion(nil, [NSError errorMsg:@"token 为空"]);
        return;
    }
    
    NSString *param = [NSString stringWithFormat:urlArray[friend_search], access_token,authCode];
    NSString *fullURL = [self.baseURLStr stringByAppendingString:param];
    [[MMAFAppDotNetAPIClient sharedClient] getPath:fullURL parameters:nil
                                         success:^(MMAFHTTPRequestOperation *operation, id responseObject)
     {
         NSDictionary *jsonData = [self parseJson:responseObject];
         NSMutableArray *msgList = [[NSMutableArray alloc] init];
         if ([jsonData isRightKind])
         {
             if (![(NSDictionary *)jsonData statusCodeOK])
             {
                 completion(0, [NSError errorMsg:[DataGlobalKit messageWithStatus:[jsonData statusCode]]
                                            code:[jsonData statusCode]]);
                 return;
             }
             
             NSDictionary *jsonUser = jsonData[@"data"];
             NSDictionary *User = jsonUser[@"user"];
             
             TTShowFriend *msg = [[TTShowFriend alloc] initWithAttributes:User];
             [msgList addObject:msg];         }
         else
         {
         }
         
         if (completion)
         {
             completion(msgList, nil);
         }
         
     }failure:^(MMAFHTTPRequestOperation *operation, NSError *error)
     {
         if (completion)
         {
             completion(nil, error);
         }
     }];
}

- (void)_delFriend:(NSInteger)friendID completion:(RemoteCompletionBool)completion
{
    NSString *access_token = [TTShowUser access_token];
    if ([TTShowUser access_token] == nil)
    {
        completion(NO, [NSError errorMsg:@"token 为空"]);
        return;
    }
    
    NSString *param = [NSString stringWithFormat:urlArray[friend_del_one], access_token, friendID];
    NSString *urlString = [self.baseURLStr stringByAppendingString:param];
    
    [[MMAFAppDotNetAPIClient sharedClient] getPath:urlString parameters:nil success:^(MMAFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *jsonData = [self parseJson:responseObject];
        
        if ([jsonData isRightKind])
        {
            if (![jsonData statusCodeOK])
            {
                completion(NO, [NSError errorMsg:[DataGlobalKit messageWithStatus:[jsonData statusCode]]
                                            code:[jsonData statusCode]]);
                return;
            }
            [self retrieveFriendList:nil];
            completion(YES, nil);
        }
        
    } failure:^(MMAFHTTPRequestOperation *operation, NSError *error) {
        completion(NO, error);
    }];
}

- (void)_delFriendFromBlack:(NSInteger)friendID completion:(RemoteCompletionBool)completion
{
    NSString *access_token = [TTShowUser access_token];
    if ([TTShowUser access_token] == nil)
    {
        completion(NO, [NSError errorMsg:@"token 为空"]);
        return;
    }
    
    NSString *param = [NSString stringWithFormat:urlArray[friend_del_blacklist], access_token, friendID];
    NSString *urlString = [self.baseURLStr stringByAppendingString:param];
    
    [[MMAFAppDotNetAPIClient sharedClient] getPath:urlString parameters:nil success:^(MMAFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *jsonData = [self parseJson:responseObject];
        
        if ([jsonData isRightKind])
        {
            if (![jsonData statusCodeOK])
            {
                completion(NO, [NSError errorMsg:[DataGlobalKit messageWithStatus:[jsonData statusCode]]
                                            code:[jsonData statusCode]]);
                return;
            }
            completion(YES, nil);
        }
        
    } failure:^(MMAFHTTPRequestOperation *operation, NSError *error) {
        completion(NO, error);
    }];
}


- (void)_requestAddFriend:(NSInteger)userID completion:(RemoteCompletionBool)completion
{
    NSString *access_token = [TTShowUser access_token];
    if ([TTShowUser access_token] == nil)
    {
        completion(NO, [NSError errorMsg:@"token 为空"]);
        return;
    }
    
    NSString *param = [NSString stringWithFormat:urlArray[friend_request_add], access_token, userID];
    NSString *urlString = [self.baseURLStr stringByAppendingString:param];
    NSLog(@"_requestAddFriend %@", urlString);
    [[MMAFAppDotNetAPIClient sharedClient] getPath:urlString parameters:nil success:^(MMAFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *jsonData = [self parseJson:responseObject];
        
        if ([jsonData isRightKind])
        {
            if (![jsonData statusCodeOK])
            {
                completion(NO, [NSError errorMsg:[DataGlobalKit messageWithStatus:[jsonData statusCode]]
                                            code:[jsonData statusCode]]);
                return;
            }
            completion(YES, nil);
        }
        
    } failure:^(MMAFHTTPRequestOperation *operation, NSError *error) {
        completion(NO, error);
    }];
}

- (void)_agreeAddFriend:(NSInteger)friendID completion:(RemoteCompletionBool)completion
{
    NSString *access_token = [TTShowUser access_token];
    if ([TTShowUser access_token] == nil)
    {
        completion(NO, [NSError errorMsg:@"token 为空"]);
        return;
    }
    
    NSString *param = [NSString stringWithFormat:urlArray[friend_add_agree], access_token, friendID];
    NSString *urlString = [self.baseURLStr stringByAppendingString:param];
    
    
    [[MMAFAppDotNetAPIClient sharedClient] getPath:urlString parameters:nil success:^(MMAFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *jsonData = [self parseJson:responseObject];
        
        if ([jsonData isRightKind])
        {
            if (![jsonData statusCodeOK])
            {
                completion(NO, [NSError errorMsg:[DataGlobalKit messageWithStatus:[jsonData statusCode]]
                                            code:[jsonData statusCode]]);
                return;
            }
            completion(YES, nil);
        }
        
    } failure:^(MMAFHTTPRequestOperation *operation, NSError *error) {
        completion(NO, error);
    }];
}
- (void)_refuseAddFriend:(NSInteger)carID completion:(RemoteCompletionBool)completion
{
    NSString *access_token = [TTShowUser access_token];
    if ([TTShowUser access_token] == nil)
    {
        completion(NO, [NSError errorMsg:@"token 为空"]);
        return;
    }
    
    NSString *param = [NSString stringWithFormat:urlArray[friend_add_refuse], access_token, carID];
    NSString *urlString = [self.baseURLStr stringByAppendingString:param];
    [[MMAFAppDotNetAPIClient sharedClient] getPath:urlString parameters:nil success:^(MMAFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *jsonData = [self parseJson:responseObject];
        
        if ([jsonData isRightKind])
        {
            if (![jsonData statusCodeOK])
            {
                completion(NO, [NSError errorMsg:[DataGlobalKit messageWithStatus:[jsonData statusCode]]
                                            code:[jsonData statusCode]]);
                return;
            }
            completion(YES, nil);
        }
        
    } failure:^(MMAFHTTPRequestOperation *operation, NSError *error) {
        completion(NO, error);
    }];
}

- (void)_deleteFriendApply:(NSInteger)rID completion:(RemoteCompletionBool)completion
{
    NSString *access_token = [TTShowUser access_token];
    if ([TTShowUser access_token] == nil)
    {
        completion(NO, [NSError errorMsg:@"token 为空"]);
        return;
    }
    
    NSString *param = [NSString stringWithFormat:urlArray[friend_del_apply], access_token];
    NSString *urlString = [self.baseURLStr stringByAppendingString:param];
    [[MMAFAppDotNetAPIClient sharedClient] getPath:urlString parameters:nil success:^(MMAFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *jsonData = [self parseJson:responseObject];
        
        if ([jsonData isRightKind])
        {
            if (![jsonData statusCodeOK])
            {
                completion(NO, [NSError errorMsg:[DataGlobalKit messageWithStatus:[jsonData statusCode]]
                                            code:[jsonData statusCode]]);
                return;
            }
            completion(YES, nil);
        }
        
    } failure:^(MMAFHTTPRequestOperation *operation, NSError *error) {
        completion(NO, error);
    }];
}

- (void)isMyFriend:(NSInteger)friendID completion:(RemoteCompletionBool)completion
{
    NSString *access_token = [TTShowUser access_token];
    if ([TTShowUser access_token] == nil)
    {
        completion(NO, [NSError errorMsg:@"token 为空"]);
        return;
    }
    
    NSString *param = [NSString stringWithFormat:urlArray[friend_is_friend], access_token, friendID];
    NSString *urlString = [self.baseURLStr stringByAppendingString:param];
    
    [[MMAFAppDotNetAPIClient sharedClient] getPath:urlString parameters:nil success:^(MMAFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *jsonData = [self parseJson:responseObject];
        
        if ([jsonData isRightKind])
        {
            if (![jsonData statusCodeOK])
            {
                completion(NO, [NSError errorMsg:[DataGlobalKit messageWithStatus:[jsonData statusCode]]
                                            code:[jsonData statusCode]]);
                return;
            }else
            {
                NSDictionary *dict = [jsonData valueForKey:@"data"];
                
                BOOL ret = [[dict valueForKey:@"friend"] boolValue];
                completion(ret, nil);
            }
            
        }
        
    } failure:^(MMAFHTTPRequestOperation *operation, NSError *error) {
        completion(NO, error);
    }];
}

- (void)_addFriendToBlacklist:(NSInteger)friendID completion:(RemoteCompletionBool)completion
{
    NSString *access_token = [TTShowUser access_token];
    if ([TTShowUser access_token] == nil)
    {
        completion(NO, [NSError errorMsg:@"token 为空"]);
        return;
    }
    
    NSString *param = [NSString stringWithFormat:urlArray[friend_add_blacklist], access_token, friendID];
    NSString *urlString = [self.baseURLStr stringByAppendingString:param];
    
    [[MMAFAppDotNetAPIClient sharedClient] getPath:urlString parameters:nil success:^(MMAFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *jsonData = [self parseJson:responseObject];
        
        if ([jsonData isRightKind])
        {
            if (![jsonData statusCodeOK])
            {
                completion(NO, [NSError errorMsg:[DataGlobalKit messageWithStatus:[jsonData statusCode]]
                                            code:[jsonData statusCode]]);
                return;
            }
            [self retrieveFriendList:nil];
            completion(YES, nil);
        }
        
    } failure:^(MMAFHTTPRequestOperation *operation, NSError *error) {
        completion(NO, error);
    }];
}

@end
