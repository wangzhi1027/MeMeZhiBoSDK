//
//  NSDictionary+Private.m
//  TTShow
//
//  Created by twb on 13-6-3.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import "NSDictionary+Private.h"
#import "NSObject+SBJSON.h"
#import "TTShowUser.h"

@implementation NSDictionary (Private)

/**************************************
 ************ Status Code *************
 **************************************/

- (NSInteger)statusCode
{
    return [[self valueForKey:@"code"] integerValue];
}

- (BOOL)statusCodeOK
{
    return [[self valueForKey:@"code"] integerValue] == 1;
}

- (NSString *)errorMessage
{
    return [self valueForKey:@"msg"];
}

- (BOOL)balanceIsNotEnough
{
    return [[self valueForKey:@"code"] integerValue] == 30412;
}

- (BOOL)authCodeRight
{
    return [[self valueForKey:@"code"] integerValue] != 30419;
}

- (BOOL)taskComplete
{
    return [[self valueForKey:@"code"] integerValue] != 30417;
}

/**************************************
 ************ Kind Check  *************
 **************************************/

- (BOOL)isRightKind
{
    return [self isKindOfClass:[NSDictionary class]];
}

/**************************************
 ************ Status Message **********
 **************************************/

- (NSString *)message
{
    return [self valueForKey:@"msg"];
}

/**************************************
 ************ Vistor Count   **********
 **************************************/

- (long long int)visitorCount
{
    return [[self valueForKey:@"count"] longLongValue];
}

/**************************************
 ************ Anchor Grade   **********
 **************************************/

- (long long int)currentBeanCount
{
    return [[self valueForKey:@"CurrentBeanCount"] longLongValue];
}

- (long long int)needBeanCountIfUpgrade
{
    return [[self valueForKey:@"NeedBeanCountIfUpgrade"] longLongValue];
}

- (NSInteger)anchorGrade
{
    return [[self valueForKey:@"AnchorGrade"] integerValue];
}

/**************************************
 ************ Wealth Grade   **********
 **************************************/

- (long long int)currentCoinCount
{
    NSNumber *coinNumber = [self valueForKey:@"CurrentCoinCount"];
    return [coinNumber longLongValue];
}

- (long long int)needCoinCountIfUpgrade
{
    NSNumber *needCoinUpgrade = [self valueForKey:@"NeedCoinCountIfUpgrade"];
    return [needCoinUpgrade longLongValue];
}

- (NSInteger)wealthGrade
{
    NSNumber *wealthGradeNumber = [self valueForKey:@"WealthGrade"];
    if ([wealthGradeNumber isKindOfClass:[NSNumber class]])
    {
        return [wealthGradeNumber integerValue];
    }
    return 0;
}

/**************************************
 ************ Chat Room ***************
 **************************************/

- (NSString *)action
{
    return [self valueForKey:@"action"];
}

- (NSInteger)car
{
    NSDictionary *carDict = [self valueForKey:@"data_d"];
    NSNumber *carNumber = [carDict valueForKey:@"car"];
    return [carNumber integerValue];
}

- (NSString *)nickName
{
    NSDictionary *nickDict = [self valueForKey:@"data_d"];
    return [nickDict valueForKey:@"nick_name"];
}

- (NSString *)nickNameFrom
{
    NSDictionary *fromDict = [self valueForKey:@"from"];
    return [fromDict valueForKey:@"nick_name"];
}

- (NSString *)nickNameTo
{
    NSDictionary *toDict = [self valueForKey:@"to"];
    return [toDict valueForKey:@"nick_name"];
}

- (NSInteger)priv
{
    NSDictionary *privDict = [self valueForKey:@"data_d"];
    NSNumber *privNumber = [privDict valueForKey:@"priv"];
    if ([privNumber isKindOfClass:[NSNumber class]])
    {
        return [privNumber integerValue];
    }
    return 0;
}

- (long long int)spend
{
    NSDictionary *spendDict = [self valueForKey:@"data_d"];
    NSNumber *spendNumber = [spendDict valueForKey:@"spend"];
    if ([spendNumber isKindOfClass:[NSNumber class]])
    {
        return [spendNumber longLongValue];
    }
    return 0;
}

