//
//  TTShowRemote+UserInfo.m
//  memezhibo
//
//  Created by Xingai on 15/5/20.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "TTShowRemote+UserInfo.h"
#import "TTShowRecord.h"
#import "TTShowStarPhoto.h"
#import "TTShowBadge.h"

@implementation TTShowRemote (UserInfo)

- (void)_retrieveUserInfo:(NSInteger)userID completion:(RemoteCompletionUser)completion
{
    NSString *paramString = [NSString stringWithFormat:urlArray[retrieve_user_information_by_id_index], userID];
    NSString *fullURL = [self.baseURLStr stringByAppendingString:paramString];
    
    [[MMAFAppDotNetAPIClient sharedClient] getPath:fullURL parameters:nil success:^(MMAFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *jsonData = [self parseJson:responseObject];
//        LOGINFO(@"user = %@", jsonData);
        
        if ([jsonData isRightKind])
        {
            if (![jsonData statusCodeOK])
            {
                completion(nil, [NSError errorMsg:[jsonData message]]);
                return;
            }
            
            TTShowUser *u = [[TTShowUser alloc] initWithAttributes:[jsonData valueForKey:@"data"]];
            
            completion(u, nil);
        }
        else
        {
            completion(nil, [NSError errorMsg:[jsonData message]]);
        }
    } failure:^(MMAFHTTPRequestOperation *operation, NSError *error) {
        completion(nil, error);
    }];
}

- (void)_retrieveStarPhotoNumber:(NSInteger)starID completion:(RemoteCompletionInteger)completion
{
    NSString *paramString = [NSString stringWithFormat:urlArray[retrieve_star_photo_number_index], starID];
    NSString *fullURL = [self.baseURLStr stringByAppendingString:paramString];
    
    [[MMAFAppDotNetAPIClient sharedClient] getPath:fullURL parameters:nil success:^(MMAFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *jsonData = [self parseJson:responseObject];
        
        if ([jsonData isRightKind])
        {
            if (![jsonData statusCodeOK])
            {
                completion(0, [NSError errorMsg:[jsonData message]]);
                return;
            }
            
            NSDictionary *photoNumDict = [jsonData valueForKey:@"data"];
            NSInteger livePhotos = [[photoNumDict valueForKey:@"type0"] integerValue];
            NSInteger lifePhotos = [[photoNumDict valueForKey:@"type1"] integerValue];
            
            completion(livePhotos + lifePhotos, nil);
        }
        else
        {
            completion(0, [NSError errorMsg:[jsonData message]]);
        }
        
    } failure:^(MMAFHTTPRequestOperation *operation, NSError *error) {
        completion(0, error);
    }];
}

- (void)requestCostRecords:(SuccessBlock)successBlock failBlock:(FailBlock)failBlock
{
    NSString *access_token = [TTShowUser access_token];
    if ([TTShowUser access_token] == nil)
    {
        if (failBlock) {
            failBlock([NSError errorMsg:@"token 为空"]);
        }
        return;
    }
    
    NSString *paramString = [NSString stringWithFormat:urlArray[retrieve_user_cost_record_index], access_token];
    NSString *fullURL = [self.baseURLStr stringByAppendingString:paramString];
    
    
    long long int dayTime = 24 * 60 * 60 * 1000;
    long long int currentTime = [NSDate currentTimeStamp] + dayTime;
    long long int stime = currentTime - 30 * dayTime;
    NSString *stimeStr = [[NSDate time2Date:stime] dateString];
    NSString *etimeStr = [[NSDate time2Date:currentTime] dateString];
    NSDictionary *params = [[NSDictionary alloc] initWithObjectsAndKeys:
                            @"1" , @"page",
                            @"50" , @"size",
                            stimeStr , @"stime",
                            etimeStr , @"etime",
                            @"send_gift" , @"type",
                            nil];
    [HttpUtils executeGetMethodWithUrl:fullURL params:params successBlock:^(NSDictionary *dict) {
        if (successBlock) {
            successBlock(dict);
        }
    } failBlock:^(NSError *error) {
        if (failBlock) {
            failBlock(error);
        }
    }];
}

