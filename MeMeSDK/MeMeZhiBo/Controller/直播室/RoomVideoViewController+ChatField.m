//
//  RoomVideoViewController+ChatField.m
//  TTShow
//
//  Created by twb on 13-7-3.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import "RoomVideoViewController+ChatField.h"
#import "TTShowAdmin.h"
#import "TTShowUserRank.h"
#import "TTShowGift.h"
#import "TTShowCar.h"

@implementation RoomVideoViewController (ChatField)

- (NSString *)action:(NSDictionary *)jsonData
{
    return [jsonData valueForKey:@"action"];
}

#pragma mark - Chat Field Information part.

- (NSString *)chatContent:(NSDictionary *)jsonData
{
    return [[jsonData content] stringByUnescapingFromHTML];
}

- (NSString *)chatNickName:(NSDictionary *)jsonData
{
    return [[jsonData nickName] stringByUnescapingFromHTML];
}

- (NSString *)chatFromNickName:(NSDictionary *)jsonData
{
    return [[jsonData nickNameFrom] stringByUnescapingFromHTML];
}

- (NSString *)chatToNickName:(NSDictionary *)jsonData
{
    return [[jsonData nickNameTo] stringByUnescapingFromHTML];
}

- (NSUInteger)chatFromUserID:(NSDictionary *)jsonData
{
    return [jsonData fromID];
}

- (NSUInteger)chatToUserID:(NSDictionary *)jsonData
{
    return [jsonData toID];
}

- (NSInteger)enterPriv:(NSDictionary *)jsonData
{
    return [jsonData priv];
}

- (long long int)enterSpend:(NSDictionary *)json
{
    return [json spend];
}

- (BOOL)chatIsPrivate:(NSDictionary *)jsonData
{
    return [jsonData chatPrivate];
}

#pragma mark - Enter Room Part.

- (NSString *)enterRoomNickName:(NSDictionary *)jsonData
{
    return [[jsonData nickName] stringByUnescapingFromHTML];
}

- (NSInteger)enterCarID:(NSDictionary *)jsonData
{
    return [jsonData car];
}

- (NSString *)carPicUrl:(NSDictionary *)jsonData
{
    NSInteger carID = [self enterCarID:jsonData];
    if (!carID)
    {
        return nil;
    }
    
    if (self.carList.count > 0) {
        for (TTShowCar *car in self.carList)
        {
            if (carID == car._id)
            {
                return car.pic_url;
            }
        }
    }
    
    return nil;
}

- (NSString *)carName:(NSDictionary *)json
{
    NSInteger carID = [self enterCarID:json];
    if (!carID)
    {
        return nil;
    }
    if (self.carList.count > 0) {
        
        for (TTShowCar *car in self.carList)
        {
            if (carID == car._id)
            {
                return car.name;
            }
        }
    }
    return nil;
}