- (NSString *)content
{
    return [self valueForKey:@"content"];
}

- (BOOL)chatPrivate
{
    NSDictionary *toDict = [self valueForKey:@"to"];
    NSNumber *toNumber = [toDict valueForKey:@"private"];
    if ([toNumber isKindOfClass:[NSNumber class]])
    {
        return [toNumber boolValue];
    }
    return NO;
}

- (NSUInteger)roomChangeUserID
{
    NSDictionary *roomChangeDict = [self valueForKey:@"data_d"];
    NSNumber *useridNumber = [roomChangeDict valueForKey:@"_id"];
    if ([useridNumber isKindOfClass:[NSNumber class]])
    {
        return [useridNumber integerValue];
    }
    return 0;
}

- (NSUInteger)fromID
{
    NSDictionary *fromDict = [self valueForKey:@"from"];
    NSNumber *fromIDNumber = [fromDict valueForKey:@"_id"];
    if ([fromIDNumber isKindOfClass:[NSNumber class]])
    {
        return [fromIDNumber integerValue];
    }
    return 0;
}

- (NSUInteger)toID
{
    NSDictionary *toDict = [self valueForKey:@"to"];
    NSNumber *toIDNumber = [toDict valueForKey:@"_id"];
    if ([toIDNumber isKindOfClass:[NSNumber class]])
    {
        return [toIDNumber integerValue];
    }
    return 0;
}

// System Notice.
- (NSString *)noticeContent
{
    NSDictionary *noticeDict = [self valueForKey:@"data_d"];
    return [noticeDict valueForKey:@"msg"];
}

- (NSString *)noticeUrl
{
    NSDictionary *noticeDict = [self valueForKey:@"data_d"];
    return [noticeDict valueForKey:@"url"];
}

// puzzle
- (NSString *)puzzlePic
{
    NSDictionary *puzzleDict = [self valueForKey:@"data_d"];
    return [puzzleDict valueForKey:@"pic"];
}

- (NSString *)puzzleMsg
{
    NSDictionary *puzzleDict = [self valueForKey:@"data_d"];
    return [puzzleDict valueForKey:@"msg"];
}

- (NSInteger)puzzleSecond
{
    NSDictionary *puzzleDict = [self valueForKey:@"data_d"];
    NSNumber *secNumber = [puzzleDict valueForKey:@"second"];
    return [secNumber integerValue];
}

- (NSInteger)puzzleX
{
    NSDictionary *puzzleDict = [self valueForKey:@"data_d"];
    NSNumber *xNumber = [puzzleDict valueForKey:@"x"];
    return [xNumber integerValue];
}

- (NSInteger)puzzleY
{
    NSDictionary *puzzleDict = [self valueForKey:@"data_d"];
    NSNumber *yNumber = [puzzleDict valueForKey:@"y"];
    return [yNumber integerValue];
}

- (NSInteger)puzzleCost
{
    NSDictionary *puzzleDict = [self valueForKey:@"data_d"];
    NSNumber *costNumber = [puzzleDict valueForKey:@"cost"];
    return [costNumber integerValue];
}

- (NSInteger)puzzleStep
{
    NSDictionary *puzzleDict = [self valueForKey:@"data_d"];
    NSNumber *stepNumber = [puzzleDict valueForKey:@"step"];
    return [stepNumber integerValue];
}

- (NSInteger)puzzleUserID
{
    NSDictionary *puzzleDict = [self valueForKey:@"data_d"];
    NSNumber *useridNumber = [puzzleDict valueForKey:@"user_id"];
    return [useridNumber integerValue];
}

- (NSString *)puzzleNick
{
    NSDictionary *puzzleDict = [self valueForKey:@"data_d"];
    return [puzzleDict valueForKey:@"user_nick"];
}

// Broadcast
- (NSString *)broadcastFromNickName
{
    NSDictionary *broadcastDict = [self valueForKey:@"data_d"];
    NSDictionary *fromBroadcastDict = [broadcastDict valueForKey:@"from"];
    return [fromBroadcastDict valueForKey:@"nick_name"];
}