- (void)retrieveUserRecordsWithParams:(NSDictionary *)params remoteType:(RemoteType)remoteType completion:(RemoteCompletionArray)completion
{
    NSString *access_token = [TTShowUser access_token];
    if ([TTShowUser access_token] == nil)
    {
        completion(nil, [NSError errorMsg:@"token 为空"]);
        return;
    }
    
    NSString *paramString = [NSString stringWithFormat:urlArray[remoteType], access_token];
    NSString *fullURL = [self.baseURLStr stringByAppendingString:paramString];
    
//    LOGINFO(@"user center records url = %@", fullURL);
    
    [[MMAFAppDotNetAPIClient sharedClient] getPath:fullURL parameters:params success:^(MMAFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *jsonData = [self parseJson:responseObject];
//        LOGINFO(@"user center records data = %@", jsonData);
        
        if ([jsonData isRightKind])
        {
            if (![jsonData statusCodeOK])
            {
                completion(nil, [NSError errorMsg:[jsonData message]]);
                return;
            }
            
            NSMutableArray *recordList = [[NSMutableArray alloc] init];
            // parse results.
            NSArray *records = jsonData[@"data"];
            
            for (NSDictionary *recordDict in records)
            {
                switch (remoteType)
                {
                    case retrieve_user_charge_record_index:
                    {
                        TTShowRecord *chargeRecord = [[TTShowRecord alloc] initWithAttributes:recordDict];
                        [recordList addObject:chargeRecord];
                    }
                        break;
                    case retrieve_user_lucky_record_index:
                    {
                        TTShowLuckyRecord *luckyRecord = [[TTShowLuckyRecord alloc] initWithAttributes:recordDict];
                        [recordList addObject:luckyRecord];
                    }
                        break;
                    case retrieve_user_cost_record_index:
                    {
                        TTShowConsumeRecord *consumeRecord = [[TTShowConsumeRecord alloc] initWithAttributes:recordDict];
                        [recordList addObject:consumeRecord];
                    }
                        break;
                    case retrieve_user_gift_receive_record_index:
                    {
                        TTShowRecGiftRecord *recGiftRecord = [[TTShowRecGiftRecord alloc] initWithAttributes:recordDict];
                        [recordList addObject:recGiftRecord];
                    }
                        break;
                    default:
                        NSAssert(0, @"UC records remote parameters error.");
                        break;
                }
            }
            completion(recordList, nil);
        }
        else
        {
            completion(nil, [NSError errorMsg:[jsonData message]]);
        }
    } failure:^(MMAFHTTPRequestOperation *operation, NSError *error) {
        completion(nil, error);
    }];
}

- (void)_uploadUserInformation:(NSDictionary *)userInfo completion:(RemoteCompletionBool)completion
{
    NSString *access_token = [TTShowUser access_token];
    if ([TTShowUser access_token] == nil)
    {
        completion(NO, [NSError errorMsg:@"token为空"]);
        return;
    }
    
    NSString *paramString = [NSString stringWithFormat:urlArray[upload_user_information], access_token];
    NSString *fullURL = [self.baseURLStr stringByAppendingString:paramString];
    
    [[MMAFAppDotNetAPIClient sharedClient] postPath:fullURL parameters:userInfo success:^(MMAFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *jsonData = [self parseJson:responseObject];
        
        if ([jsonData isRightKind])
        {
            if (![jsonData statusCodeOK])
            {
                completion(NO, [NSError errorMsg:[jsonData message]]);
                return;
            }
            
            if (completion)
            {
                completion(YES, nil);
            }
        }
        else
        {
            if (completion)
            {
                completion(NO, [NSError errorMsg:@"wrong return type."]);
            }
            return;
        }
    } failure:^(MMAFHTTPRequestOperation *operation, NSError *error) {
        if (completion)
        {
            completion(NO, nil);
        }
    }];
}

