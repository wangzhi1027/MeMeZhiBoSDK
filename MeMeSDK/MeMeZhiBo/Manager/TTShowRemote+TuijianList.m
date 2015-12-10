//
//  TTShowRemote+TuijianList.m
//  memezhibo
//
//  Created by Xingai on 15/6/24.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "TTShowRemote+TuijianList.h"

@implementation TTShowRemote (TuijianList)

- (void)getTuijianWithPage:(NSString *)page completion:(RemoteCompletionArray)completion
{
    NSString *urlString = [self.baseURLStr stringByAppendingString:urlArray[tuijian_list]];
    
    [[MMAFAppDotNetAPIClient sharedClient] getPath:urlString parameters:nil success:^(MMAFHTTPRequestOperation *operation, id JSON)
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

- (void)getLishiWithPage:(NSString *)ids completion:(RemoteCompletionArray)completion
{
    if (ids==nil||[ids isEqualToString:@""]) {
        completion(nil,nil);
        return;
    }
    NSString *string = [NSString stringWithFormat:@"%@%@",urlArray[kanguo_list],ids];
    
    NSString *urlString = [self.baseURLStr stringByAppendingString:string];
    
    
    [[MMAFAppDotNetAPIClient sharedClient] getPath:urlString parameters:nil success:^(MMAFHTTPRequestOperation *operation, id JSON)
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

@end
