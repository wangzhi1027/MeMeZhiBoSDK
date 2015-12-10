//
//  TTShowRemote+Favor.m
//  TTShow
//
//  Created by twb on 13-10-11.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import "TTShowRemote+Favor.h"
#import "TTShowUser.h"
#import "TTShowFollowStar.h"

@implementation TTShowRemote (Favor)



- (void)_followingForStar:(NSUInteger)star_id add:(BOOL)isAdd completion:(RemoteCompletionBool)completion
{
    NSString *access_token = [TTShowUser access_token];
    if ([TTShowUser access_token] == nil)
    {
        completion(NO, [NSError errorMsg:@"Token 为空"]);
        return;
    }
    
    NSString *urlString = nil;
    
    if (isAdd)
    {
        urlString = urlArray[add_following_index];
    }
    else
    {
        urlString = urlArray[del_following_index];
    }
    
    NSString *parameterString = [NSString stringWithFormat:urlString, access_token, star_id];
    NSString *followUrlString = [self.baseURLStr stringByAppendingString:parameterString];
    
    //    LOGINFO(@"urlString = %@", urlString);
    
    [[MMAFAppDotNetAPIClient sharedClient] getPath:followUrlString parameters:nil success:^(MMAFHTTPRequestOperation *operation, id responseObject)
     {
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
         }
         
     } failure:^(MMAFHTTPRequestOperation *operation, NSError *error) {
         if (completion)
         {
             completion(NO, error);
         }
     }];
}

- (void)_followingListWithCompletion:(RemoteCompletionArray)completion
{
    NSString *access_token = [TTShowUser access_token];
    if ([TTShowUser access_token] == nil)
    {
        completion(nil, [NSError errorMsg:@"token 为空"]);
        return;
    }
    
    NSString *parameterString = [NSString stringWithFormat:urlArray[following_list_index], access_token];
    NSString *followlistUrlString = [self.baseURLStr stringByAppendingString:parameterString];
    
    [[MMAFAppDotNetAPIClient sharedClient] getPath:followlistUrlString parameters:nil success:^(MMAFHTTPRequestOperation *operation, id responseObject)
     {
         NSMutableArray *roomStarList = [NSMutableArray arrayWithCapacity:0];
         
         NSDictionary *jsonData = [self parseJson:responseObject];
         
         
         
         if ([jsonData isRightKind])
         {
             if (![jsonData statusCodeOK])
             {
                 completion(nil, [NSError errorMsg:[jsonData message]]);
                 return;
             }
                          
             NSDictionary *followListDict = [jsonData valueForKey:kFollowListNodeName];
             NSArray *userList = [followListDict valueForKey:@"users"];
             NSArray *roomList = [followListDict valueForKey:@"rooms"];
             
             NSSortDescriptor *sortByOrder = [NSSortDescriptor sortDescriptorWithKey:@"_id" ascending:YES];
             
             NSArray *resultUsers = [userList sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortByOrder]];
             NSArray *resultRooms = [roomList sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortByOrder]];
             
             
             for (NSInteger i = 0; i < resultUsers.count; i++)
             {
                 NSDictionary *userDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                           resultUsers[i], @"user",
                                           resultRooms[i], @"room",
                                           nil];
                 
                 TTShowFollowRoomStar *roomStar = [[TTShowFollowRoomStar alloc] initWithAttributes:userDict];
                 [roomStarList addObject:roomStar];
             }
             
             if (completion)
             {
                 completion(roomStarList, nil);
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
