//
//  TTShowRemote+Resister.m
//  memezhibo
//
//  Created by Xingai on 15/6/19.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#define kPhoneVerificationTest @"http://test.user.memeyule.com"
#define kPhoneVerification      @"http://user.memeyule.com"


#import "TTShowRemote+Resister.h"

@implementation TTShowRemote (Resister)

-(void)sendPhoneNumber:(NSString *)number completion:(RemoteCompletionBool)completion
{
    
    
    NSString *paramString = [NSString stringWithFormat:urlArray[phone_Verification_code], number];
    NSString *fullURL = [self.dataManager.filter.testModeOn?kPhoneVerificationTest:kPhoneVerification stringByAppendingString:paramString];
    
    [[MMAFAppDotNetAPIClient sharedClient] getPath:fullURL parameters:nil success:^(MMAFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *jsonData = [self parseJson:responseObject];
        
        
        if ([jsonData isRightKind])
        {
            if (![jsonData statusCodeOK])
            {
                completion(NO, [NSError errorMsg:[jsonData message]]);
                return;
            }
            
            
            if ([[jsonData valueForKey:@"code"] integerValue]==1)
            {
                completion(YES, nil);
            }
            else
            {
                if (completion)
                {
                    completion(NO, [NSError errorMsg:[jsonData message]]);
                }
            }
        }
    } failure:^(MMAFHTTPRequestOperation *operation, NSError *error) {
        if (completion)
        {
            completion(NO, error);
        }
    }];

}

-(void)sendPhoneauthcode:(NSString*)number completion:(RemoteCompletionBool)completion
{
    NSString *paramString = [NSString stringWithFormat:urlArray[phone_authcode], number];
    NSString *fullURL = [self.dataManager.filter.testModeOn?kPhoneVerificationTest:kPhoneVerification stringByAppendingString:paramString];
    
    [[MMAFAppDotNetAPIClient sharedClient] getPath:fullURL parameters:nil success:^(MMAFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *jsonData = [self parseJson:responseObject];
        
        
        if ([jsonData isRightKind])
        {
            if (![jsonData statusCodeOK])
            {
                completion(NO, [NSError errorMsg:[jsonData message]]);
                return;
            }
            
            
            
            if ([[jsonData valueForKey:@"code"] integerValue]==1)
            {
                completion(YES, nil);
            }
            else
            {
                if (completion)
                {
                    completion(NO, [NSError errorMsg:[jsonData message]]);
                }
            }

            

        }
    } failure:^(MMAFHTTPRequestOperation *operation, NSError *error) {
        if (completion)
        {
            completion(NO, error);
        }
    }];
}

-(void)sendPhoneauthcodeLogin:(NSString *)number pasword:(NSString *)pas code:(NSString *)code completion:(RemoteCompletionUser)completion
{
    NSString *paramString = [NSString stringWithFormat:urlArray[phone_register], code,pas,number];
    
    NSString *fullURL = [self.dataManager.filter.testModeOn?kPhoneVerificationTest:kPhoneVerification stringByAppendingString:paramString];
    
    [[MMAFAppDotNetAPIClient sharedClient] postPath:fullURL parameters:nil success:^(MMAFHTTPRequestOperation *operation, id responseObject)
     {
         NSDictionary *checkUserJsonData = [self parseJson:responseObject];
         NSDictionary *checkUserDictionary = nil;
        
         
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

@end
