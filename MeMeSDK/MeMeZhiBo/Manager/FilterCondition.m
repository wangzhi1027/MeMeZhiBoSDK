//
//  FilterCondition.m
//  memezhibo
//
//  Created by Xingai on 15/5/14.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "FilterCondition.h"

@implementation FilterCondition


@synthesize UDID = _UDID;
@synthesize deviceTokenRegistered = _deviceTokenRegistered;

@synthesize firstRegisterLogin = _firstRegisterLogin;
@synthesize firstSendGift = _firstSendGift;
@synthesize firstFavorStar = _firstFavorStar;
@synthesize firstEditNick = _firstEditNick;
@synthesize firstCharge = _firstCharge;
@synthesize lastGiftSendCount = _lastGiftSendCount;
@synthesize lastLoginUserName = _lastLoginUserName;

+ (instancetype)sharedInstance
{
    static id instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init];
    });
    
    return instance;
}

- (void)setUDID:(NSString *)UDID
{
    _UDID = UDID;
    
    [[NSUserDefaults standardUserDefaults] setObject:UDID forKey:@"UDID"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)UDID
{

    return [[NSUserDefaults standardUserDefaults] objectForKey:@"UDID"];
}

- (NSString *)baseUrlStr
{
    if (self.testModeOn)
    {
        return @"http://test.api.memeyule.com";
    }
    else
    {
        return @"http://api.memeyule.com";
    }
}

- (NSString *)baseVideoUrlStr
{
    if (self.testModeOn)
    {
        return @"http://test.ws.memeyule.com:80";
    }
    else
    {
        return @"http://ws.memeyule.com:80";
    }
}

- (NSString *)baseRTMPMediaURL
{
    if (self.testModeOn)
    {
        return @"rtmp://t.ws.sumeme.com/meme/";
    }
    else
    {
        return @"rtmp://l.ws.sumeme.com/meme/";
    }
}

- (NSString *)videoPrivateKey
{
    return @"f4_d0s3gp_zfir5jr3qwxv19";
}

- (NSString *)baseSocketUrlStr
{
    if (self.testModeOn)
    {
        return @"test.ws.memeyule.com";
    }
    else
    {
        return @"ws.memeyule.com";
    }
}

- (void)setDeviceTokenRegistered:(BOOL)deviceTokenRegistered
{
    _deviceTokenRegistered = deviceTokenRegistered;
    [[NSUserDefaults standardUserDefaults] setBool:deviceTokenRegistered forKey:@"DeviceTokenRegistered"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL)deviceTokenRegistered
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"DeviceTokenRegistered"];
}

- (void)setFirstRegisterLogin:(BOOL)firstRegisterLogin
{
    _firstRegisterLogin = firstRegisterLogin;
    [[NSUserDefaults standardUserDefaults] setBool:firstRegisterLogin forKey:@"firstRegisterLogin"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


- (NSInteger)lastGiftSendCount
{
    NSInteger sendCount = [[NSUserDefaults standardUserDefaults] integerForKey:@"TT.lastGiftSendCount"];
    if (sendCount == 0)
    {
        sendCount = kRoomGiftDefaultSendCount;
    }
    return sendCount;
}

- (void)setLastGiftSendCount:(NSInteger)lastGiftSendCount
{
    _lastGiftSendCount = lastGiftSendCount;
    [[NSUserDefaults standardUserDefaults] setInteger:lastGiftSendCount forKey:@"TT.lastGiftSendCount"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)lastLoginUserName
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"TT.lastLoginUserName"];
}

- (void)setLastLoginUserName:(NSString *)lastLoginUserName
{
    _lastLoginUserName = lastLoginUserName;
    [[NSUserDefaults standardUserDefaults] setObject:lastLoginUserName forKey:@"TT.lastLoginUserName"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

// Register.
- (void)clearTaskRecords
{
    self.firstRegisterLogin = NO;
    self.firstSendGift = NO;
    self.firstFavorStar = NO;
    self.firstEditNick = NO;
    self.firstCharge = NO;
}

- (void)setFirstFavorStar:(BOOL)firstFavorStar
{
    _firstFavorStar = firstFavorStar;
    [[NSUserDefaults standardUserDefaults] setBool:firstFavorStar forKey:@"firstFavorStar"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


@end
