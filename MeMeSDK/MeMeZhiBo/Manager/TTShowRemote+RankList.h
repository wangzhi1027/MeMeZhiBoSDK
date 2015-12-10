//
//  TTShowRemote+RankList.h
//  memezhibo
//
//  Created by Xingai on 15/5/20.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "TTShowRemote.h"

#define kLastWeekBaseURL @"http://www.imeme.tv"
#define kLastWeekBaseURLTest @"http://test.imeme.tv"

@interface TTShowRemote (RankList)

- (void)_retrieveUserRank:(UserRankType)type Room:(NSUInteger)roomID Size:(NSUInteger)size completion:(RemoteCompletionArray)completion;

- (void)_retrieveAnchorRank:(AnchorRankMainType)main subType:(RichRankType)sub size:(NSUInteger)size completion:(RemoteCompletionArray)completion;

- (void)_retrieveGiftRank:(GiftSubRankType)type size:(NSUInteger)size completion:(RemoteCompletionArray)completion;

- (void)_retrieveSpecialGiftRank:(RemoteCompletionArray)completion;

- (void)_retrieveRichRank:(RichRankType)type size:(NSUInteger)size completion:(RemoteCompletionArray)completion;

@end