- (void)_retrieveStarPhotoListByType:(StarPhotoType)type starID:(NSInteger)starID completion:(RemoteCompletionArrayInteger)completion
{
    // get parameters.
//    FilterCondition *fc = [FilterCondition sharedInstance];
    
    NSInteger pageNO = 0;
//    switch (type)
//    {
//        case kStarLivePhoto:
//            pageNO = fc.liveAlbumPageNO;
//            break;
//        case kStarLifePhoto:
//            pageNO = fc.lifeAlbumPageNO;
//            break;
//        default:
//            break;
//    }
    
    NSString *paramString = [NSString stringWithFormat:urlArray[retrieve_star_photo_list_index], starID, type, pageNO, kFCDefaultAlbumLimit];
    NSString *fullURL = [self.baseURLStr stringByAppendingString:paramString];
    
//    LOGINFO(@"photo list url:%@", fullURL);
    
    [[MMAFAppDotNetAPIClient sharedClient] getPath:fullURL parameters:nil success:^(MMAFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *jsonData = [self parseJson:responseObject];
        
//        LOGINFO(@"%@",jsonData);
        
        if ([jsonData isRightKind])
        {
            if (![jsonData statusCodeOK])
            {
                completion(0, 0, [NSError errorMsg:[jsonData message]]);
                return;
            }
            
            NSMutableArray *photos = [NSMutableArray arrayWithCapacity:0];
            NSInteger totalCount = [[jsonData valueForKey:@"count"] integerValue];
            NSArray *starPhotos = [jsonData valueForKey:@"data"];
            
            for (NSDictionary *starPhotoDict in starPhotos)
            {
                TTShowStarPhoto *starPhoto = [[TTShowStarPhoto alloc] initWithAttributes:starPhotoDict];
                [photos addObject:starPhoto];
            }
            
            completion(photos, totalCount, nil);
        }
        else
        {
            completion(nil, 0, [NSError errorMsg:[jsonData message]]);
        }
        
    } failure:^(MMAFHTTPRequestOperation *operation, NSError *error) {
        completion(nil, 0, error);
    }];
}

- (void)_retrieveUserInfoNew:(NSInteger)userID completion:(RemoteCompletionUserNew)completion
{
    NSString *paramString = [NSString stringWithFormat:urlArray[retrieve_user_information_by_id_index], userID];
    NSString *fullURL = [self.baseURLStr stringByAppendingString:paramString];
    
    [[MMAFAppDotNetAPIClient sharedClient] getPath:fullURL parameters:nil success:^(MMAFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *jsonData = [self parseJson:responseObject];
//        LOGINFO(@"user = %@", jsonData);
//        NSLog(@"user = %@", jsonData);
        
        if ([jsonData isRightKind])
        {
            if (![jsonData statusCodeOK])
            {
                completion(nil, [NSError errorMsg:[jsonData message]]);
                return;
            }
            
            TTShowUserNew *u = [[TTShowUserNew alloc] initWithAttributes:[jsonData valueForKey:@"data"]];
            
            completion(u, nil);
        }
        else
        {
            completion(nil, [NSError errorMsg:[jsonData message]]);
        }
    } failure:^(MMAFHTTPRequestOperation *operation, NSError *error) {
        completion(nil, error);
    }];
}

- (void)retrieveUserBadge:(NSInteger)userID completion:(RemoteCompletionArray)completion
{
    if (userID == 0)
    {
        if (completion)
        {
            completion(nil, [NSError errorMsg:@"参数错误，用户ID为空."]);
            return;
        }
    }
    NSString *parameterString = [NSString stringWithFormat:urlArray[retrieve_user_badge_index], userID];
    NSString *urlString = [self.baseURLStr stringByAppendingString:parameterString];
    
    [[MMAFAppDotNetAPIClient sharedClient] getPath:urlString parameters:nil success:^(MMAFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *jsonData = [self parseJson:responseObject];
        if ([jsonData isRightKind])
        {
            if (![jsonData statusCodeOK])
            {
                if (completion)
                {
                    NSString *msg = [DataGlobalKit messageWithStatus:[jsonData statusCode]];
                    if (msg == nil)
                    {
                        msg = [jsonData message];
                    }
                    completion(nil, [NSError errorMsg:msg]);
                }
                return;
            }
            
            NSMutableArray *badgeList = [[NSMutableArray alloc] init];
            
            NSArray *badges = [jsonData valueForKey:@"data"];
            for (NSDictionary *badgeDict in badges)
            {
                TTShowBadge *award = [[TTShowBadge alloc] initWithAttributes:badgeDict];
                [badgeList addObject:award];
            }
            
            completion(badgeList, nil);
        }
        else
        {
            completion(nil, [NSError errorMsg:@"jsonData is wrong kind."]);
        }
        
    } failure:^(MMAFHTTPRequestOperation *operation, NSError *error) {
        completion(nil, error);
    }];
}

@end
