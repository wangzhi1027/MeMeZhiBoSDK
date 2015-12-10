//
//  TTShowRemote+Live.h
//  memezhibo
//
//  Created by Xingai on 15/5/19.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "TTShowRemote.h"

@interface TTShowRemote (Live)

- (void)_retrieveTTL:(RoomTTLType)type room:(NSUInteger)roomID completion:(RemoteCompletionInteger)completion;

- (void)_retrieveRoomStar:(NSUInteger)roomID WithBlock:(void (^)(TTShowRoomStar *roomStar, NSError *error))block;

- (void)_retrieveRoomManagers:(NSUInteger)roomID completion:(RemoteCompletionArray)completion;

- (void)_retrieveVideoUrl:(NSInteger)roomID completion:(RemoteCompletionString)completion;

- (void)retrieveAudienceList:(NSInteger)roomID page:(NSInteger)page size:(NSInteger)size completion:(RemoteCompletionArrayInteger)completion;

- (void)_sendBroadcast:(NSInteger)roomID content:(NSString *)c completion:(RemoteCompletionBool)completion;

- (void)_manageOrderShutup:(NSInteger)minute toUser:(NSInteger)userid inRoom:(NSInteger)roomid completion:(RemoteCompletionBool)completion;

- (void)_manageOrderRecoverUser:(NSInteger)userid inRoom:(NSInteger)roomid completion:(RemoteCompletionBool)completion;

- (void)remoteGuanjianziCompletion:(RemoteCompletionArray)completion;

- (void)remoteGuanjianziToCompletion:(RemoteCompletionArray)completion;

@end