- (NSInteger)broadcastFromID
{
    NSDictionary *broadcastDict = [self valueForKey:@"data_d"];
    NSDictionary *fromBroadcastDict = [broadcastDict valueForKey:@"from"];
    NSNumber *fromIDNumber = [fromBroadcastDict valueForKey:@"_id"];
    if ([fromIDNumber isKindOfClass:[NSNumber class]])
    {
        return [fromIDNumber integerValue];
    }
    return 0;
}

- (NSString *)broadcastMessage
{
    NSDictionary *broadcastDict = [self valueForKey:@"data_d"];
    return [broadcastDict valueForKey:@"message"];
}

- (NSInteger)broadcastRoomID
{
    NSDictionary *broadcastDict = [self valueForKey:@"data_d"];
    NSNumber *roomidNumber = [broadcastDict valueForKey:@"room_id"];
    return [roomidNumber integerValue];
}

- (NSString *)broadcastRoomStar
{
    NSDictionary *broadcastDict = [self valueForKey:@"data_d"];
    return [broadcastDict valueForKey:@"room_star"];
}

- (BOOL)broadcastUrl
{
    NSDictionary *broadcastDict = [self valueForKey:@"data_d"];
    NSNumber *urlNumber = [broadcastDict valueForKey:@"url"];
    return [urlNumber boolValue];
}

// Live Status
- (BOOL)live
{
    NSDictionary *liveDict = [self valueForKey:@"data_d"];
    NSNumber *liveNumber = [liveDict valueForKey:@"live"];
    return [liveNumber boolValue];
}

/*
 * Pic Join.............
 */

- (NSInteger)enterRoomVip
{
    NSDictionary *enterDict = [self valueForKey:@"data_d"];
    NSNumber *vipNumber = [enterDict valueForKey:@"vip"];
    return [vipNumber integerValue];
}

- (BOOL)enterRoomVipHiding
{
    NSDictionary *enterDict = [self valueForKey:@"data_d"];
    NSNumber *vipHidingNumber = [enterDict valueForKey:@"vip_hiding"];
    return [vipHidingNumber boolValue];
}

- (NSInteger)fromLevel
{
    NSNumber *levelNumber = [self valueForKey:@"level"];
    return [levelNumber integerValue];
}

- (NSInteger)fromPriv
{
    NSDictionary *fromDict = [self valueForKey:@"from"];
    NSNumber *privNumber = [fromDict valueForKey:@"priv"];
    if ([privNumber isKindOfClass:[NSNumber class]])
    {
        return [privNumber integerValue];
    }
    return 0;
}

- (NSInteger)fromVip
{
    NSDictionary *fromDict = [self valueForKey:@"from"];
    NSNumber *vipNumber = [fromDict valueForKey:@"vip"];
    return [vipNumber integerValue];
}

- (NSInteger)toLevel
{
    NSDictionary *toDict = [self valueForKey:@"to"];
    NSNumber *levelNumber = [toDict valueForKey:@"level"];
    return [levelNumber integerValue];
}

- (NSInteger)toPriv
{
    NSDictionary *toDict = [self valueForKey:@"to"];
    NSNumber *toPrivNumber = [toDict valueForKey:@"priv"];
    if ([toPrivNumber isKindOfClass:[NSNumber class]])
    {
        return [toPrivNumber integerValue];
    }
    return 0;
}

- (NSInteger)toVip
{
    NSDictionary *toDict = [self valueForKey:@"to"];
    NSNumber *vipNumber = [toDict valueForKey:@"vip"];
    return [vipNumber integerValue];
}

// Shutup Or Kickout.
- (NSString *)stopNickNameFrom
{
    NSDictionary *stopDict = [self valueForKey:@"data_d"];
    return [stopDict valueForKey:@"f_name"];
}

- (NSInteger)stopIDFrom
{
    NSDictionary *stopDict = [self valueForKey:@"data_d"];
    NSNumber *stopidNumber = [stopDict valueForKey:@"f_id"];
    return [stopidNumber integerValue];
}

- (NSString *)stopNickNameTo
{
    NSDictionary *stopDict = [self valueForKey:@"data_d"];
    return [stopDict valueForKey:@"nick_name"];
}

