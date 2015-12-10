//
//  RoomVideoViewController+UserPanel.h
//  memezhibo
//
//  Created by Xingai on 15/6/15.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "RoomVideoViewController.h"

@interface RoomVideoViewController (UserPanel)<UserpanelDelegate>

- (void)doSelectUserPanel:(NSInteger)userID vipHiding:(BOOL)isVipHidding;

@end