- (BOOL)isFamousCar:(NSDictionary *)json
{
    NSArray *famousCars = @[@"法拉利", @"挖掘机", @"玛莎拉蒂",@"战斗机",@"哈雷摩托",@"加长林肯",@"劳斯莱斯",@"宇宙战舰",@"路虎"];
    NSString *carName = [self carName:json];
    
    NSArray *result = [famousCars filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF == %@", carName]];
    if (result != nil && result.count != 0)
    {
        return YES;
    }
    return NO;
}

- (NSUInteger)enterRoomUserID:(NSDictionary *)jsonData
{
    return [jsonData roomChangeUserID];
}

- (NSInteger)enterRoomVipType:(NSDictionary *)jsonData
{
    return [jsonData enterRoomVip];
}

- (BOOL)enterRoomVipHiding:(NSDictionary *)jsonData
{
    return [jsonData enterRoomVipHiding];
}

#pragma mark - Shutup part.

- (NSString *)stopNickNameFrom:(NSDictionary *)jsonData
{
    return [[jsonData stopNickNameFrom] stringByUnescapingFromHTML];
}

- (NSInteger)stopIDFrom:(NSDictionary *)jsonData
{
    return [jsonData stopIDFrom];
}

- (NSString *)stopNickNameTo:(NSDictionary *)jsonData
{
    return [[jsonData stopNickNameTo] stringByUnescapingFromHTML];
}

- (NSInteger)stopIDTo:(NSDictionary *)jsonData
{
    return [jsonData stopIDTo];
}

- (NSInteger)stopTime:(NSDictionary *)jsonData
{
    return [jsonData stopTime];
}

#pragma mark - Room Star Part.

- (NSString *)roomStarNickName:(NSDictionary *)jsonData
{
    return [[jsonData roomStarNickName] stringByUnescapingFromHTML];
}

- (NSUInteger)roomStarUserID:(NSDictionary *)jsonData
{
    return [jsonData roomStarID];
}

- (long long int)roomStarBeanTotalCount:(NSDictionary *)json
{
    return [json roomStarBeanTotalCount];
}

#pragma mark - Room Show User Pic.

- (NSInteger)roomFromLevel:(NSDictionary *)jsonData
{
    return [jsonData fromLevel];
}

- (NSInteger)roomFromPriv:(NSDictionary *)jsonData
{
    return [jsonData fromPriv];
}

- (BOOL)roomFromAdmin:(NSDictionary *)jsonData
{
    return [self roomOneIsAdmin:[jsonData fromID]];
}

- (BOOL)roomFromSpentMost:(NSDictionary *)jsonData
{
    NSUInteger fromID = [jsonData fromID];
    
    // get first one.
    if (self.liveSpentMost.count > 0)
    {
        TTShowUserRank *firstUser = self.liveSpentMost[0];
        return firstUser._id == fromID;
    }
    return NO;
}

- (BOOL)roomFromStar:(NSDictionary *)jsonData
{
    if (self.currentRoomStar._id == 0)
    {
        return NO;
    }
    return [jsonData fromID] == self.currentRoomStar._id;
}

- (NSInteger)roomFromVip:(NSDictionary *)jsonData
{
    return [jsonData fromVip];
}

- (NSInteger)roomToLevel:(NSDictionary *)jsonData
{
    return [jsonData toLevel];
}

- (NSInteger)roomToPriv:(NSDictionary *)jsonData
{
    return [jsonData toPriv];
}

- (BOOL)roomToAdmin:(NSDictionary *)jsonData
{
    return [self roomOneIsAdmin:[jsonData toID]];
}

- (BOOL)roomOneIsAdmin:(NSInteger)_id
{
    if (self.adminList == nil || self.adminList.count == 0 || _id == 0)
    {
        return NO;
    }

    NSArray *result = [self.adminList filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF._id == %d", _id]];
    if (result != nil && result.count != 0)
    {
        return YES;
    }
    
    return NO;
}

- (BOOL)roomOneIsStar:(NSInteger)_id
{
    if (_id == 0 || self.currentRoomStar._id == 0)
    {
        return NO;
    }
    return (self.currentRoomStar._id == _id);
}

- (BOOL)roomToSpentMost:(NSDictionary *)jsonData
{
    NSUInteger toID = [jsonData toID];
    return [self oneSpentMost:toID];
}

- (BOOL)oneSpentMost:(NSInteger)_id
{
    // get first one.
    if (self.liveSpentMost.count > 0)
    {
        TTShowUserRank *firstUser = self.liveSpentMost[0];
        return firstUser._id == _id;
    }
    return NO;
}

- (BOOL)roomToStar:(NSDictionary *)jsonData
{
    if (self.currentRoom._id == 0 || [jsonData toID] == 0)
    {
        return NO;
    }
    return [jsonData toID] == self.currentRoomStar._id;
}

- (NSInteger)roomToVip:(NSDictionary *)jsonData
{
    return [jsonData toVip];
}

- (BOOL)roomOneHasFlames:(NSInteger)_id
{
    if (self.liveAudiences == nil || self.liveAudiences.count == 0 || _id == 0)
    {
        return NO;
    }
    
    NSArray *result = [self.liveAudiences filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF._id == %d && SELF.active_value >= %d", _id, 160]];
    
    if (result != nil && result.count != 0)
    {
        return YES;
    }
    
    return NO;
}

#pragma mark - Puzzle part.

// puzzle
- (NSString *)puzzlePic:(NSDictionary *)json
{
    return [json puzzlePic];
}

- (NSString *)puzzleMsg:(NSDictionary *)json
{
    return [json puzzleMsg];
}

- (NSInteger)puzzleSecond:(NSDictionary *)json
{
    return [json puzzleSecond];
}

- (NSInteger)puzzleX:(NSDictionary *)json
{
    return [json puzzleX];
}

- (NSInteger)puzzleY:(NSDictionary *)json
{
    return [json puzzleY];
}

- (NSInteger)puzzleCost:(NSDictionary *)json
{
    return [json puzzleCost];
}

- (NSInteger)puzzleStep:(NSDictionary *)json
{
    return [json puzzleStep];
}

- (NSInteger)puzzleUserID:(NSDictionary *)json
{
    return [json puzzleUserID];
}

- (NSString *)puzzleNick:(NSDictionary *)json
{
    return [[json puzzleNick] stringByUnescapingFromHTML];
}


/*
 * Send Gift
 */

- (NSInteger)giftFromID:(NSDictionary *)json
{
    return [json giftFromID];
}

- (NSString *)giftFromNickName:(NSDictionary *)json
{
    return [[json giftNickNameFrom] stringByUnescapingFromHTML];
}

- (NSInteger)giftToID:(NSDictionary *)json
{
    return [json giftToID];
}

- (NSString *)giftToNickName:(NSDictionary *)json
{
    return [[json giftNickNameTo] stringByUnescapingFromHTML];
}

- (NSInteger)giftCount:(NSDictionary *)json
{
    return [json giftCount];
}

- (NSInteger)giftCoinPrice:(NSDictionary *)json
{
    return [json giftCoinPrice];
}

- (NSString *)giftPic:(NSDictionary *)json
{
    return [json giftPic];
}

- (NSInteger)giftID:(NSDictionary *)json
{
    return [json giftID];
}

- (NSString *)giftPicUrl:(NSInteger)_id
{
    if (self.giftController.totalGiftList.count > 0)
    {
        for (NSDictionary *giftDict in self.giftController.totalGiftList)
        {
            @autoreleasepool
            {
                TTShowGift *gift = [[TTShowGift alloc] initWithAttributes:giftDict];
                if (gift._id == _id)
                {
                    return gift.pic_url;
                }
            }
        }
    }
    return nil;
}

- (NSString *)giftPicGif:(NSInteger)_id
{
    if (self.giftController.totalGiftList.count > 0)
    {
        for (NSDictionary *giftDict in self.giftController.totalGiftList)
        {
            @autoreleasepool
            {
                TTShowGift *gift = [[TTShowGift alloc] initWithAttributes:giftDict];
                if (gift._id == _id)
                {
                    return gift.pic_pre_url;
                }
            }
        }
    }
    return nil;
}

- (NSString *)giftName:(NSInteger)_id
{
    if (self.giftController.totalGiftList.count > 0)
    {
        for (NSDictionary *giftDict in self.giftController.totalGiftList)
        {
            @autoreleasepool
            {
                TTShowGift *gift = [[TTShowGift alloc] initWithAttributes:giftDict];
                if (gift._id == _id)
                {
                    return gift.name;
                }
            }
        }
    }
    return nil;
}

- (NSInteger)featherFromID:(NSDictionary *)json
{
    return [json featherFromID];
}

- (NSString *)featherFromNickName:(NSDictionary *)json
{
    return [[json featherNickNameFrom] stringByUnescapingFromHTML];
}

// System Notice.
- (NSString *)noticeContent:(NSDictionary *)json
{
    return [[json noticeContent] stringByUnescapingFromHTML];
}

- (NSString *)noticeUrl:(NSDictionary *)json
{
    return [json noticeUrl];
}

// Broadcast.
- (NSString *)broadcastFromNickName:(NSDictionary *)json
{
    return [[json broadcastFromNickName] stringByUnescapingFromHTML];
}

- (NSInteger)broadcastFromID:(NSDictionary *)json
{
    return [json broadcastFromID];
}

- (NSString *)broadcastMessage:(NSDictionary *)json
{
    return [[json broadcastMessage] stringByUnescapingFromHTML];
}

- (NSInteger)broadcastRoomID:(NSDictionary *)json
{
    return [json broadcastRoomID];
}

- (NSString *)broadcastRoomStar:(NSDictionary *)json
{
    return [json broadcastRoomStar];
}

- (BOOL)broadcastUrl:(NSDictionary *)json
{
    return [json broadcastUrl];
}

- (BOOL)live:(NSDictionary *)json
{
    return [json live];
}

// Tag Gift.
- (NSDictionary *)filterTagGift
{
    if (!self.currentRoomStar.tag)
    {
        return nil;
    }
    
//    LOGINFO(@"self.currentRoomStar.tag = %@", self.currentRoomStar.tag);
    
    NSDictionary *tagGiftDict = self.currentRoomStar.tag;
    
    if (tagGiftDict.allKeys.count == 0 || tagGiftDict.allValues.count == 0)
    {
        return nil;
    }
    
    NSArray *result = [tagGiftDict.allValues sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSNumber *n1 = (NSNumber *)obj1;
        NSNumber *n2 = (NSNumber *)obj2;
        
        if ([n1 integerValue] > [n2 integerValue])
        {
            return NSOrderedAscending;
        }
        else if ([n1 integerValue] < [n2 integerValue])
        {
            return NSOrderedDescending;
        }
        
        return NSOrderedSame;
    }];
    
    NSMutableArray *topArray = [NSMutableArray arrayWithCapacity:0];
    // Get Top Tag Gift.
    NSInteger tagGitCount = (result.count < 3 ? result.count : 3);
    
    
    for (NSInteger i = 0; i < tagGitCount; i++)
    {
        [topArray addObject:result[i]];
    }
    
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithCapacity:0];
    
    for (NSString *key in tagGiftDict.allKeys)
    {
        NSNumber *value = [tagGiftDict valueForKey:key];
        if ([topArray containsObject:value])
        {
            [dictionary setValue:value forKey:key];
        }
    }
    
    return dictionary;
}

- (NSArray *)tagGifts
{
    NSDictionary *tagGiftDict = [self filterTagGift];
    
    if (!tagGiftDict)
    {
        return nil;
    }
    
    NSMutableArray *giftNames = [NSMutableArray arrayWithCapacity:0];
    for (NSString *key in tagGiftDict.allKeys)
    {
        NSString *giftName = [self giftName:[key integerValue]];
        if (giftName != nil && ![giftName isEqualToString:@""])
        {
            [giftNames addObject:giftName];
        }
    }
    return giftNames;
}


// Text
- (NSDictionary *)carEnterDictionary:(BOOL)car json:(NSDictionary*)json
{
    NSString *carName = [self carName:json];
    return [self chatText:[NSString stringWithFormat:@"%@%@",car ? kChatCommonCarDrive : kChatCommonCarRide,carName] size:kChatJrSize color:kEnterRoomColor];
}

- (NSDictionary *)chatText:(NSString *)content size:(CGFloat)size color:(ChatRoomFontColorMode)color withUnderLine:(BOOL)underline
{
    NSMutableDictionary *text = [[NSMutableDictionary alloc] init];
    [text setValue:@(kChatRoomText) forKey:kChatTypeKeyName];
    [text setValue:kFormatNilString(content) forKey:kChatTextKeyName];
    [text setValue:@(size) forKey:kChatTextFontSizeKeyName];
    [text setValue:@(color) forKey:kChatTextColorTypeKeyName];
    [text setValue:@(underline) forKey:kChatTextHasUnderLineKeyName];
    return text;
}

- (NSDictionary *)chatText:(NSString *)content size:(CGFloat)size color:(ChatRoomFontColorMode)color
{
    return [self chatText:content size:size color:color withUnderLine:NO];
}

// Pic.
- (NSDictionary *)spentMostDictionary
{
    NSDictionary *spentMost = @{kChatTypeKeyName: @(kChatRoomLocalDynamicImage),
                                kChatImageKeyName : kChatSpentMostImageName,
                                kChatImageWidthKeyName : @(kChatSpentMostImageWidth),
                                kChatImageHeightKeyName : @(kChatSpentMostImageHeight),
                                kChatImagePaddingXKeyName : @(kChatSpentMostImagePaddingX),
                                kChatImagePaddingYKeyName : @(kChatSpentMostImagePaddingY)};
    return spentMost;
}

- (NSDictionary *)starDictionary
{
    NSDictionary *star = @{kChatTypeKeyName: @(kChatRoomLocalDynamicImage),
                           kChatImageKeyName : kChatStarImageName,
                           kChatImageWidthKeyName : @(kChatStarImageWidth),
                           kChatImageHeightKeyName : @(kChatStarImageHeight),
                           kChatImagePaddingXKeyName : @(kChatStarImagePaddingX),
                           kChatImagePaddingYKeyName : @(kChatStarImagePaddingY)};
    return star;
}

- (NSDictionary *)wealthLevelDictionary:(NSInteger)levelCount
{
    NSString *levelImage = [[NSString alloc] initWithFormat:@"%@", [self.dataManager.global wealthImageString:levelCount]];
    NSDictionary *wealthLevel = @{kChatTypeKeyName: @(kChatRoomLocalDynamicImage),
                                  kChatImageKeyName : levelImage,
                                  kChatImageWidthKeyName : @(kChatWealthLevelImageWidth),
                                  kChatImageHeightKeyName : @(kChatWealthLevelImageHeight),
                                  kChatImagePaddingXKeyName : @(kChatWealthLevelImagePaddingX),
                                  kChatImagePaddingYKeyName : @(kChatWealthLevelImagePaddingY)};
    return wealthLevel;
}

- (NSDictionary *)starLevelDictionary:(NSInteger)levelCount
{
    NSString *starLevelImage = [[NSString alloc] initWithFormat:@"%@", [self.dataManager.global anchorImageString:levelCount]];
    NSDictionary *starLevel = @{kChatTypeKeyName: @(kChatRoomLocalDynamicImage),
                                kChatImageKeyName : starLevelImage,
                                kChatImageWidthKeyName : @(kChatStarLevelImageWidth),
                                kChatImageHeightKeyName : @(kChatStarLevelImageHeight),
                                kChatImagePaddingXKeyName : @(kChatStarLevelImagePaddingX),
                                kChatImagePaddingYKeyName : @(kChatStarLevelImagePaddingY)};
    return starLevel;
}

- (NSDictionary *)adminDictionary
{
    NSDictionary *admin = @{kChatTypeKeyName : @(kChatRoomLocalDynamicImage),
                            kChatImageKeyName : kChatManagerImageName,
                            kChatImageWidthKeyName : @(kChatManagerImageWidth),
                            kChatImageHeightKeyName : @(kChatManagerImageHeight),
                            kChatImagePaddingXKeyName : @(kChatManagerImagePaddingX),
                            kChatImagePaddingYKeyName : @(kChatManagerImagePaddingY)};
    return admin;
}

- (NSDictionary *)agentDictionary
{
    NSDictionary *agent = @{kChatTypeKeyName: @(kChatRoomLocalDynamicImage),
                            kChatImageKeyName : kChatAgentImageName,
                            kChatImageWidthKeyName : @(kChatAgentImageWidth),
                            kChatImageHeightKeyName : @(kChatAgentImageHeight),
                            kChatImagePaddingXKeyName : @(kChatAgentImagePaddingX),
                            kChatImagePaddingYKeyName : @(kChatAgentImagePaddingY)};
    return agent;
}

- (NSDictionary *)businessDictionary
{
    NSDictionary *business = @{kChatTypeKeyName: @(kChatRoomLocalDynamicImage),
                               kChatImageKeyName : kChatBusinessImageName,
                               kChatImageWidthKeyName : @(kChatBusinessImageWidth),
                               kChatImageHeightKeyName : @(kChatBusinessImageHeight),
                               kChatImagePaddingXKeyName : @(kChatBusinessImagePaddingX),
                               kChatImagePaddingYKeyName : @(kChatBusinessImagePaddingY)};
    return business;
}

- (NSDictionary *)cServiceDictionary
{
    NSDictionary *cService = @{kChatTypeKeyName: @(kChatRoomLocalDynamicImage),
                               kChatImageKeyName : kChatCServiceImageName,
                               kChatImageWidthKeyName : @(kChatCServiceImageWidth),
                               kChatImageHeightKeyName : @(kChatCServiceImageHeight),
                               kChatImagePaddingXKeyName : @(kChatCServiceImagePaddingX),
                               kChatImagePaddingYKeyName : @(kChatCServiceImagePaddingY)};
    return cService;
}

- (NSDictionary *)trialVipDictionary
{
    NSDictionary *trialVip = @{kChatTypeKeyName: @(kChatRoomLocalDynamicImage),
                               kChatImageKeyName : kChatTrialVipImageName,
                               kChatImageWidthKeyName : @(kChatTrialVipImageWidth),
                               kChatImageHeightKeyName : @(kChatTrialVipImageHeight),
                               kChatImagePaddingXKeyName : @(kChatTrialVipImagePaddingX),
                               kChatImagePaddingYKeyName : @(kChatTrialVipImagePaddingY)};
    return trialVip;
}

- (NSDictionary *)vipDictionary
{
    NSDictionary *vip = @{kChatTypeKeyName: @(kChatRoomLocalDynamicImage),
                          kChatImageKeyName : kChatVipImageName,
                          kChatImageWidthKeyName : @(kChatVipImageWidth),
                          kChatImageHeightKeyName : @(kChatVipImageHeight),
                          kChatImagePaddingXKeyName : @(kChatVipImagePaddingX),
                          kChatImagePaddingYKeyName : @(kChatVipImagePaddingY)};
    return vip;
}

- (NSDictionary *)vipExtremeDictionary
{
    NSDictionary *vipExtreme = @{kChatTypeKeyName: @(kChatRoomLocalDynamicImage),
                                 kChatImageKeyName : kChatExtremeVipImageName,
                                 kChatImageWidthKeyName : @(kChatExtremeVipImageWidth),
                                 kChatImageHeightKeyName : @(kChatExtremeVipImageHeight),
                                 kChatImagePaddingXKeyName : @(kChatExtremeVipImagePaddingX),
                                 kChatImagePaddingYKeyName : @(kChatExtremeVipImagePaddingY)};
    return vipExtreme;
}

- (NSDictionary *)flameDictionary
{
    NSDictionary *flame = @{kChatTypeKeyName: @(kChatRoomLocalDynamicImage),
                            kChatImageKeyName : kChatFlameImageName,
                            kChatImageWidthKeyName : @(kChatFlameImageWidth),
                            kChatImageHeightKeyName : @(kChatFlameImageHeight),
                            kChatImagePaddingXKeyName : @(kChatFlameImagePaddingX),
                            kChatImagePaddingYKeyName : @(kChatFlameImagePaddingY)};
    return flame;
}

- (NSDictionary *)carDictionary:(NSString *)imageUrlString
{
    NSString *carPicUrlString = [[NSString alloc] initWithFormat:@"%@", imageUrlString];
    NSDictionary *car = @{kChatTypeKeyName: @(kChatRoomRemoteStaticImage),
                          kChatImageKeyName : carPicUrlString,
                          kChatImageWidthKeyName : @(kChatCarImageWidth),
                          kChatImageHeightKeyName : @(kChatCarImageHeight),
                          kChatImagePaddingXKeyName : @(kChatCarImagePaddingX),
                          kChatImagePaddingYKeyName : @(kChatCarImagePaddingY),
                          @"car":@"123"};
    return car;
}

- (NSDictionary *)giftDictionary:(NSString *)imageUrlString
{
    NSString *remoteImage = [[NSString alloc] initWithFormat:@"%@", imageUrlString];
    NSDictionary *gift = @{kChatTypeKeyName: @(kChatRoomRemoteStaticImage),
                           kChatImageKeyName : remoteImage,
                           kChatImageWidthKeyName : @(kChatGiftImageWidth),
                           kChatImageHeightKeyName : @(kChatGiftImageHeight),
                           kChatImagePaddingXKeyName : @(kChatGiftImagePaddingX),
                           kChatImagePaddingYKeyName : @(kChatGiftImagePaddingY)};
    return gift;
}

- (NSDictionary *)featherDictionary
{
    NSDictionary *feather = @{kChatTypeKeyName: @(kChatRoomLocalStaticImage),
                              kChatImageKeyName : kChatFeatherImageName,
                              kChatImageWidthKeyName : @(kChatFeatherImageWidth),
                              kChatImageHeightKeyName : @(kChatFeatherImageHeight),
                              kChatImagePaddingXKeyName : @(kChatFeatherImagePaddingX),
                              kChatImagePaddingYKeyName : @(kChatFeatherImagePaddingY)};
    return feather;
}

@end
