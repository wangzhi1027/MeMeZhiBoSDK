//
//  TTShowRemote+ManageStar.m
//  memezhibo
//
//  Created by Xingai on 15/5/28.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "TTShowRemote+ManageStar.h"

@implementation TTShowRemote (ManageStar)

- (void)_manageStarListWithCompletion:(RemoteCompletionArray)completion
{
    NSString *access_token = [TTShowUser access_token];
    if (access_token == nil) {
        completion(nil, [NSError errorMsg:@"token 为空"]);
        return;
    }
    
    NSString *parameterString = [NSString stringWithFormat:urlArray[manage_star_list_index], access_token];
    NSString *urlString = [self.baseURLStr stringByAppendingString:parameterString];
    
    [[MMAFAppDotNetAPIClient sharedClient] getPath:urlString parameters:nil success:^(MMAFHTTPRequestOperation *operation, id responseObject)
     {
         NSMutableArray *starList = [NSMutableArray arrayWithCapacity:0];
         
         
         NSDictionary *jsonData = [self parseJson:responseObject];
         
         if ([jsonData isRightKind])
         {
             if (![jsonData statusCodeOK])
             {
                 completion(nil, [NSError errorMsg:[jsonData message]]);
                 return;
             }
             
             //             LOGINFO(@"jsonData = %@", jsonData);
             
             NSDictionary *dataDict = [jsonData valueForKey:kData];
             NSArray *userList = [dataDict valueForKey:@"users"];
             NSArray *roomList = [dataDict valueForKey:@"rooms"];
             
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
                 [starList addObject:roomStar];
             }
        
             
             if (completion)
             {
                 completion(starList, nil);
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
