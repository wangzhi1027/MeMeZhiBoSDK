//
//  TTShowDefaults.m
//  TTShow
//
//  Created by twb on 13-6-28.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import "TTShowDefaults.h"
//#import "TTShowGift.h"


#define kTTShowFeatherCountMax (10)
#define kTTShowRecentlyWatchCountMax (10)

@implementation TTShowDefaults
// Clear after modified.
@synthesize nickNameCache = _nickNameCache;
// Save it as cache after modifying nick name.
@synthesize nickNameCacheCopy = _nickNameCacheCopy;

@synthesize featherCount = _featherCount;
@synthesize firstLaunch = _firstLaunch;
@synthesize showAgreement = _showAgreement;

- (id) init
{
	self = [super init];
	if(self) {

	}
	return self;
}

// Save Gift.

- (NSArray *)giftList
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"ttshow.giftlist"];
}

- (void)saveGiftList:(NSArray *)gifts
{
    NSMutableArray *giftList = [NSMutableArray arrayWithCapacity:0];
    for (NSDictionary *giftDict in gifts)
    {
        TTShowGift *gift = [[TTShowGift alloc] initWithAttributes:giftDict];
        [giftList addObject:gift];
    }

    [[NSUserDefaults standardUserDefaults] setObject:giftList forKey:@"ttshow.giftlist"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (TTShowGift *)getGiftFromID:(NSInteger)giftID
{
    NSArray *giftList = [self giftList];
    for (TTShowGift *gift in giftList)
    {
        if (gift._id == giftID)
        {
            return gift;
        }
    }
    return nil;
}

- (NSArray *)followStarList
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"ttshow.followlist"];
}

