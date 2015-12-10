//
//  TTShowDataManager.m
//  memezhibo
//
//  Created by Xingai on 15/5/14.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "TTShowDataManager.h"
// 计算公式
// 主播等级 1000 × (N² + N - 1)
// 财富等级 100  × (N³ + 2N - 2)
#define kUserGradeMax     (88)
#define kAnchorFormula(N) (1000 * ((N)*(N) + N - 1))

#define kWealthValue(N)   (100 * ((N)*(N)*(N) + 2*N - 2))
//#define kWealthTotal(N)   (N * kWealthValue(1) + kWealthValue(N) * N * (N - 1) / 2)
//
//#define kWealthGrade22  @(118000 * 100)
//#define kWealthGrade23  @(258000 * 100)
//#define kWealthGrade24  @(518000 * 100)
//#define kWealthGrade25  @(1080000 * 100)

static NSArray *kWealthGrades = nil;
static NSArray *kStarGrades = nil;

@implementation TTShowDataManager

+ (void)initialize
{
#if 0
    kWealthGrades = @[@(kWealthTotal(1)),
                      @(kWealthTotal(2)),
                      @(kWealthTotal(3)),
                      @(kWealthTotal(4)),
                      @(kWealthTotal(5)),
                      @(kWealthTotal(6)),
                      @(kWealthTotal(7)),
                      @(kWealthTotal(8)),
                      @(kWealthTotal(9)),
                      @(kWealthTotal(10)),
                      @(kWealthTotal(11)),
                      @(kWealthTotal(12)),
                      @(kWealthTotal(13)),
                      @(kWealthTotal(14)),
                      @(kWealthTotal(15)),
                      @(kWealthTotal(16)),
                      @(kWealthTotal(17)),
                      @(kWealthTotal(18)),
                      @(kWealthTotal(19)),
                      @(kWealthTotal(20)),
                      @(kWealthTotal(21)),
                      kWealthGrade22,
                      kWealthGrade23,
                      kWealthGrade24,
                      kWealthGrade25];
#else
    kWealthGrades = @[@(1000),
                      @(5000),
                      @(15000),
                      @(30000),
                      @(50000),
                      @(80000),
                      @(150000),
                      @(300000),
                      @(500000),
                      @(700000),
                      @(1000000),
                      @(1500000),
                      @(2000000),
                      @(2500000),
                      @(3500000),
                      @(5000000),
                      @(7000000),
                      @(10000000),
                      @(15000000),
                      @(21000000),
                      @(28000000),
                      @(36000000),
                      @(45000000),
                      @(55000000),
                      @(70000000),
                      @(108000000),
                      @(168000000),
                      @(258000000)];
#endif
    kStarGrades = @[@(1000),
                    @(6000),
                    @(17000),
                    @(35000),
                    @(70000),
                    @(120000),
                    @(180000),
                    @(250000),
                    @(320000),
                    @(420000),
                    @(550000),
                    @(700000),
                    @(900000),
                    @(1100000),
                    @(1400000),
                    @(1700000),
                    @(2000000),
                    @(2300000),
                    @(2700000),
                    @(3100000),
                    @(3600000),
                    @(4200000),
                    @(4800000),
                    @(5400000),
                    @(6000000),
                    @(7000000),
                    @(8000000),
                    @(9000000),
                    @(10000000),
                    @(12000000),
                    @(14000000),
                    @(16000000),
                    @(18000000),
                    @(20000000),
                    @(23000000),
                    @(28000000),
                    @(33000000),
                    @(38000000),
                    @(43000000),
                    @(48000000),
                    @(54000000),
                    @(60000000),
                    @(66000000),
                    @(72000000),
                    @(78000000),
                    @(88000000),
                    @(98000000),
                    @(108000000),
                    @(118000000),
                    @(128000000),
                    @(148000000),
                    @(168000000),
                    @(198000000),
                    @(228000000),
                    @(268000000)];
}


- (id) init
{
    self = [super init];
    if(self)
    {
        [self openDatabase];
        _defaults = [[TTShowDefaults alloc] init];
        _remote = [TTShowRemote sharedInstance];
        _filter = [FilterCondition sharedInstance];
//        _me = [TTShowUser unarchiveUser];

        _global = [DataGlobalKit sharedInstance];
        _alixpay = [TTAlixpay sharedInstance];
//
        _synRemote = [[HttpClientSyn alloc] init];
        _imSocket = [IMSocket getInstance];
        _groupSocket = [GroupSocket getInstance];
        
//        [self initCache];
        [self initRequest];
    }
    return self;   
}

- (void)initRequest
{
    [self.remote loginWhenAppStart];
    [_remote requestSensitiveNickNames:nil failBlock:nil];
    [_remote requestSensitiveWords:nil failBlock:nil];
}




- (void)initCache
{
//    [Cache getFriendListAsync:^(TMCache *cache, NSString *key, id object) {
//        if ([object isKindOfClass:[NSArray class]]) {
//            self.friendList = object;
//        }
//    }];
//    [Cache getMyGroupListAsync:^(TMCache *cache, NSString *key, id object) {
//        if ([object isKindOfClass:[NSArray class]]) {
//            self.myGroupList = object;
//        }
//    }];
    NSMutableDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultKeyGroupsNotify];
    if (dict) {
        self.groupSwitch = dict;
    } else {
        self.groupSwitch = [[NSMutableDictionary alloc] initWithCapacity:0];
    }
    id messageNotifyOn = [[NSUserDefaults standardUserDefaults] objectForKey:kNSUserDefaultKeyMessageNotifyOn];
    if (!messageNotifyOn) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kNSUserDefaultKeyMessageNotifyOn];
    }
}

