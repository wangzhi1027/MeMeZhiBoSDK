//
//  TTShowDefaults.h
//  TTShow
//
//  Created by twb on 13-6-28.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTShowFollowStar.h"
#import "TTShowGift.h"

@class TTShowGift;

@interface TTShowDefaults : NSObject

// NickName Cache.
@property (nonatomic, strong) NSString *nickNameCache;
@property (nonatomic, strong) NSString *nickNameCacheCopy;
@property (nonatomic, assign) NSInteger featherCount;

@property (nonatomic, assign) BOOL firstLaunch;
@property (nonatomic, assign) BOOL showAgreement;

- (NSArray *)giftList;
- (void)saveGiftList:(NSArray *)gifts;
- (TTShowGift *)getGiftFromID:(NSInteger)giftID;

- (NSArray *)followStarList;
- (void)clearFollowStarList;
- (BOOL)hasFollowStar:(NSInteger)star_id;
- (void)addFollowStar:(NSUInteger)star_id;
- (void)delFollowStar:(NSUInteger)star_id;

// Feather Action
- (void)featherIncrease;
- (void)featherDecrease;
- (void)clearFeatherRecords;

- (BOOL)isMeFromChatNick:(NSString *)nick;

// Recently watch star list
- (NSArray *)recentlyWatchList;
- (void)addRecentlyWatch:(TTShowFollowRoomStar *)star;

@end
