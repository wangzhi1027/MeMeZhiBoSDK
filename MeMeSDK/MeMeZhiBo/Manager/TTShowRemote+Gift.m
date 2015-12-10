//
//  TTShowRemote+Gift.m
//  TTShow
//
//  Created by twb on 13-10-11.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import "TTShowRemote+Gift.h"
#import "MMAFAppDotNetAPIClient.h"
#import "MMAFHTTPRequestOperation.h"
#import "TTShowUser.h"
#import "TTShowTodaySpecialGift.h"

@implementation TTShowRemote (Gift)

// Gift List
- (void)retrieveGiftListWithCompeletion:(RemoteCompletionDoubleArray)completion
{
    // retrieve_rooms_index
    NSString *fullURL = [self.baseURLStr stringByAppendingString:urlArray[retrieve_gift_list_index]];
    
    [[MMAFAppDotNetAPIClient sharedClient] getPath:fullURL parameters:nil
     success:^(MMAFHTTPRequestOperation *operation, id responseObject)
     {
         NSDictionary *jsonData = [self parseJson:responseObject];
         
         NSArray *categories = nil;
         NSArray *gifts = nil;
         
         if ([jsonData isRightKind])
         {
             if (![jsonData statusCodeOK])
             {
                 completion(nil, nil, [NSError errorMsg:[jsonData message]]);
                 return;
             }
             
             //             LOGINFO(@"Gifts Json = %@", jsonData);
             
             NSDictionary *giftsDictionary = [jsonData valueForKey:kGiftCollectionNodeName];
             
             categories = [giftsDictionary valueForKey:kGiftCategoryNodeName];
             gifts = [giftsDictionary valueForKey:kGiftsNodeName];
             
             
         }
         else
         {
         }
         
         if (completion)
         {
             completion(categories, gifts, nil);
         }
         
     }
     failure:^(MMAFHTTPRequestOperation *operation, NSError *error)
     {
         if (completion)
         {
             completion(nil ,nil, error);
         }
     }];
}

- (void)sendFortune:(NSInteger)roomId count:(NSInteger)count successBlock:(SuccessBlock)successBlock failBlock:(FailBlock)failBlock
{
    NSString *access_token = [TTShowUser access_token];
    if ([TTShowUser access_token] == nil)
    {
        if (failBlock)
        {
            failBlock([NSError errorMsg:@"需重新登录"]);
        }
        return;
    }
    NSString *paramString = [NSString stringWithFormat:urlArray[send_fortune_index], access_token, roomId, count];
    NSString *fullURL = [self.baseURLStr stringByAppendingString:paramString];
    [HttpUtils executeGetMethodWithUrl:fullURL params:nil successBlock:^(NSDictionary *dict) {
        if (successBlock) {
            successBlock(dict);
        }
    } failBlock:^(NSError *error) {
        if (failBlock) {
            failBlock(error);
        }
    }];
}

- (void)sendBagGift:(NSInteger)roomId giftId:(NSInteger)giftId userId:(NSInteger)userId count:(NSInteger)count successBlock:(SuccessBlock)successBlock failBlock:(FailBlock)failBlock
{
    NSString *access_token = [TTShowUser access_token];
    if ([TTShowUser access_token] == nil)
    {
        if (failBlock)
        {
            failBlock([NSError errorMsg:@"需重新登录"]);
        }
        return;
    }
    NSString *paramString = [NSString stringWithFormat:urlArray[send_bag_gift_index], access_token, roomId, giftId, count, userId];
    NSString *fullURL = [self.baseURLStr stringByAppendingString:paramString];
    [HttpUtils executeGetMethodWithUrl:fullURL params:nil successBlock:^(NSDictionary *dict) {

        if (successBlock) {
            successBlock(dict);
        }
    } failBlock:^(NSError *error) {
        if (failBlock) {
            failBlock(error);
        }
    }];
}