- (void)openDatabase
{
//    _db = [[TTShowDatabase alloc] initWithPath:[FileUtils pathForDocumentFiles:@"ttshow"]];
    [_db open];
    if(_db.isNewDB)
    {
        // Loading default data.
    }
    
    [self loadDBAccessComponents];
}

- (void)loadDBAccessComponents
{
    // common
    _commonDA = [[CommonDataAccess alloc] init];
    _commonDA.db = _db;
}

// Global shared data.
- (void)retrieveFavorStar
{
    [self.remote followingListWithCompletion:^(NSArray *array, NSError *error) {
        if (!error)
        {
            for (TTShowFollowRoomStar *star in array)
            {
                [self.defaults addFollowStar:star.starID];
            }
        }
    }];
}

// if user login or logout.
- (void)updateUser
{
    if (_me)
    {
        _me = nil;
    }
    _me = [TTShowUser unarchiveUser];
}

- (NSDictionary *)anchorGrade:(long long int)bean_count_total
{
    NSUInteger nAnchorGrade = 0;
    long long int nNeedBeanCountIfUpgrade = 0;
    long long int nCurrentBeanCount = 0;
    
    for (NSInteger i = 0; i < kStarGrades.count; i++)
    {
        if (i == kStarGrades.count - 1)
        {
            if (bean_count_total >= [kStarGrades[i] longLongValue])
            {
                nCurrentBeanCount = bean_count_total - [kStarGrades[i] longLongValue];
                nNeedBeanCountIfUpgrade = 0;
                nAnchorGrade = (i + 1);
                break;
            }
        }
        else
        {
            if (i == 0 && bean_count_total < [kStarGrades[i] longLongValue])
            {
                nCurrentBeanCount = bean_count_total;
                nNeedBeanCountIfUpgrade = [kStarGrades[i] longLongValue];
                nAnchorGrade = 0;
                break;
            }
            else if (bean_count_total >= [kStarGrades[i] longLongValue]
                     && bean_count_total < [kStarGrades[i + 1] longLongValue])
            {
                nCurrentBeanCount = bean_count_total - [kStarGrades[i] longLongValue];
                nNeedBeanCountIfUpgrade = [kStarGrades[i + 1] longLongValue] - [kStarGrades[i] longLongValue];
                nAnchorGrade = (i + 1);
                break;
            }
        }
    }
    
    
    NSMutableDictionary *result = [[NSMutableDictionary alloc] init];
    [result setValue:@(nCurrentBeanCount) forKey:@"CurrentBeanCount"];
    [result setValue:@(nNeedBeanCountIfUpgrade) forKey:@"NeedBeanCountIfUpgrade"];
    [result setValue:@(nAnchorGrade) forKey:@"AnchorGrade"];
    
    return result;
}

- (NSInteger)anchorLevel:(long long int)bean_count_total
{
    
    NSDictionary *result = [self anchorGrade:bean_count_total];
    return [[result valueForKey:@"AnchorGrade"] integerValue];
}

- (NSInteger)wealthLevel:(long long int)coin_spend_total
{
    NSDictionary *wealthDict = [self wealthGrade:coin_spend_total];
    NSNumber *wealthNumber = [wealthDict valueForKey:@"WealthGrade"];
    return [wealthNumber integerValue];
}

- (NSInteger)anchorUpgradeNeedBeanCount:(long long int)bean_count_total
{
    NSDictionary *result = [self anchorGrade:bean_count_total];
    return [[result valueForKey:@"NeedBeanCountIfUpgrade"] integerValue];
}

- (NSInteger)anchorCurrentBeanCount:(long long int)bean_count_total
{
    NSDictionary *result = [self anchorGrade:bean_count_total];
    return [[result valueForKey:@"CurrentBeanCount"] integerValue];
}

- (NSDictionary *)wealthGrade:(long long int)coin_spend_total
{
    // WealthGrade
    NSUInteger nWealthGrade = 0;
    long long int nNeedCoinCountIfUpgrade = 0;
    long long int nCurrentCoinCount = 0;
    
    for (NSInteger i = 0; i < kWealthGrades.count; i++)
    {
        if (i == kWealthGrades.count - 1)
        {
            if (coin_spend_total >= [kWealthGrades[i] longLongValue])
            {
                nCurrentCoinCount = coin_spend_total - [kWealthGrades[i] longLongValue];
                nNeedCoinCountIfUpgrade = 0;
                nWealthGrade = (i + 1);
                break;
            }
        }
        else
        {
            if (i == 0 && coin_spend_total < [kWealthGrades[i] longLongValue])
            {
                nCurrentCoinCount = coin_spend_total;
                nNeedCoinCountIfUpgrade = [kWealthGrades[i] longLongValue];
                nWealthGrade = 0;
                break;
            }
            else if (coin_spend_total >= [kWealthGrades[i] longLongValue]
                     && coin_spend_total < [kWealthGrades[i + 1] longLongValue])
            {
                nCurrentCoinCount = coin_spend_total - [kWealthGrades[i] longLongValue];
                nNeedCoinCountIfUpgrade = [kWealthGrades[i + 1] longLongValue] - [kWealthGrades[i] longLongValue];
                nWealthGrade = (i + 1);
                break;
            }
        }
    }
    
    NSDictionary *result = @{@"CurrentCoinCount": @(nCurrentCoinCount),
                             @"NeedCoinCountIfUpgrade" : @(nNeedCoinCountIfUpgrade),
                             @"WealthGrade" : @(nWealthGrade)};
    
    return result;
}


@end
