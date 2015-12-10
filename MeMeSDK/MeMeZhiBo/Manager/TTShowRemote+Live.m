//
//  TTShowRemote+Live.m
//  memezhibo
//
//  Created by Xingai on 15/5/19.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "TTShowRemote+Live.h"
#import "TTShowAdmin.h"

@implementation TTShowRemote (Live)

- (void)_retrieveRoomManagers:(NSUInteger)roomID completion:(RemoteCompletionArray)completion
{
    NSString *paramString = [NSString stringWithFormat:urlArray[retrieve_room_admin_list_index], roomID];
    NSString *adminListUrlString = [self.baseURLStr stringByAppendingString:paramString];
    
    
    [[MMAFAppDotNetAPIClient sharedClient] getPath:adminListUrlString parameters:nil success:^(MMAFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *jsonData = [self parseJson:responseObject];
        NSMutableArray *adminList = [NSMutableArray arrayWithCapacity:0];
//        NSLog(@"jsonData = %@", jsonData);
        
        if ([jsonData isRightKind])
        {
            if (![jsonData statusCodeOK])
            {
                completion(nil, [NSError errorMsg:[jsonData message]]);
                return;
            }
            
            NSArray *admins = [[jsonData valueForKey:kAdminNodeName] valueForKey:kAdminListNodeName];
            
            for (NSDictionary *adminDict in admins)
            {
                TTShowAdmin *admin = [[TTShowAdmin alloc] initWithAttributes:adminDict];
                [adminList addObject:admin];
            }
            
            if (completion)
            {
                completion(adminList, nil);
            }
        }
        else
        {
        }
        
    } failure:^(MMAFHTTPRequestOperation *operation, NSError *error) {
        if (completion)
        {
            completion(nil, error);
        }
    }];
}

- (void)_retrieveRoomStar:(NSUInteger)roomID WithBlock:(void (^)(TTShowRoomStar *roomStar, NSError *error))block
{
    // retrieve_room_star_index
    NSString *paramString = [NSString stringWithFormat:urlArray[retrieve_room_star_index], roomID];
    NSString *fullURL = [self.baseURLStr stringByAppendingString:paramString];
    
    
    [[MMAFAppDotNetAPIClient sharedClient] getPath:fullURL parameters:nil success:^(MMAFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *jsonData = [self parseJson:responseObject];
        
        TTShowRoomStar *roomStar = nil;
        if ([jsonData isRightKind])
        {
            if (![jsonData statusCodeOK])
            {
                block(nil, [NSError errorMsg:[jsonData message]]);
                return;
            }
            
            
            NSDictionary *roomStarDictionary = [jsonData valueForKey:KRoomStarNodeName];
            roomStar = [[TTShowRoomStar alloc] initWithAttributes:roomStarDictionary];
        }
        else
        {
            block(nil, [NSError errorMsg:[jsonData message]]);
            return;
        }
        
        if (block)
        {
            block(roomStar, nil);
        }
    } failure:^(MMAFHTTPRequestOperation *operation, NSError *error) {
        if (block)
        {
            block(nil, error);
        }
    }];
}


- (void)_retrieveTTL:(RoomTTLType)type room:(NSUInteger)roomID completion:(RemoteCompletionInteger)completion
{
    NSString *access_token = [TTShowUser access_token];
    if ([TTShowUser access_token] == nil)
    {
        if (completion)
        {
            completion(-1, [NSError errorMsg:@"token为空,请先登录"]);
        }
        return;
    }
    
    NSString *parameterString = nil;
    
    switch (type)
    {
        case kRoomShutUpTTL:
            parameterString = [NSString stringWithFormat:urlArray[retrieve_shutup_ttl_list_index], access_token, roomID];
            break;
        case kRoomKickTTL:
            parameterString = [NSString stringWithFormat:urlArray[retrieve_kick_ttl_list_index], access_token, roomID];
            break;
        default:
            break;
    }
    
    NSString *urlString = [self.baseURLStr stringByAppendingString:parameterString];
    
    [[MMAFAppDotNetAPIClient sharedClient] getPath:urlString parameters:nil success:^(MMAFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *jsonData = [self parseJson:responseObject];
        
        if ([jsonData isRightKind])
        {
            if (![jsonData statusCodeOK])
            {
                completion(-1, [NSError errorMsg:[jsonData message]]);
                return;
            }
            
            NSInteger ttl = [[[jsonData valueForKey:@"data"] valueForKey:@"ttl"] integerValue];
            
            if (completion)
            {
                completion(ttl, nil);
            }
        }
        else
        {
        }
        
    } failure:^(MMAFHTTPRequestOperation *operation, NSError *error) {
        if (completion)
        {
            completion(-1, error);
        }
    }];
}