- (NSInteger)stopIDTo
{
    NSDictionary *stopDict = [self valueForKey:@"data_d"];
    NSNumber *useridNumber = [stopDict valueForKey:@"xy_user_id"];
    if ([useridNumber isKindOfClass:[NSNumber class]])
    {
        return [useridNumber integerValue];
    }
    return 0;
}

- (NSInteger)stopTime
{
    NSDictionary *stopDict = [self valueForKey:@"data_d"];
    NSNumber *minuteNumber = [stopDict valueForKey:@"minute"];
    return [minuteNumber integerValue];
}

- (NSString *)access_token
{
    return [self valueForKey:@"access_token"];
}

- (NSString *)access_token1
{
    return [self valueForKey:@"token"];
}


// Send Gift
- (NSInteger)giftFromID
{
    NSDictionary *giftDict = [self valueForKey:@"data_d"];
    NSDictionary *fromDict = [giftDict valueForKey:@"from"];
    NSNumber *giftidNumber = [fromDict valueForKey:@"_id"];
    return [giftidNumber integerValue];
}

- (NSString *)giftNickNameFrom
{
    NSDictionary *giftDict = [self valueForKey:@"data_d"];
    NSDictionary *fromDict = [giftDict valueForKey:@"from"];
    return [fromDict valueForKey:@"nick_name"];
}

- (NSInteger)giftToID
{
    NSDictionary *giftDict = [self valueForKey:@"data_d"];
    NSDictionary *toDict = [giftDict valueForKey:@"to"];
    NSNumber *gifttoidNumber = [toDict valueForKey:@"_id"];
    return [gifttoidNumber integerValue];
}

- (NSString *)giftNickNameTo
{
    NSDictionary *giftDict = [self valueForKey:@"data_d"];
    NSDictionary *toDict = [giftDict valueForKey:@"to"];
    return [toDict valueForKey:@"nick_name"];
}

- (NSInteger)giftCount
{
    NSDictionary *giftDict = [self valueForKey:@"data_d"];
    NSDictionary *giftCountDict = [giftDict valueForKey:@"gift"];
    NSNumber *giftcountNumber = [giftCountDict valueForKey:@"count"];
    return [giftcountNumber integerValue];
}

- (NSInteger)giftCoinPrice
{
    NSDictionary *giftDict = [self valueForKey:@"data_d"];
    NSDictionary *giftCoinPriceDict = [giftDict valueForKey:@"gift"];
    NSNumber *giftCoinNumber = [giftCoinPriceDict valueForKey:@"coin_price"];
    return [giftCoinNumber integerValue];
}

- (NSString *)giftPic
{
    NSDictionary *giftDict = [self valueForKey:@"data_d"];
    NSDictionary *giftPicDict = [giftDict valueForKey:@"gift"];
    return [giftPicDict valueForKey:@"pic_url"];
}

// Warning:This Field didn't come from server, it didn't response this parameter.
- (NSString *)giftPicUrlString
{
    return [self valueForKey:@"pic_url"];
}

- (NSString *)giftName
{
    return [self valueForKey:@"name"];
}

- (NSInteger)giftID
{
    NSDictionary *giftDict = [self valueForKey:@"data_d"];
    NSDictionary *giftIDDict = [giftDict valueForKey:@"gift"];
    NSNumber *giftidNumber = [giftIDDict valueForKey:@"_id"];
    return [giftidNumber integerValue];
}

- (NSInteger)featherFromID
{
    NSDictionary *featherDict = [self valueForKey:@"data_d"];
    NSNumber *featheridNumber = [featherDict valueForKey:@"_id"];
    return [featheridNumber integerValue];
}

- (NSString *)featherNickNameFrom
{
    NSDictionary *featherDict = [self valueForKey:@"data_d"];
    return [featherDict valueForKey:@"nick_name"];
}

// User Head Pic
- (NSString *)user_pic_url
{
    return [self valueForKey:@"pic_url"];
}

// Publish Chat.
+ (NSString *)getChatStringTarget:(TTShowChatTarget *)target Private:(BOOL)_private Content:(NSString *)content
{
    return [(NSDictionary *)[[self class] getChatJsonTarget:target Private:_private Content:content] JSONRepresentation];
}

