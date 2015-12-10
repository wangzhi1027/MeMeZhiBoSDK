//
//  TTShowRemote+Main.h
//  memezhibo
//
//  Created by Xingai on 15/5/19.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "TTShowRemote.h"

@interface TTShowRemote (Main)

- (void)_retrieveRoomListWithParams:(NSDictionary *)params completion:(RemoteCompletionArray)completion;

-(void)_retrieveTheHallimage:(RemoteCompletionArray)completion;

@end