- (void)_retrieveVideoUrl:(NSInteger)roomID completion:(RemoteCompletionString)completion
{
    NSString *paramString = [NSString stringWithFormat:urlArray[retrieve_video_url_index], roomID];
    NSString *fullURL = [self.baseURLStr stringByAppendingString:paramString];
    [[MMAFAppDotNetAPIClient sharedClient] getPath:fullURL parameters:nil success:^(MMAFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *jsonData = [self parseJson:responseObject];
        NSString *videoString = nil;
        if ([jsonData isRightKind])
        {
            if (![jsonData statusCodeOK])
            {
                completion(nil, [NSError errorMsg:[jsonData message]]);
                return;
            }
            
            videoString = [jsonData valueForKey:@"data"];
        }
        else
        {
        }
        
        if (completion)
        {
            completion(videoString, nil);
        }
        
    } failure:^(MMAFHTTPRequestOperation *operation, NSError *error) {
        if (completion)
        {
            completion(nil, error);
        }
    }];
}

- (void)retrieveAudienceList:(NSInteger)roomID page:(NSInteger)page size:(NSInteger)size completion:(RemoteCompletionArrayInteger)completion
{
    NSString *param = [NSString stringWithFormat:urlArray[retrieve_audience_list_index], roomID, page, size];
    NSString *urlString = [self.baseURLStr stringByAppendingString:param];
    
    [[MMAFAppDotNetAPIClient sharedClient] getPath:urlString parameters:nil success:^(MMAFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *jsonData = [self parseJson:responseObject];
        NSMutableArray *audiences = [NSMutableArray arrayWithCapacity:0];
        NSInteger totalCount = 0;
        
        if ([jsonData isRightKind])
        {
            if (![jsonData statusCodeOK])
            {
                completion(nil, 0, [NSError errorMsg:[jsonData message]]);
                return;
            }
            
            NSDictionary *audienceDict = [jsonData valueForKey:@"data"];
            NSArray *audienceList = [audienceDict valueForKey:@"list"];
            
            
            totalCount = [[audienceDict valueForKey:@"count"] integerValue];
            
            for (NSDictionary *userDict in audienceList)
            {
                TTShowAudience *user = [[TTShowAudience alloc] initWithAttributes:userDict];
                [audiences addObject:user];
            }
            
            completion(audiences, totalCount, nil);
        }
    } failure:^(MMAFHTTPRequestOperation *operation, NSError *error) {
        completion(nil, 0, error);
    }];

}