- (void)clearFollowStarList
{
    NSMutableArray *newFollowList = [NSMutableArray arrayWithCapacity:0];
    
    [[NSUserDefaults standardUserDefaults] setObject:newFollowList forKey:@"ttshow.followlist"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL)hasFollowStar:(NSInteger)star_id
{
    NSArray *followList = [self followStarList];
    for (NSNumber *follow in followList)
    {
        if (star_id == [follow integerValue])
        {
            return YES;
        }
    }
    
    return NO;
}

- (void)addFollowStar:(NSUInteger)star_id
{
    NSArray *followList = [self followStarList];
    for (NSNumber *follow in followList)
    {
        NSUInteger starID = [follow integerValue];
        if (star_id == starID)
        {
            return;
        }
    }
    
    NSMutableArray *newFollowList = [NSMutableArray arrayWithArray:followList];
    [newFollowList addObject:@(star_id)];
    
    [[NSUserDefaults standardUserDefaults] setObject:newFollowList forKey:@"ttshow.followlist"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)delFollowStar:(NSUInteger)star_id
{
    NSArray *followList = [self followStarList];
    NSMutableArray *newFollowList = [NSMutableArray arrayWithArray:followList];
    [newFollowList removeObject:@(star_id)];
    
    [[NSUserDefaults standardUserDefaults] setObject:newFollowList forKey:@"ttshow.followlist"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

// Feather Action
- (NSInteger)featherCount
{
    return [[NSUserDefaults standardUserDefaults] integerForKey:@"ttshow.feathercount"];
}

- (void)setFeatherCount:(NSInteger)featherCount
{
    if (featherCount > kTTShowFeatherCountMax)
    {
        return;
    }
    
    _featherCount = featherCount;
    [[NSUserDefaults standardUserDefaults] setInteger:featherCount forKey:@"ttshow.feathercount"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)featherIncrease
{
    NSInteger featherCount = [self featherCount];
    if (featherCount >= kTTShowFeatherCountMax)
    {
        return;
    }
    
    [[NSUserDefaults standardUserDefaults] setInteger:(featherCount + 1) forKey:@"ttshow.feathercount"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)featherDecrease
{
    NSInteger featherCount = [self featherCount];
    if (featherCount <= 0)
    {
        return;
    }
    
    [[NSUserDefaults standardUserDefaults] setInteger:(featherCount - 1) forKey:@"ttshow.feathercount"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)clearFeatherRecords
{
    [[NSUserDefaults standardUserDefaults] setInteger:(0) forKey:@"ttshow.feathercount"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

// NickName Cache.
- (NSString *)nickNameCache
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"ttshow.nickname.cache"];
}

- (void)setNickNameCache:(NSString *)nickNameCache
{
    _nickNameCache = nickNameCache;
    [[NSUserDefaults standardUserDefaults] setObject:nickNameCache forKey:@"ttshow.nickname.cache"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)nickNameCacheCopy
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"ttshow.nickname.cache.copy"];
}

- (void)setNickNameCacheCopy:(NSString *)nickNameCacheCopy
{
    _nickNameCacheCopy = nickNameCacheCopy;
    [[NSUserDefaults standardUserDefaults] setObject:nickNameCacheCopy forKey:@"ttshow.nickname.cache.copy"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL)isMeFromChatNick:(NSString *)nick
{
    NSString *nickCache = self.nickNameCacheCopy;
    if ((nick == nil || [nick isEqualToString:@""]) || (nickCache == nil || [nickCache isEqualToString:@""]))
    {
        return NO;
    }
    
    if ([nickCache isEqualToString:nick])
    {
        return YES;
    }
    
    return NO;
}

- (void)setFirstLaunch:(BOOL)firstLaunch
{
    _firstLaunch = firstLaunch;
    [[NSUserDefaults standardUserDefaults] setBool:firstLaunch forKey:@"ttshow.first.launch"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL)firstLaunch
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"ttshow.first.launch"];
}

- (void)setShowAgreement:(BOOL)showAgreement
{
    _showAgreement = showAgreement;
    [[NSUserDefaults standardUserDefaults] setBool:showAgreement forKey:@"ttshow.show.agreement"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL)showAgreement
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"ttshow.show.agreement"];
}

// Recently watch star list
- (NSArray *)recentlyWatchList
{
    // read file from disk.
    NSString *filePath = [kDocumentPath stringByAppendingPathComponent:@"recently_watch_list_file.show"];
    NSArray *recentlyList = [NSArray arrayWithContentsOfFile:filePath];
    // [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    
    NSMutableArray *list = [NSMutableArray arrayWithCapacity:0];
    for (NSData *data in recentlyList)
    {
        TTShowFollowRoomStar *star = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        [list addObject:star];
    }
    
//    LOGINFO(@"read recently list file:%@ size = %d", list, list.count);
    return list;
}

- (void)addRecentlyWatch:(TTShowFollowRoomStar *)star
{
    if (star == nil)
    {
        return;
    }
    
    NSMutableArray *recentlyList = [NSMutableArray arrayWithArray:[self recentlyWatchList]];

    // filter repeat element
    NSArray *results = [recentlyList filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF.starID = %d", star.starID]];
    if (results != nil && results.count != 0)
    {
        // exist repeat element.
        return;
    }

    NSMutableArray *watchList = [NSMutableArray arrayWithArray:recentlyList];
    
    NSData *watchListData = [NSKeyedArchiver archivedDataWithRootObject:star];
    
    [watchList addObject:watchListData];
    
    if (watchList.count >= kTTShowRecentlyWatchCountMax)
    {
        // remove first element.
        [watchList removeObjectAtIndex:0];
    }
    
    // Write file to disk.
    NSString *filePath = [kDocumentPath stringByAppendingPathComponent:@"recently_watch_list_file.show"];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath])
    {
#if 1
        NSError *error = nil;
        [[NSFileManager defaultManager] removeItemAtPath:filePath error:&error];
        if (error != nil)
        {
        }
#endif
    }
    
    if (![watchList writeToFile:filePath atomically:YES])
    {
    }
}

@end
