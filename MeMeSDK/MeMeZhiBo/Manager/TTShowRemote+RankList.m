//
//  TTShowRemote+RankList.m
//  memezhibo
//
//  Created by Xingai on 15/5/20.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "TTShowRemote+RankList.h"
#import "TTShowUserRank.h"
#import "TTShowAnchorRank.h"
#import "TTShowGiftRank.h"
#import "TTShowSpecialGiftRank.h"

@implementation TTShowRemote (RankList)

- (void)_retrieveUserRank:(UserRankType)type Room:(NSUInteger)roomID Size:(NSUInteger)size completion:(RemoteCompletionArray)completion
{
    // retrieve_room_user_rank_index
    // /rank/room_user_%@/%d?size=%d
    NSString *rankType = nil;
    switch (type)
    {
        case kUserRankLive:
            rankType = @"live";
            break;
        case kUserRankMonth:
            rankType = @"month";
            break;
        case kUserRankTotal:
            rankType = @"total";
            break;
        default:
            break;
    }
    
    NSString *paramString = [NSString stringWithFormat:urlArray[retrieve_room_user_rank_index], rankType, roomID, size];
    NSString *fullURL = [self.baseURLStr stringByAppendingString:paramString];
    
    [[MMAFAppDotNetAPIClient sharedClient] getPath:fullURL parameters:nil success:^(MMAFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *jsonData = [self parseJson:responseObject];
        
        NSMutableArray *userRankResults = [NSMutableArray arrayWithCapacity:0];
        if ([jsonData isRightKind])
        {
            if (![jsonData statusCodeOK])
            {
                completion(nil, [NSError errorMsg:[jsonData message]]);
                return;
            }
            
            NSArray *userRanks = [jsonData valueForKey:kRoomUserRankNodeName];
            
            for (NSUInteger i = 0; i < [userRanks count]; i++)
            {
                NSDictionary *userRankDict = userRanks[i];
                TTShowUserRank *userRank = [[TTShowUserRank alloc] initWithAttributes:userRankDict];
                [userRankResults addObject:userRank];
            }
        }
        else
        {
            completion(nil, [NSError errorMsg:[jsonData message]]);
            return;
        }
        
        if (completion)
        {
            completion(userRankResults, nil);
        }
    } failure:^(MMAFHTTPRequestOperation *operation, NSError *error) {
        if (completion)
        {
            completion(nil, error);
        }
    }];
}

