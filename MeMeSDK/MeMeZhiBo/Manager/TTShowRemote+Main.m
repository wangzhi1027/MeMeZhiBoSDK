//
//  TTShowRemote+Main.m
//  memezhibo
//
//  Created by Xingai on 15/5/19.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "TTShowRemote+Main.h"
#import "TTShowMainImageList.h"


@implementation TTShowRemote (Main)

- (void)getRoomsWithURLString:(NSString *)urlString params:(NSDictionary *)params completion:(RemoteCompletionArray)completion
{
    [[MMAFAppDotNetAPIClient sharedClient] getPath:urlString parameters:params success:^(MMAFHTTPRequestOperation *operation, id JSON)
     {
         NSDictionary *jsonData = [self parseJson:JSON];
         
         NSArray *roomsArray = nil;
         if ([jsonData isRightKind])
         {
             if (![jsonData statusCodeOK])
             {
                 completion(nil, [NSError errorMsg:[jsonData message]]);
                 return;
             }
             roomsArray = [jsonData valueForKey:kRoomNodeName];
         }
         else
         {
         }
         
         NSMutableArray *mutableRooms = [NSMutableArray arrayWithCapacity:[roomsArray count]];
         
         for (NSDictionary *attributes in roomsArray)
         {
             TTShowRoom *room = [[TTShowRoom alloc] initWithAttributes:attributes];
             [mutableRooms addObject:room];
         }
         
         if (completion)
         {
             completion([NSArray arrayWithArray:mutableRooms], nil);
         }
     } failure:^(MMAFHTTPRequestOperation *operation, NSError *error) {
         if (completion)
         {
             completion([NSArray array], error);
         }
     }];
}


- (void)_retrieveRoomListWithParams:(NSDictionary *)params completion:(RemoteCompletionArray)completion
{
    NSString *roomListURLString = [self.baseURLStr stringByAppendingString:urlArray[retrieve_room_list_index]];
//    LOGINFO(@"roomListURLString = %@%@", roomListURLString,params);
    
    [self getRoomsWithURLString:roomListURLString params:params completion:completion];
}

-(void)_retrieveTheHallimage:(RemoteCompletionArray)completion
{
    NSString *urlString = [self.baseURLStr stringByAppendingString:urlArray[retrieve_poster_index]];
    [[MMAFAppDotNetAPIClient sharedClient] getPath:urlString parameters:nil success:^(MMAFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *jsonData = [self parseJson:responseObject];
        
        NSMutableArray *commendationList = [NSMutableArray arrayWithCapacity:0];

        if ([jsonData isRightKind])
        {
            if (![jsonData statusCodeOK])
            {
                completion(nil, [NSError errorMsg:[jsonData message]]);
                return;
            }
            
            // ...
            
            NSArray *data = [jsonData valueForKey:@"data"];
            
            for (NSDictionary *carDict in data)
            {
            
                TTShowMainImageList *recommendation = [[TTShowMainImageList alloc] initWithAttributes:carDict];
                [commendationList addObject:recommendation];
            }
            
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

@end