- (void)_sendGiftWithParam:(NSDictionary *)param completion:(RemoteCompletionBool)completion
{
    NSString *access_token = [TTShowUser access_token];
    if ([TTShowUser access_token] == nil)
    {
        if (completion)
        {
            completion(NO, [NSError errorMsg:@"需重新登录"]);
        }
        return;
    }
    
    NSUInteger room_id = [[param valueForKey:@"room_id"] unsignedIntegerValue];
    NSUInteger gift_id = [[param valueForKey:@"gift_id"] unsignedIntegerValue];
    NSUInteger count = [[param valueForKey:@"count"] unsignedIntegerValue];
    NSUInteger user_id = [[param valueForKey:@"user_id"] unsignedIntegerValue];
    
    NSString *paramString = [NSString stringWithFormat:urlArray[send_gift_index], access_token, room_id, gift_id, count, user_id];
    NSString *fullURL = [self.baseURLStr stringByAppendingString:paramString];
    
    
    [[MMAFAppDotNetAPIClient sharedClient] getPath:fullURL parameters:nil success:^(MMAFHTTPRequestOperation *operation, id responseObject) {
        
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
                    completion(NO, [NSError errorMsg:msg code:[jsonData statusCode]]);
                }
                return;
            }
        }
        else
        {
        }
        
        if (completion)
        {
            completion(YES, nil);
        }
        
    } failure:^(MMAFHTTPRequestOperation *operation, NSError *error) {
        if (completion)
        {
            completion(NO, error);
        }
    }];
    
}

// Yesterday Special Gift.
- (void)_retrieveYesterdaySpecialGift:(void (^)(TTShowSpecialGiftRank *specialGift, NSError *error))block
{
    NSString *urlString = [self.baseURLStr stringByAppendingString:urlArray[retrieve_yesterday_special_gift_index]];
    
    [[MMAFAppDotNetAPIClient sharedClient] getPath:urlString parameters:nil success:^(MMAFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *jsonData = [self parseJson:responseObject];
        TTShowSpecialGiftRank *specialGift = nil;
        
        if ([jsonData isRightKind])
        {
            if (![jsonData statusCodeOK])
            {
                block(nil, [NSError errorMsg:[jsonData message]]);
                return;
            }
            
            NSDictionary *specialGiftDict = [jsonData valueForKey:@"data"];
            specialGift = [[TTShowSpecialGiftRank alloc] initWithAttributes:specialGiftDict];
            
            block(specialGift, nil);
        }
        
    } failure:^(MMAFHTTPRequestOperation *operation, NSError *error) {
        block(nil, error);
    }];
}

// Today Special Gift
- (void)_retrieveTodaySpecialGift:(NSInteger)roomID block:(void (^)(TTShowTodaySpecialGift *today, NSError *error))block
{
    NSString *param = [NSString stringWithFormat:urlArray[retrieve_today_special_gift_index], roomID];
    NSString *urlString = [self.baseURLStr stringByAppendingString:param];
    
    [[MMAFAppDotNetAPIClient sharedClient] getPath:urlString parameters:nil success:^(MMAFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *jsonData = [self parseJson:responseObject];
        TTShowTodaySpecialGift *specialGift = nil;
        
        if ([jsonData isRightKind])
        {
            if (![jsonData statusCodeOK])
            {
                block(nil, [NSError errorMsg:[jsonData message]]);
                return;
            }
            
            specialGift = [[TTShowTodaySpecialGift alloc] initWithAttributes:jsonData];
            
            block(specialGift, nil);
        }
        
    } failure:^(MMAFHTTPRequestOperation *operation, NSError *error) {
        block(nil, error);
    }];
}

- (void)_sendFortune:(NSInteger)roomId count:(NSInteger)count successBlock:(SuccessBlock)successBlock failBlock:(FailBlock)failBlock
{
    NSString *access_token = [TTShowUser access_token];
    if ([TTShowUser access_token] == nil)
    {
        if (failBlock)
        {
            failBlock([NSError errorMsg:@"需重新登录"]);
        }
        return;
    }
    NSString *paramString = [NSString stringWithFormat:urlArray[send_fortune_index], access_token, roomId, count];
    NSString *fullURL = [self.baseURLStr stringByAppendingString:paramString];
    [HttpUtils executeGetMethodWithUrl:fullURL params:nil successBlock:^(NSDictionary *dict) {
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
