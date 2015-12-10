//
//  RoomVideoViewController+ChatField.h
//  TTShow
//
//  Created by twb on 13-7-3.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import "RoomVideoViewController.h"

@interface RoomVideoViewController (ChatField)

- (NSString *)action:(NSDictionary *)jsonData;

#pragma mark - Chat Field Information part.

- (NSString *)chatContent:(NSDictionary *)jsonData;
- (NSString *)chatNickName:(NSDictionary *)jsonData;
- (NSString *)chatFromNickName:(NSDictionary *)jsonData;
- (NSString *)chatToNickName:(NSDictionary *)jsonData;
- (NSUInteger)chatFromUserID:(NSDictionary *)jsonData;
- (NSUInteger)chatToUserID:(NSDictionary *)jsonData;
- (NSInteger)enterPriv:(NSDictionary *)jsonData;
- (long long int)enterSpend:(NSDictionary *)json;
- (BOOL)chatIsPrivate:(NSDictionary *)jsonData;

#pragma mark - Enter Room Part.

- (NSInteger)enterRoomVipType:(NSDictionary *)jsonData;
- (BOOL)enterRoomVipHiding:(NSDictionary *)jsonData;
- (NSString *)enterRoomNickName:(NSDictionary *)jsonData;
- (NSString *)carPicUrl:(NSDictionary *)jsonData;
- (NSString *)carName:(NSDictionary *)json;
- (BOOL)isFamousCar:(NSDictionary *)json;
- (NSUInteger)enterRoomUserID:(NSDictionary *)jsonData;

#pragma mark - Shutup part.

- (NSString *)stopNickNameFrom:(NSDictionary *)jsonData;
- (NSInteger)stopIDFrom:(NSDictionary *)jsonData;
- (NSString *)stopNickNameTo:(NSDictionary *)jsonData;
- (NSInteger)stopIDTo:(NSDictionary *)jsonData;
- (NSInteger)stopTime:(NSDictionary *)jsonData;

#pragma mark - Room Star Part.

- (NSString *)roomStarNickName:(NSDictionary *)jsonData;
- (NSUInteger)roomStarUserID:(NSDictionary *)jsonData;
- (long long int)roomStarBeanTotalCount:(NSDictionary *)json;

#pragma mark - Room Show User Pic.

- (NSInteger)roomFromLevel:(NSDictionary *)jsonData;
- (BOOL)roomFromAdmin:(NSDictionary *)jsonData;
- (BOOL)roomFromSpentMost:(NSDictionary *)jsonData;
- (BOOL)roomFromStar:(NSDictionary *)jsonData;
- (NSInteger)roomFromPriv:(NSDictionary *)jsonData;
- (NSInteger)roomFromVip:(NSDictionary *)jsonData;
- (NSInteger)roomToLevel:(NSDictionary *)jsonData;
- (BOOL)roomToAdmin:(NSDictionary *)jsonData;
- (BOOL)roomToSpentMost:(NSDictionary *)jsonData;
- (BOOL)oneSpentMost:(NSInteger)_id;
- (BOOL)roomToStar:(NSDictionary *)jsonData;
- (NSInteger)roomToPriv:(NSDictionary *)jsonData;
- (NSInteger)roomToVip:(NSDictionary *)jsonData;
- (BOOL)roomOneHasFlames:(NSInteger)_id;
- (BOOL)roomOneIsAdmin:(NSInteger)_id;
- (BOOL)roomOneIsStar:(NSInteger)_id;


#pragma mark - puzzle part.
// puzzle
- (NSString *)puzzlePic:(NSDictionary *)json;
- (NSString *)puzzleMsg:(NSDictionary *)json;
- (NSInteger)puzzleSecond:(NSDictionary *)json;
- (NSInteger)puzzleX:(NSDictionary *)json;
- (NSInteger)puzzleY:(NSDictionary *)json;
- (NSInteger)puzzleCost:(NSDictionary *)json;
- (NSInteger)puzzleStep:(NSDictionary *)json;
- (NSInteger)puzzleUserID:(NSDictionary *)json;
- (NSString *)puzzleNick:(NSDictionary *)json;

/*
 * Send Gift
 */
- (NSInteger)giftFromID:(NSDictionary *)json;
- (NSString *)giftFromNickName:(NSDictionary *)json;
- (NSInteger)giftToID:(NSDictionary *)json;
- (NSString *)giftToNickName:(NSDictionary *)json;
- (NSInteger)giftCount:(NSDictionary *)json;
- (NSInteger)giftCoinPrice:(NSDictionary *)json;
- (NSString *)giftPic:(NSDictionary *)json;
- (NSInteger)giftID:(NSDictionary *)json;
- (NSString *)giftPicUrl:(NSInteger)_id;
- (NSString *)giftPicGif:(NSInteger)_id;
- (NSString *)giftName:(NSInteger)_id;
- (NSInteger)featherFromID:(NSDictionary *)json;
- (NSString *)featherFromNickName:(NSDictionary *)json;


// System Notice.
- (NSString *)noticeContent:(NSDictionary *)json;
- (NSString *)noticeUrl:(NSDictionary *)json;

// Broadcast.
- (NSString *)broadcastFromNickName:(NSDictionary *)json;
- (NSInteger)broadcastFromID:(NSDictionary *)json;
- (NSString *)broadcastMessage:(NSDictionary *)json;
- (NSInteger)broadcastRoomID:(NSDictionary *)json;
- (NSString *)broadcastRoomStar:(NSDictionary *)json;
- (BOOL)broadcastUrl:(NSDictionary *)json;

// Live Status.
- (BOOL)live:(NSDictionary *)json;

// Tag Gift.
- (NSDictionary *)filterTagGift;
- (NSArray *)tagGifts;

// Combine text dictionary
- (NSDictionary *)carEnterDictionary:(BOOL)car json:(NSDictionary*)json;
- (NSDictionary *)chatText:(NSString *)content size:(CGFloat)size color:(ChatRoomFontColorMode)color;
- (NSDictionary *)chatText:(NSString *)content size:(CGFloat)size color:(ChatRoomFontColorMode)color withUnderLine:(BOOL)underline;
// Combine pic dictionary
- (NSDictionary *)spentMostDictionary;
- (NSDictionary *)starDictionary;
- (NSDictionary *)wealthLevelDictionary:(NSInteger)levelCount;
- (NSDictionary *)starLevelDictionary:(NSInteger)levelCount;
- (NSDictionary *)adminDictionary;
- (NSDictionary *)agentDictionary;
- (NSDictionary *)businessDictionary;
- (NSDictionary *)cServiceDictionary;
- (NSDictionary *)trialVipDictionary;
- (NSDictionary *)vipDictionary;
- (NSDictionary *)vipExtremeDictionary;
- (NSDictionary *)flameDictionary;
- (NSDictionary *)carDictionary:(NSString *)imageUrlString;
- (NSDictionary *)giftDictionary:(NSString *)imageUrlString;
- (NSDictionary *)featherDictionary;

@end
