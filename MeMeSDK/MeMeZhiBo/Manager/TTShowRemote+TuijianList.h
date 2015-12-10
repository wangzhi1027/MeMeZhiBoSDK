//
//  TTShowRemote+TuijianList.h
//  memezhibo
//
//  Created by Xingai on 15/6/24.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "TTShowRemote.h"

@interface TTShowRemote (TuijianList)

- (void)getTuijianWithPage:(NSString *)page completion:(RemoteCompletionArray)completion;

- (void)getLishiWithPage:(NSString *)ids completion:(RemoteCompletionArray)completion;

@end
