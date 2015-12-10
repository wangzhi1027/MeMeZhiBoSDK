//
//  TTShowRemote+UserManager.m
//  TTShow
//
//  Created by twb on 13-10-10.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import "TTShowRemote+UserManager.h"
#import "TTShowUser.h"
#import "SBJSON.h"
#import "BagGift.h"
#import "UserInfo.h"
#import "TalkingDataAppCpa.h"


// Post Method passing by one by one...
#define kUserLoginTestURL    @"http://test.user.memeyule.com/login?login_name=%@&pwd=%@&f=%@"
#define kUserRegisterTestURL @"http://test.user.2339.com/register/uname?auth_code=%@&username=%@&pwd=%@&auth_key=%@"
#define kUserLoginURL    @"http://user.memeyule.com/login?login_name=%@&pwd=%@&f=%@"
#define kUserRegisterURL @"http://user.2339.com/register/uname?auth_code=%@&username=%@&pwd=%@&auth_key=%@"

@implementation TTShowRemote (UserManager)

// User Register.
- (void)_userRegister:(NSString *)nickName userName:(NSString *)userName password:(NSString *)password authkey:(NSString *)authKey completion:(RemoteCompletionUser)completion
{
    // jude parameter if necessary.
    
    // Encode userName.
    NSString *uName = [userName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    // Encode nickName.
    NSString *nName = [nickName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSString *checkUserUrlString = [NSString stringWithFormat:self.dataManager.filter.testModeOn ? kUserRegisterTestURL : kUserRegisterURL, nName, uName, password,authKey];
    
    [[MMAFAppDotNetAPIClient sharedClient] postPath:checkUserUrlString parameters:nil success:^(MMAFHTTPRequestOperation *operation, id responseObject)
     {
         NSDictionary *checkUserJsonData = [self parseJson:responseObject];
         NSDictionary *checkUserDictionary = nil;
         NSLog(@"res:%@",checkUserJsonData);
         
         
         if ([checkUserJsonData isRightKind])
         {
             if (![checkUserJsonData statusCodeOK])
             {
                 NSString *msg = [DataGlobalKit messageWithStatus:[checkUserJsonData statusCode]];
                 if (msg == nil)
                 {
                     msg = [NSString stringWithFormat:@"注册失败:%@", [checkUserJsonData message]];
                 }
                 
                 if (completion)
                 {
                     completion(nil, [NSError errorMsg:msg]);
                 }
                 return;
             }
             checkUserDictionary = [checkUserJsonData valueForKey:kUserLoginCheckNodeName];
         }
         else
         {
         }
         
         if (checkUserDictionary.access_token1 == nil || [checkUserDictionary.access_token1 isEqualToString:@""])
         {
             completion(nil, [NSError errorMsg:@"token 为空"]);
             return;
         }
         
         NSString *parameterString = [NSString stringWithFormat:urlArray[retrieve_user_information_index], checkUserDictionary.access_token1, kUserInformationDataSource];
         NSString *userUrlString = [self.baseURLStr stringByAppendingString:parameterString];
         
         
         [[MMAFAppDotNetAPIClient sharedClient] getPath:userUrlString parameters:nil success:^(MMAFHTTPRequestOperation *operation, id responseObject)
          {
              NSDictionary *userJsonData = [self parseJson:responseObject];
              NSDictionary *userDictionary = nil;
              
              if ([userJsonData isRightKind])
              {
                  if (![userJsonData statusCodeOK])
                  {
                      NSString *msg = [DataGlobalKit messageWithStatus:[userJsonData statusCode]];
                      if (msg == nil)
                      {
                          msg = [NSString stringWithFormat:@"注册失败:%@", [userJsonData message]];
                      }
                      if (completion)
                      {
                          completion(nil, [NSError errorMsg:msg]);
                      }
                      return;
                  }
                  userDictionary = [userJsonData valueForKey:kUserLoginNodeName];
              }
              else
              {
              }
              
              if (userDictionary == nil)
              {
              }
              
              // User
              [userDictionary setValue:checkUserDictionary.access_token1 forKey:@"access_token"];    // additional
              
              TTShowUser *user = [[TTShowUser alloc] initWithAttributes:userDictionary];
              [TTShowUser archiveUser:user];
              
              [TalkingDataAppCpa onLogin:user.user_name];
              
              if (completion)
              {
                  completion(user, nil);
              }
              
          } failure:^(MMAFHTTPRequestOperation *operation, NSError *error) {
              
              if (completion)
              {
                  completion(nil, error);
              }
              
          }];
         
     } failure:^(MMAFHTTPRequestOperation *operation, NSError *error) {
         
         if (completion)
         {
             completion(nil, error);
         }
         
     }];
}


// User Login
- (void)_userLogin:(NSString *)userName password:(NSString *)password key:(NSString*)key completion:(RemoteCompletionUser)completion
{
    
    // Encode userName.
    NSString *uName = [userName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSString *checkUserUrlString = [NSString stringWithFormat:self.dataManager.filter.testModeOn ?  kUserLoginTestURL: kUserLoginURL, uName, password,key];
    
    
    [[MMAFAppDotNetAPIClient sharedClient] postPath:checkUserUrlString parameters:nil success:^(MMAFHTTPRequestOperation *operation, id responseObject)
     {
         NSDictionary *checkUserJsonData = [self parseJson:responseObject];
         NSString * tokenstr=nil;
         
         if ([checkUserJsonData isRightKind])
         {
             if (![(NSDictionary *)checkUserJsonData statusCodeOK])
             {
                 if (completion)
                 {
                     NSString *msg = [DataGlobalKit messageWithStatus:[checkUserJsonData statusCode]];
                     if (msg == nil)
                     {
                         msg = [NSString stringWithFormat:@"登录失败:%@", [checkUserJsonData message]];
                     }
                     
                     completion(nil, [NSError errorMsg:msg]);
                 }
                 return;
             }
             
             NSDictionary *data = [checkUserJsonData valueForKey:kUserLoginCheckNodeName];
             tokenstr = [data valueForKey:@"token"];
         }
         else
         {
         }
         
         if (tokenstr == nil || [tokenstr isEqualToString:@""])
         {
             completion(nil, [NSError errorMsg:@"token 为空"]);
             return;
         }
         
         NSString *parameterString = [NSString stringWithFormat:urlArray[retrieve_user_information_index], tokenstr, kUserInformationDataSource];
         NSString *userUrlString = [self.baseURLStr stringByAppendingString:parameterString];
         
         
         [[MMAFAppDotNetAPIClient sharedClient] getPath:userUrlString parameters:nil success:^(MMAFHTTPRequestOperation *operation, id responseObject)
          {
              NSDictionary *userJsonData = [self parseJson:responseObject];
              NSDictionary *userDictionary = nil;
              
              
              if ([userJsonData isRightKind])
              {
                  if (![(NSDictionary *)userJsonData statusCodeOK])
                  {
                      
                      NSString *msg = [DataGlobalKit messageWithStatus:[userJsonData statusCode]];
                      if (msg == nil)
                      {
                          msg = [NSString stringWithFormat:@"登录失败:%@", [userJsonData message]];
                      }
                      completion(nil, [NSError errorMsg:msg]);
                      return;
                  }
                  userDictionary = [userJsonData valueForKey:kUserLoginNodeName];
              }
              else
              {
              }
              
              if (userDictionary == nil)
              {
              }
              
              //             LOGINFO(@"userDictionary = %@", userDictionary);
              // User
              [userDictionary setValue:tokenstr forKey:@"access_token"];    // additional
              TTShowUser *user = [[TTShowUser alloc] initWithAttributes:userDictionary];
              [TTShowUser archiveUser:user];
              
              if (completion)
              {
                  completion(user, nil);
              }
              
          } failure:^(MMAFHTTPRequestOperation *operation, NSError *error) {
              
              if (completion)
              {
                  completion(nil, error);
              }
              
          }];
         
     } failure:^(MMAFHTTPRequestOperation *operation, NSError *error) {
         
         if (completion)
         {
             completion(nil, error);
         }
         
     }];
}

// I think this is a bug from server, the client has to do this thing. oh no....
- (NSDictionary *)filterResult:(NSData *)data
{
    if (data == nil)
    {
        NSAssert(data != nil, @"第三方登录返回数据为空.");
        return nil;
    }
    
    NSString *dataStr = [NSString stringWithUTF8String:data.bytes];
    
#if 1
    //    NSRange beginRange = [dataStr rangeOfString:@"{\"code\""];
    //    LOGINFO(@"beginRange = %d len:%d", beginRange.location, beginRange.length);
    //    NSRange endRange = [dataStr rangeOfString:@"')</script>"];
    //    LOGINFO(@"endRange = %d len:%d", endRange.location, endRange.length);
    
    NSRange beginRange = [dataStr rangeOfString:@"{\"code\""];
    if (beginRange.location != NSNotFound)
    {
        dataStr = [dataStr substringFromIndex:beginRange.location];
    }
    NSRange endRange = [dataStr rangeOfString:@"')</script>"];
    if (endRange.location != NSNotFound)
    {
        dataStr = [dataStr substringToIndex:endRange.location];
    }
#else
    dataStr = [dataStr stringByReplacingOccurrencesOfString:@"<script type=\"text/javascript\"> window.UserSystem.setUserInfo('" withString:@""];
    dataStr = [dataStr stringByReplacingOccurrencesOfString:@"')</script>" withString:@""];
#endif
    
    
    SBJsonParserS *jsonParse = [[SBJsonParserS alloc] init];
    
    return [jsonParse objectWithString:dataStr];
}

- (void)_loginFromThirdParty:(NSString *)urlString completion:(RemoteCompletionUser)completion
{
    HttpClientSyn *http = [[HttpClientSyn alloc] init];
    
    NSData *result = [http sendRequest:[NSMutableURLRequest GETRequestForURL:urlString]];
    
    NSDictionary *jsonData = [self filterResult:result];
    
    
    

    if ([jsonData isRightKind])
    {
        if (![jsonData statusCodeOK])
        {
            completion(nil, [NSError errorMsg:[jsonData message]]);
            return;
        }
        
        NSString *access_token = [[jsonData valueForKey:@"data"] valueForKey:@"token"];
        if(access_token == nil){
            access_token = [[jsonData valueForKey:@"data"] valueForKey:@"access_token"];
        }
        [self updateUserInfo:access_token completion:completion];
    }
}

- (void)_loginFrom3rdPartySDK:(NSDictionary *)param completion:(RemoteCompletionUser)completion
{
    if (!param)
    {
        return;
    }
    
#if 1
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:param];
    NSString *urlString = params[@"verify_url"];
    [params removeObjectForKey:@"verify_url"];
    
    
    
    
    [[MMAFAppDotNetAPIClient sharedClient] postPath:urlString parameters:params success:^(MMAFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *jsonData = [self parseJson:responseObject];
        
        if ([jsonData isRightKind])
        {
            if (![jsonData statusCodeOK])
            {
                completion(nil, [NSError errorMsg:[jsonData message]]);
                return;
            }
            
            NSString *access_token = [[jsonData valueForKey:@"data"] valueForKey:@"token"];
            
            
            if ([access_token isKindOfClass:[NSString class]])
            {
                if (access_token && ![access_token isEqualToString:@""])
                {
                    [self updateUserInfo:access_token completion:completion];
                }
            }
        }
        else
        {
            if (completion)
            {
                completion(nil, [NSError errorMsg:@"return type error from server."]);
            }
        }
    } failure:^(MMAFHTTPRequestOperation *operation, NSError *error) {
        if (completion)
        {
            completion(nil, [NSError errorMsg:@"Unknown error."]);
        }
    }];
    
#else
    HttpClientSyn *http = [[HttpClientSyn alloc] init];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:param];
    NSString *urlString = params[@"verify_url"];
    [params removeObjectForKey:@"verify_url"];
    NSString *paramStr = [param JSONRepresentation];
    dispatch_async(dispatch_get_main_queue(), ^{
        NSDictionary *result = [http sendRequestForJSONResponse:
                                [NSMutableURLRequest POSTRequestForURL:urlString
                                                          withJSONData:[NSData dataWithBytes:[paramStr UTF8String]
                                                                                      length:paramStr.length]]];
        if ([result isRightKind])
        {
            if (![result statusCodeOK])
            {
                completion(nil, [NSError errorMsg:[result message]]);
                return;
            }
            
            NSString *access_token = [[result valueForKey:@"data"] valueForKey:@"access_token"];
            if ([access_token isKindOfClass:[NSString class]])
            {
                if (access_token && ![access_token isEqualToString:@""])
                {
                    [self _updateUserInfo:access_token completion:completion];
                }
            }
        }
        else
        {
            if (completion)
            {
                completion(nil, [NSError errorMsg:@"return type error from server."]);
            }
        }
    });
#endif
}

- (void)_loginWhenAppStart
{
     NSString *access_token = [TTShowUser access_token];
    if (access_token) {
        NSString *url = [NSString stringWithFormat:urlArray[retrieve_user_information_index], access_token, kUserInformationDataSource];
        [HttpUtils executeGetMethodWithUrl:[self.baseURLStr stringByAppendingString:url] params:nil successBlock:^(NSDictionary *dict) {
            UserInfoResult *result = [[UserInfoResult alloc] initWithDictionary:dict error:nil];
            UserInfo *userInfo = result.data;
            if (userInfo) {
                [[TMCache sharedCache] setObject:userInfo forKey:CACHE_USER_INFO block:nil];
            }
            [self requestBagGifts:nil failBlock:nil];
            [self retrieveFriendList:nil];
        } failBlock:nil];
    }
}

- (void)updateUserInfo:(NSString *)access_token completion:(RemoteCompletionUser)completion
{
    if (access_token == nil)
    {
        completion(nil, [NSError errorMsg:@"token为空,请先登录"]);
        return;
    }
    
    NSString *parameterString = [NSString stringWithFormat:urlArray[retrieve_user_information_index], access_token, kUserInformationDataSource];
    NSString *userUrlString = [self.baseURLStr stringByAppendingString:parameterString];
    
    
    [[MMAFAppDotNetAPIClient sharedClient] getPath:userUrlString parameters:nil success:^(MMAFHTTPRequestOperation *operation, id responseObject)
     {
         NSDictionary *userJsonData = [self parseJson:responseObject];
         NSDictionary *userDictionary = nil;
         
         
         if ([userJsonData isRightKind])
         {
             if (![userJsonData statusCodeOK])
             {
                 NSString *msg = [DataGlobalKit messageWithStatus:[userJsonData statusCode]];
                 if (msg == nil)
                 {
                     msg = [NSString stringWithFormat:@"更新失败:%@", [userJsonData message]];
                 }
                 if (completion)
                 {
                     completion(nil, [NSError errorMsg:msg]);
                 }
                 return;
             }
             userDictionary = [userJsonData valueForKey:kUserLoginNodeName];
         }
         // User
         [userDictionary setValue:access_token forKey:@"access_token"];    // additional
         
         TTShowUser *user = [[TTShowUser alloc] initWithAttributes:userDictionary];
         // Save user.
         [TTShowUser archiveUser:user];
         
         if (completion)  {
             completion(user, nil);
         }
         [self requestBagGifts:nil failBlock:nil];
         
     } failure:^(MMAFHTTPRequestOperation *operation, NSError *error) {
         
         if (completion) {
             completion(nil, error);
         }
     }];
}

- (void)_updateUserInformationWithCompletion:(RemoteCompletionUser)completion
{
    [self updateUserInfo:[TTShowUser access_token] completion:completion];
}

- (void)requestBagGifts:(SuccessBlock)successBlock failBlock:(FailBlock)failBlock
{
    NSString *access_token = [TTShowUser access_token];
    if ([TTShowUser access_token] == nil)
    {
        if (failBlock) {
            failBlock([NSError errorMsg:@"token 为空"]);
        }
        return;
    }
    
    NSString *url = [NSString stringWithFormat:urlArray[user_bag_index], access_token];
    [HttpUtils executeGetMethodWithUrl:[self.baseURLStr stringByAppendingString:url] params:nil successBlock:^(NSDictionary *dict) {
        BagGift *bagGift = [[BagGift alloc]initWithDictionary:dict error:nil];
        
        
        if (bagGift) {
            [[TMCache sharedCache] setObject:bagGift forKey:CACHE_BAG block:nil];
        }
        if (successBlock) {
            successBlock(dict);
        }
    } failBlock:^(NSError *error) {
        if (failBlock) {
            failBlock(error);
        }
    }];
}

@end