+ (NSDictionary *)getChatJsonTarget:(TTShowChatTarget *)target Private:(BOOL)_private Content:(NSString *)content
{
    if (content == nil || [content isEqualToString:@""])
    {
        return nil;
    }
    
    // Level 3
    NSMutableDictionary *toDetailDict = [NSMutableDictionary dictionaryWithCapacity:0];
    // Level 2
    NSMutableDictionary *msgDict = [NSMutableDictionary dictionaryWithCapacity:0];
    // Level 1
    NSDictionary *topDict = [NSMutableDictionary dictionaryWithCapacity:0];
    
    if (target != nil)
    {
        NSUInteger toUserID = [[target valueForKey:kChatTargetIDKey] integerValue];
        NSString *toUserNickName = [target valueForKey:kChatTargetNickNameKey];
        
        // Level 3
        [toDetailDict setValue:toUserNickName forKey:@"nick_name"];
        [toDetailDict setValue:@(toUserID) forKey:@"_id"];
        [toDetailDict setValue:@(_private) forKey:@"private"];
        
        // Level 2
        [msgDict setValue:toDetailDict forKey:@"to"];
        // Level 1
//        [topDict setValue:@([TTShowUser unarchiveUser]._id) forKey:@"user_id"];
    }
    
    [msgDict setValue:content forKey:@"content"];
    
    // This Level Value is new.
    [msgDict setValue:@(0) forKey:@"level"];
    
    [topDict setValue:msgDict forKey:@"msg"];
    
    return topDict;
}

+ (NSDictionary *)getChatJson:(NSString *)content
{
    if (content == nil || [content isEqualToString:@""])
    {
        return nil;
    }
    
    // Level 3
    NSMutableDictionary *toDetailDict = [NSMutableDictionary dictionaryWithCapacity:0];
    [toDetailDict setValue:@"" forKey:@"nick_name"];
    [toDetailDict setValue:@(0) forKey:@"_id"];
    [toDetailDict setValue:@(NO) forKey:@"private"];
    
    // Level 2
    NSMutableDictionary *msgDict = [NSMutableDictionary dictionaryWithCapacity:0];
    [msgDict setValue:content forKey:@"content"];
    [msgDict setValue:@(1) forKey:@"level"];
    [msgDict setValue:toDetailDict forKey:@"to"];
    
    // Level 1
    NSDictionary *topDict = [NSMutableDictionary dictionaryWithCapacity:0];
    [topDict setValue:msgDict forKey:@"msg"];
//    [topDict setValue:@([TTShowUser unarchiveUser]._id) forKey:@"user_id"];
    
    return topDict;
}

+ (NSString *)getChatString:(NSString *)content
{
    return [(NSDictionary *)[[self class] getChatJson:content] JSONRepresentation];
}

/**************************************
 ************ Room Star ***************
 **************************************/

- (NSUInteger)roomStarID
{
    return [[[self valueForKey:@"data_d"] valueForKey:@"_id"] integerValue];
}

- (NSString *)roomStarNickName
{
    return [[self valueForKey:@"data_d"] valueForKey:@"nick_name"];
}

- (NSString *)roomStarPic
{
    return [[self valueForKey:@"data_d"] valueForKey:@"pic"];
}

- (NSUInteger)roomStarBeanTotalCount
{
    return [[[[self valueForKey:@"data_d"] valueForKey:@"finance"] valueForKey:@"bean_count_total"] integerValue];
}

- (NSUInteger)roomStarCoinSpendTotal
{
    return [[[[self valueForKey:@"data_d"] valueForKey:@"finance"] valueForKey:@"coin_spend_total"] integerValue];
}

- (NSUInteger)roomStarFeatherReceiveTotal
{
    return [[[[self valueForKey:@"data_d"] valueForKey:@"finance"] valueForKey:@"feather_receive_total"] integerValue];
}

- (NSUInteger)roomStarRoomID
{
    return [[[[self valueForKey:@"data_d"] valueForKey:@"star"] valueForKey:@"room_id"] integerValue];
}

- (NSUInteger)roomStarDayRank
{
    return [[[[self valueForKey:@"data_d"] valueForKey:@"star"] valueForKey:@"day_rank"] integerValue];
}

@end
