//
//  TTShowRemote+TheHall.m
//  memezhibo
//
//  Created by Xingai on 15/5/22.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "TTShowRemote+TheHall.h"
#import "TTShowRecommendation.h"

@implementation TTShowRemote (TheHall)

- (void)_recommendationList:(RemoteCompletionArray)completion
{
    NSString *urlString = [self.baseURLStr stringByAppendingString:urlArray[Anchor_recommendation]];
    [[MMAFAppDotNetAPIClient sharedClient] getPath:urlString parameters:nil success:^(MMAFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *jsonData = [self parseJson:responseObject];
        
        NSMutableArray *commendationList = [NSMutableArray arrayWithCapacity:0];
        
        NSDictionary *data = [jsonData valueForKey:@"data"];
        
        
        if ([data isRightKind])
        {
            if (![jsonData statusCodeOK])
            {
                completion(nil, [NSError errorMsg:[jsonData message]]);
                return;
            }
            
            // ...
            NSArray *recom = [data valueForKey:@"room_found_latest"];
            NSArray *family_room_list = [data valueForKey:@"family_room_list"];
            NSArray *nest_list = [data valueForKey:@"nest_list"];
            
            [commendationList addObject:recom];
            [commendationList addObject:family_room_list];
            [commendationList addObject:nest_list];
            
            if (completion)
            {
                completion(commendationList, nil);
            }
        }
        
    } failure:^(MMAFHTTPRequestOperation *operation, NSError *error) {
        
        
        if (completion)
        {
            completion(nil, error);
        }
    }];
}

- (void)remoteXinrenList:(RemoteCompletionArray)completion
{
    NSString *urlString = [self.baseURLStr stringByAppendingString:urlArray[youxiuXinren_list]];
    [[MMAFAppDotNetAPIClient sharedClient] getPath:urlString parameters:nil success:^(MMAFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *jsonData = [self parseJson:responseObject];
        
        
        NSArray *data = [jsonData valueForKey:@"data"];
        
        if ([data isKindOfClass:[NSArray class]])
        {
            if (![jsonData statusCodeOK])
            {
                completion(nil, [NSError errorMsg:[jsonData message]]);
                return;
            }
            
            // ...

            
            NSMutableArray *mutableRooms = [NSMutableArray arrayWithCapacity:0];
            
            for (NSDictionary *attributes in data)
            {
                TTShowRoom *room = [[TTShowRoom alloc] initWithAttributes:attributes];
                [mutableRooms addObject:room];
            }
            
            if (completion)
            {
                completion([NSArray arrayWithArray:mutableRooms], nil);
            }
        }
        
    } failure:^(MMAFHTTPRequestOperation *operation, NSError *error) {
        
        
        if (completion)
        {
            completion(nil, error);
        }
    }];
}


@end