// Send Broadcast
- (void)_sendBroadcast:(NSInteger)roomID content:(NSString *)c completion:(RemoteCompletionBool)completion
{
    NSString *access_token = [TTShowUser access_token];
    if ([TTShowUser access_token] == nil)
    {
        completion(NO, [NSError errorMsg:@"token 为空"]);
        return;
    }
    
    // Encode content.
    c = [c stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSString *param = [NSString stringWithFormat:urlArray[send_broadcast_index], access_token, roomID, c];
    NSString *urlString = [self.baseURLStr stringByAppendingString:param];
    
    
    [[MMAFAppDotNetAPIClient sharedClient] getPath:urlString parameters:nil success:^(MMAFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *jsonData = [self parseJson:responseObject];
        
        if ([jsonData isRightKind])
        {
            if (![jsonData statusCodeOK])
            {
                if ([jsonData balanceIsNotEnough])
                {
                    completion(NO, [NSError errorMsg:@"余额不足"]);
                }
                return;
            }
            
            completion(YES, nil);
        }
        
    } failure:^(MMAFHTTPRequestOperation *operation, NSError *error) {
        completion(NO, error);
    }];
}

// 禁止发言 (...token/:room_id/:xy_user_id?minute=60)
- (void)_manageOrderShutup:(NSInteger)minute toUser:(NSInteger)userid inRoom:(NSInteger)roomid completion:(RemoteCompletionBool)completion
{
    NSString *access_token = [TTShowUser access_token];
    if ([TTShowUser access_token] == nil)
    {
        completion(NO, [NSError errorMsg:@"token 为空"]);
        return;
    }
    
    NSString *param = [NSString stringWithFormat:urlArray[manage_shutup_index], access_token, roomid, userid, minute];
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
        else
        {
            completion(NO, [NSError errorMsg:@"return type of server is bad."]);
        }
        
    } failure:^(MMAFHTTPRequestOperation *operation, NSError *error) {
        if (completion)
        {
            completion(NO, error);
        }
    }];
}

// 恢复发言 (...token/:room_id/:xy_user_id)
- (void)_manageOrderRecoverUser:(NSInteger)userid inRoom:(NSInteger)roomid completion:(RemoteCompletionBool)completion
{
    NSString *access_token = [TTShowUser access_token];
    if ([TTShowUser access_token] == nil)
    {
        completion(NO, [NSError errorMsg:@"token 为空"]);
        return;
    }
    
    NSString *param = [NSString stringWithFormat:urlArray[manage_recover_index], access_token, roomid, userid];
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
        else
        {
            completion(NO, [NSError errorMsg:@"return type of server is bad."]);
        }
        
    } failure:^(MMAFHTTPRequestOperation *operation, NSError *error) {
        if (completion)
        {
            completion(NO, error);
        }
    }];
}

- (void)remoteGuanjianziCompletion:(RemoteCompletionArray)completion
{
    NSString *param = urlArray[guanjianzi_list];
    NSString *urlString = [self.baseURLStr stringByAppendingString:param];
    
    
    
    [[MMAFAppDotNetAPIClient sharedClient] getPath:urlString parameters:nil success:^(MMAFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *jsonData = [self parseJson:responseObject];
        NSMutableArray *audiences = [NSMutableArray arrayWithCapacity:0];
        
        
        
        if ([jsonData isRightKind])
        {
            if (![jsonData statusCodeOK])
            {
                completion(nil, [NSError errorMsg:[jsonData message]]);
                return;
            }
            
            NSArray *arr = [jsonData objectForKey:@"data"];
            [audiences addObjectsFromArray:arr];
            

            completion(audiences, nil);
 
            
        }
    } failure:^(MMAFHTTPRequestOperation *operation, NSError *error) {
        completion(nil, error);
    }];
}

- (void)remoteGuanjianziToCompletion:(RemoteCompletionArray)completion
{
    NSString *param = urlArray[guanjianzi_list1];
    NSString *urlString = [self.baseURLStr stringByAppendingString:param];
    
    
    
    [[MMAFAppDotNetAPIClient sharedClient] getPath:urlString parameters:nil success:^(MMAFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *jsonData = [self parseJson:responseObject];
        NSMutableArray *audiences = [NSMutableArray arrayWithCapacity:0];
        
        
        if ([jsonData isRightKind])
        {
            if (![jsonData statusCodeOK])
            {
                completion(nil, [NSError errorMsg:[jsonData message]]);
                return;
            }
            
            NSArray *arr = [jsonData objectForKey:@"data"];
            [audiences addObjectsFromArray:arr];
            
            
            completion(audiences, nil);
            
            
        }
    } failure:^(MMAFHTTPRequestOperation *operation, NSError *error) {
        completion(nil, error);
    }];
}

@end