- (void)_retrieveAnchorRank:(AnchorRankMainType)main subType:(RichRankType)sub size:(NSUInteger)size completion:(RemoteCompletionArray)completion
{
    NSString *urlString = nil;
    NSString *subTypeString = nil;
    switch (main)
    {
        case kAnchorStarRank:
            urlString = urlArray[retrieve_star_rank_index];
            break;
        case kAnchorSongRank:
            urlString = urlArray[retrieve_song_rank_index];
            break;
        case kAnchorFeatherRank:
            urlString = urlArray[retrieve_feather_rank_index];
            break;
        default:
            break;
    }
    
    switch (sub)
    {
        case kAnchorDayRank:
            subTypeString = @"day";
            break;
        case kAnchorWeekRank:
            subTypeString = @"week";
            break;
        case kAnchorMonthRank:
            subTypeString = @"month";
            break;
        case kAnchorTotalRank:
            subTypeString = @"total";
            break;
        default:
            break;
    }
    
    NSString *parameterString = [NSString stringWithFormat:urlString, subTypeString, size];
    NSString *anchorUrlString = [self.baseURLStr stringByAppendingString:parameterString];
    
    
    [[MMAFAppDotNetAPIClient sharedClient] getPath:anchorUrlString parameters:nil success:^(MMAFHTTPRequestOperation *operation, id responseObject)
     {
         NSDictionary *jsonData = [self parseJson:responseObject];
         
         
         NSMutableArray *anchorListArray = [NSMutableArray arrayWithCapacity:0];
         
         if ([jsonData isRightKind])
         {
             if (![jsonData statusCodeOK])
             {
                 completion(nil, [NSError errorMsg:[jsonData message]]);
                 return;
             }
             
             NSArray *archorList = [jsonData valueForKey:kAnchorRankNodeName];
                          
             for (NSDictionary *dict in archorList)
             {
                 TTShowAnchorRank *anchorRank = [[TTShowAnchorRank alloc] initWithAttributes:dict];
                 [anchorListArray addObject:anchorRank];
             }
             
             if (completion)
             {
                 completion(anchorListArray, nil);
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

// This/Last Week Gift
- (void)_retrieveGiftRank:(GiftSubRankType)type size:(NSUInteger)size completion:(RemoteCompletionArray)completion
{
    NSString *parameterString = nil;
    NSString *parseNodeName = nil;
    NSString *dynamicBaseUrlStr = nil;
    switch (type)
    {
        case kGiftThisWeekRank:
            parseNodeName = kGiftRankThisWeekNodeName;
            parameterString = [NSString stringWithFormat:urlArray[retrieve_gift_this_week_rank_index], size];
            dynamicBaseUrlStr = self.baseURLStr;
            break;
        case kGiftLastWeekRank:
            parseNodeName = kGiftRankLastWeekNodeName;
            parameterString = urlArray[retrieve_gift_last_week_rank_index];
            // This place's design pattern is very bad. URL must be same.
            dynamicBaseUrlStr = self.dataManager.filter.testModeOn ? kLastWeekBaseURLTest : kLastWeekBaseURL;
            break;
        default:
            break;
    }
    
    NSString *giftUrlString = [dynamicBaseUrlStr stringByAppendingString:parameterString];
    
    [[MMAFAppDotNetAPIClient sharedClient] getPath:giftUrlString parameters:nil success:^(MMAFHTTPRequestOperation *operation, id responseObject)
     {
         NSMutableArray *giftRanks = [NSMutableArray arrayWithCapacity:0];
         
         NSDictionary *jsonData = [self parseJson:responseObject];
         
         if ([jsonData isRightKind])
         {
             if (![jsonData statusCodeOK])
             {
                 completion(nil, [NSError errorMsg:[jsonData message]]);
                 return;
             }
             
             NSArray *ranks = [jsonData valueForKey:parseNodeName];
             
             for (NSDictionary *userDict in ranks)
             {
                 TTShowGiftRank *rank = [[TTShowGiftRank alloc] initWithAttributes:userDict];
                 [giftRanks addObject:rank];
             }
             
             if (completion)
             {
                 completion(giftRanks, nil);
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

- (void)_retrieveSpecialGiftRank:(RemoteCompletionArray)completion
{
    NSString *parameterString = [NSString stringWithFormat:urlArray[retrieve_gift_special_history_index], 0, 7];
    NSString *giftUrlString = [self.baseURLStr stringByAppendingString:parameterString];
    
    
    [[MMAFAppDotNetAPIClient sharedClient] getPath:giftUrlString parameters:nil success:^(MMAFHTTPRequestOperation *operation, id responseObject)
     {
         NSMutableArray *giftRanks = [NSMutableArray arrayWithCapacity:0];
         
         NSDictionary *jsonData = [self parseJson:responseObject];
         
         
         if ([jsonData isRightKind])
         {
             if (![jsonData statusCodeOK])
             {
                 completion(nil, [NSError errorMsg:[jsonData message]]);
                 return;
             }
             
             NSArray *ranks = [jsonData valueForKey:kSpecialGiftNodeName];
             
             for (NSDictionary *userDict in ranks)
             {
                 TTShowSpecialGiftRank *rank = [[TTShowSpecialGiftRank alloc] initWithAttributes:userDict];
                 [giftRanks addObject:rank];
             }
             
             if (completion)
             {
                 completion(giftRanks, nil);
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

// Rich List
- (void)_retrieveRichRank:(RichRankType)type size:(NSUInteger)size completion:(RemoteCompletionArray)completion
{
    // retrieve_rich_rank_index
    NSString *typeString = nil;
    
    switch (type)
    {
        case kAnchorDayRank:
            typeString = @"day";
            break;
        case kAnchorWeekRank:
            typeString = @"week";
            break;
        case kAnchorMonthRank:
            typeString = @"month";
            break;
        case kAnchorTotalRank:
            typeString = @"total";
            break;
        default:
            break;
    }
    
    NSString *parameterString = [NSString stringWithFormat:urlArray[retrieve_rich_rank_index], typeString, size];
    NSString *richUrlString = [self.baseURLStr stringByAppendingString:parameterString];
    
    
    [[MMAFAppDotNetAPIClient sharedClient] getPath:richUrlString parameters:nil success:^(MMAFHTTPRequestOperation *operation, id responseObject)
     {
         NSMutableArray *users = [NSMutableArray arrayWithCapacity:0];
         
         NSDictionary *jsonData = [self parseJson:responseObject];
         
         if ([jsonData isRightKind])
         {
             if (![jsonData statusCodeOK])
             {
                 completion(nil, [NSError errorMsg:[jsonData message]]);
                 return;
             }
             
             NSArray *userList = [jsonData valueForKey:kRichRankNodeName];
             
             for (NSDictionary *userDict in userList)
             {
                 TTShowUserRank *userRank = [[TTShowUserRank alloc] initWithAttributes:userDict];
                 [users addObject:userRank];
             }
             
             if (completion)
             {
                 completion(users, nil);
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


@end
