//
//  TTShowRemote+JuwanLogin.h
//  MeMeZhiBo
//
//  Created by XIN on 15/11/25.
//  Copyright (c) 2015年 XIN. All rights reserved.
//

#import "TTShowRemote.h"
#import "TheHallViewController.h"

@interface TTShowRemote (JuwanLogin)

- (void)retrieveJuwanLoginStatusWithToken:(NSString *)_id success:(void(^)(NSData *data))finishBlock failed:(void(^)(NSError *error))failedBlock;

@end
