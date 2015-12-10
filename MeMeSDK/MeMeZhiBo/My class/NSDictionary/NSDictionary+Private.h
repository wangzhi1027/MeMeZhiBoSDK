//
//  NSDictionary+Private.h
//  TTShow
//
//  Created by twb on 13-6-3.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Private)

/**************************************
 ************ Status Code *************
 **************************************/
- (NSInteger)statusCode;
- (BOOL)statusCodeOK;
- (NSString *)errorMessage;
- (BOOL)balanceIsNotEnough;
- (BOOL)authCodeRight;
- (BOOL)taskComplete;

/**************************************
 ************ Kind Check  *************
 **************************************/

- (BOOL)isRightKind;


/**************************************
 ************ Status Message **********
 **************************************/
- (NSString *)message;

/**************************************
 ************ Vistor Count   **********
 **************************************/

- (long long int)visitorCount;

/**************************************
 ************ Anchor Grade   **********
 **************************************/

- (long long int)currentBeanCount;
- (long long int)needBeanCountIfUpgrade;
- (NSInteger)anchorGrade;

/**************************************
 ************ Wealth Grade   **********
 **************************************/

- (long long int)currentCoinCount;
- (long long int)needCoinCountIfUpgrade;
- (NSInteger)wealthGrade;

/**************************************
 ************ Chat Room ***************
 **************************************/

- (NSString *)action;
- (NSInteger)car;
- (NSString *)nickName;
- (NSString *)nickNameFrom;
- (NSString *)nickNameTo;
- (NSInteger)priv;
- (long long int)spend;
- (NSString *)content;

- (BOOL)chatPrivate;
- (NSUInteger)roomChangeUserID;
- (NSUInteger)fromID;
- (NSUInteger)toID;

// System Notice.
- (NSString *)noticeContent;
- (NSString *)noticeUrl;

// puzzle
- (NSString *)puzzlePic;
- (NSString *)puzzleMsg;
- (NSInteger)puzzleSecond;
- (NSInteger)puzzleX;
- (NSInteger)puzzleY;
- (NSInteger)puzzleCost;
- (NSInteger)puzzleStep;
- (NSInteger)puzzleUserID;
- (NSString *)puzzleNick;

// Broadcast
- (NSString *)broadcastFromNickName;
- (NSInteger)broadcastFromID;
- (NSString *)broadcastMessage;
- (NSInteger)broadcastRoomID;
- (NSString *)broadcastRoomStar;
- (BOOL)broadcastUrl;

// Live Status.
- (BOOL)live;

/*
 * Pic Join.............
 */
- (NSInteger)enterRoomVip;
- (BOOL)enterRoomVipHiding;
- (NSInteger)fromLevel;
- (NSInteger)fromPriv;
- (NSInteger)fromVip;
- (NSInteger)toLevel;
- (NSInteger)toPriv;
- (NSInteger)toVip;

// Shutup Or Kickout.
- (NSString *)stopNickNameFrom;
- (NSInteger)stopIDFrom;
- (NSString *)stopNickNameTo;
- (NSInteger)stopIDTo;
- (NSInteger)stopTime;

- (NSString *)access_token;
- (NSString *)access_token1;


// Send Gift
- (NSInteger)giftFromID;
- (NSString *)giftNickNameFrom;
- (NSInteger)giftToID;
- (NSString *)giftNickNameTo;
- (NSInteger)giftCount;
- (NSInteger)giftCoinPrice;
- (NSString *)giftPic;
- (NSString *)giftPicUrlString;
- (NSString *)giftName;
- (NSInteger)giftID;
- (NSInteger)featherFromID;
- (NSString *)featherNickNameFrom;

// User Head Pic
- (NSString *)user_pic_url;

// Join Chat Message.
+ (NSString *)getChatStringTarget:(TTShowChatTarget *)target Private:(BOOL)_private Content:(NSString *)content;
+ (NSDictionary *)getChatJsonTarget:(TTShowChatTarget *)target Private:(BOOL)_private Content:(NSString *)content;
+ (NSDictionary *)getChatJson:(NSString *)content;
+ (NSString *)getChatString:(NSString *)content;

/**************************************
 ************ Room Star ***************
 **************************************/
- (NSUInteger)roomStarID;
- (NSString *)roomStarNickName;
- (NSString *)roomStarPic;
- (NSUInteger)roomStarBeanTotalCount;
- (NSUInteger)roomStarCoinSpendTotal;
- (NSUInteger)roomStarFeatherReceiveTotal;
- (NSUInteger)roomStarRoomID;
- (NSUInteger)roomStarDayRank;

@end
