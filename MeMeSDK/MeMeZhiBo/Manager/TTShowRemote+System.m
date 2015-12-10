//
//  TTShowRemote+System.m
//  memezhibo
//
//  Created by Xingai on 15/5/14.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "TTShowRemote+System.h"
#import "CommonParameter.h"
#import "NSObject+SBJSON.h"
#import "TTShowUser.h"

// Collect iOS Client Logs.
#if 0
#define kCollectLogURL   @"http://192.168.6.62/beauty_client/index.html"
#else
#define kCollectLogURL   @"http://collect.log.ttpod.com/beauty_client/index.html"
#endif

@implementation TTShowRemote (System)

-(void)_collectLog
{
    CommonParameter *common = [CommonParameter sharedInstance];
    NSDictionary *paramField = [NSDictionary dictionaryWithObjectsAndKeys:
                                common.uid,       @"uid",
                                common.app,       @"app",
                                common.hid,       @"hid",
                                common.v,         @"v",
                                common.f,         @"f",
                                common.s,         @"s",
                                common.imsi,      @"imsi",
                                @(common.net),    @"net",
                                common.mid,       @"mid",
                                common.splus,     @"splus",
                                @(common.active), @"active",
                                @(common.tid),    @"tid",
                                nil];
    
    NSDictionary *body = [NSDictionary dictionaryWithObjectsAndKeys:
                          @[common.openDictionary], @"data",
                          paramField, @"param", nil];
    
    NSString *jsonBody = [body JSONRepresentation];//[[body JSONRepresentation] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSData *bodyData = [jsonBody dataUsingEncoding:NSUTF8StringEncoding];
    
    HttpClientSyn *http = [[HttpClientSyn alloc] init];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        NSMutableURLRequest *request = [NSMutableURLRequest POSTRequestForURL:kCollectLogURL withJSONData:bodyData];
        __unused NSDictionary *result = [http sendRequestForJSONResponse:request];
        
    });

}

-(void)_dayLoginWith:(NSString *)deviceUID
{
    NSString *access_token = [TTShowUser access_token];
    if ([TTShowUser access_token] == nil)
    {
        return;
    }
    
    NSString *param = [NSString stringWithFormat:urlArray[day_login_record_index], access_token, deviceUID];
    NSString *urlString = [self.baseURLStr stringByAppendingString:param];
    
    //    LOGINFO(@"urlString = %@", urlString);
    
    [[MMAFAppDotNetAPIClient sharedClient] getPath:urlString parameters:nil success:^(MMAFHTTPRequestOperation *operation, id responseObject) {
        
        //        NSDictionary *jsonData = [self parseJson:responseObject];
        //
        //        LOGINFO(@"Device UID:%@ jsonData = %@", deviceUID, jsonData);
        
    } failure:^(MMAFHTTPRequestOperation *operation, NSError *error) {
        
    }];

}

- (void)_registerDeviceToken:(NSString *)deviceToken
{
    NSString *access_token = [TTShowUser access_token];
    if ([TTShowUser access_token] == nil)
    {
        return;
    }
    
    if (deviceToken == nil || [deviceToken isEqualToString:@""])
    {
        return;
    }
    
    // Filter '<' '>' character
    NSRange range;
    range.length = deviceToken.length - 2;
    range.location = 1;
    deviceToken = [deviceToken substringWithRange:range];
    
    
    NSString *deviceTokenEncoded = [deviceToken stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *param = [NSString stringWithFormat:urlArray[upload_device_token_index], access_token, deviceTokenEncoded];
    NSString *urlString = [self.baseURLStr stringByAppendingString:param];
    
    [[MMAFAppDotNetAPIClient sharedClient] getPath:urlString parameters:nil success:^(MMAFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *jsonData = [self parseJson:responseObject];
        if ([jsonData isRightKind])
        {
            if (![jsonData statusCodeOK])
            {
                return;
            }
            
            [FilterCondition sharedInstance].deviceTokenRegistered = YES;
        }
        else
        {
        }
    } failure:^(MMAFHTTPRequestOperation *operation, NSError *error) {
    }];
}

- (void)_requestSensitiveNickNames:(SuccessBlock)successBlock failBlock:(FailBlock)failBlock
{
    NSString *urlString = [self.baseURLStr stringByAppendingString:urlArray[sensitive_nick_names]];
    [HttpUtils executeGetMethodWithUrl:urlString params:nil successBlock:^(NSDictionary *dict) {
        NSArray *nickNames = [dict objectForKey:kData];
        if (nickNames.count > 0) {
//            [Cache addSensitiveNickNames:nickNames];
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

- (void)_requestSensitiveWords:(SuccessBlock)successBlock failBlock:(FailBlock)failBlock
{
    NSString *urlString = [self.baseURLStr stringByAppendingString:urlArray[sensitive_words]];
    [HttpUtils executeGetMethodWithUrl:urlString params:nil successBlock:^(NSDictionary *dict) {
        NSArray *words = [dict objectForKey:kData];
        if (words.count > 0) {
//            [Cache addSensitiveWords:words];
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

- (void)_sendSuggestion:(NSString *)contact content:(NSString *)content completion:(RemoteCompletionBool)completion
{
    if (content == nil || [content isEqualToString:@""])
    {
        return;
    }
    
    NSString *encodedContact = [contact stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *encodedContent = [content stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSString *param = [NSString stringWithFormat:urlArray[send_suggestion_index], encodedContact, encodedContent];
    // Combine common parameters.
    CommonParameter *common = [CommonParameter sharedInstance];
    NSString *commonParams =
    [NSString stringWithFormat:@"&uid=%@&hid=%@&s=%@&tid=%ld&app=%@&f=%@&net=%ld&v=%@&rom=iOS",
     common.uid,
     common.hid,
     common.s,
     (long)common.tid,
     common.app,
     common.f,
     (long)common.net,
     common.v];
    NSString *urlString = [NSString stringWithFormat:@"%@%@%@", self.baseURLStr, param, commonParams];
    
    [[MMAFAppDotNetAPIClient sharedClient] postPath:urlString parameters:nil success:^(MMAFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *jsonData = [self parseJson:responseObject];
        if ([jsonData isRightKind])
        {
            if (![jsonData statusCodeOK])
            {
                completion(NO, [NSError errorMsg:[jsonData message]]);
                return;
            }
            
            completion(YES, nil);
        }
    } failure:^(MMAFHTTPRequestOperation *operation, NSError *error) {
        completion(NO, error);
    }];
}

@end
