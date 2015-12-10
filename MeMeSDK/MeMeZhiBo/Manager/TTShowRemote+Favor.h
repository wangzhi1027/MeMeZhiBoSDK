//
//  TTShowRemote+Favor.h
//  TTShow
//
//  Created by twb on 13-10-11.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import "TTShowRemote.h"

@interface TTShowRemote (Favor)

- (void)_followingForStar:(NSUInteger)star_id add:(BOOL)isAdd completion:(RemoteCompletionBool)completion;
- (void)_followingListWithCompletion:(RemoteCompletionArray)completion;

@end
