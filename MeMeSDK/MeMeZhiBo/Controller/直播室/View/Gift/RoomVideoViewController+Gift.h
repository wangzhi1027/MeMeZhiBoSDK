//
//  RoomVideoViewController+Gift.h
//  memezhibo
//
//  Created by Xingai on 15/6/12.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "RoomVideoViewController.h"

@interface RoomVideoViewController (Gift)<RoomGitfDelegate>

- (void)setupGiftListView;
- (void)setupGiftReceiverID:(NSInteger)receiverID;
- (void)setupGiftReceiver:(NSString *)receiver;

@end
