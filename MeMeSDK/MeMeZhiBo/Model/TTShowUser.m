//
//  TTShowUser.m
//  TTShow
//
//  Created by twb on 13-6-7.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import "TTShowUser.h"

#pragma mark - Star Class.

@implementation TTShowUserStar

- (id)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    /*
     @property (nonatomic, assign) NSUInteger room_id;
     @property (nonatomic, assign) NSUInteger timestamp;
     */
    self.room_id = [[attributes valueForKey:@"room_id"] unsignedIntegerValue];
    self.timestamp = [[attributes valueForKey:@"timestamp"] unsignedIntegerValue];
    
    return self;
}

#pragma mark - NSCoding Protocal

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:[NSNumber numberWithUnsignedInteger:self.room_id] forKey:@"room_id"];
    [aCoder encodeObject:[NSNumber numberWithUnsignedInteger:self.timestamp] forKey:@"timestamp"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        self.room_id = [[aDecoder decodeObjectForKey:@"room_id"] unsignedIntegerValue];
        self.timestamp = [[aDecoder decodeObjectForKey:@"timestamp"] unsignedIntegerValue];
    }
    return self;
}

@end

#pragma mark - Finance Class.

@implementation Finance

- (id)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (!self) {
        return nil;
    }

    /*
     @property (nonatomic, assign) NSUInteger bean_count;
     @property (nonatomic, assign) NSUInteger bean_count_total;
     @property (nonatomic, assign) NSUInteger coin_count;
     @property (nonatomic, assign) NSUInteger coin_spend_total;
     @property (nonatomic, assign) NSUInteger spend_star_level;
     @property (nonatomic, assign) NSInteger feather_count;
     @property (nonatomic, assign) long long int feather_last;
     @property (nonatomic, assign) long long int feather_send_total;
     */
    
    self.bean_count = [[attributes valueForKey:@"bean_count"] longLongValue];
    self.bean_count_total = [[attributes valueForKey:@"bean_count_total"] longLongValue];
    self.coin_count = [[attributes valueForKey:@"coin_count"] longLongValue];
    self.coin_spend_total = [[attributes valueForKey:@"coin_spend_total"] longLongValue];
    self.feather_count = [[attributes valueForKey:@"feather_count"] integerValue];
    self.feather_last = [[attributes valueForKey:@"feather_last"] longLongValue];
    self.feather_send_total = [[attributes valueForKey:@"feather_send_total"] longLongValue];
    
    return self;
}

-(NSDictionary *)parse2Dict
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setValue:@(self.bean_count) forKey:@"bean_count"];
    [dict setValue:@(self.bean_count_total) forKey:@"bean_count_total"];
    [dict setValue:@(self.coin_count) forKey:@"coin_count"];
    [dict setValue:@(self.coin_spend_total) forKey:@"coin_spend_total"];
    [dict setValue:@(self.feather_count) forKey:@"feather_count"];
    [dict setValue:@(self.feather_last) forKey:@"feather_last"];
    [dict setValue:@(self.feather_send_total) forKey:@"feather_send_total"];
    return dict;
}

#pragma mark - NSCoding Protocal

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:[NSNumber numberWithUnsignedInteger:self.bean_count] forKey:@"bean_count"];
    [aCoder encodeObject:[NSNumber numberWithUnsignedInteger:self.bean_count_total] forKey:@"bean_count_total"];
    [aCoder encodeObject:[NSNumber numberWithUnsignedInteger:self.coin_count] forKey:@"coin_count"];
    [aCoder encodeObject:[NSNumber numberWithUnsignedInteger:self.coin_spend_total] forKey:@"coin_spend_total"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        self.bean_count = [[aDecoder decodeObjectForKey:@"bean_count"] unsignedIntegerValue];
        self.bean_count_total = [[aDecoder decodeObjectForKey:@"bean_count_total"] unsignedIntegerValue];
        self.coin_count = [[aDecoder decodeObjectForKey:@"coin_count"] unsignedIntegerValue];
        self.coin_spend_total = [[aDecoder decodeObjectForKey:@"coin_spend_total"] unsignedIntegerValue];
    }
    return self;
}

@end

#pragma mark - User Class.

@implementation TTShowUser

- (id)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (!self) {
        return nil;
    }

    // User.
    self._id = [[attributes valueForKey:@"_id"] unsignedIntegerValue];
    self.access_token = [attributes valueForKey:@"access_token"];
    self.expires_at = [[attributes valueForKey:@"expires_at"] unsignedIntegerValue];
    self.expires_in = [[attributes valueForKey:@"expires_in"] unsignedIntegerValue];
    self.nick_name = [[attributes valueForKey:@"nick_name"] stringByUnescapingFromHTML];
    self.pic = [attributes valueForKey:@"pic"];
    if ([attributes valueForKey:@"sex"])
    {
        self.sex = [[attributes valueForKey:@"sex"] integerValue];
    }
//    self.tuid = [attributes valueForKey:@"tuid"];
    self.user_name = [attributes valueForKey:@"user_name"];
    self.via = [attributes valueForKey:@"via"];
    self.weibo_enabled = [[attributes valueForKey:@"weibo_enabled"] unsignedIntegerValue];
    self.rank = [attributes[@"rank"] integerValue];
    
    self.location = [attributes valueForKey:@"location"];
    self.constellation = [[attributes valueForKey:@"constellation"] unsignedIntegerValue];
    self.stature = [[attributes valueForKey:@"stature"] unsignedIntegerValue];
    self.priv = [[attributes valueForKey:@"priv"] unsignedIntegerValue];
    self.vip = [[attributes valueForKey:@"vip"] unsignedIntegerValue];
    self.vip_expires = [[attributes valueForKey:@"vip_expires"] longLongValue];
    
    // Star.
    self.star = [attributes valueForKey:@"star"];
    
    // Finance.
    self.finance = [attributes valueForKey:@"finance"];
    
    // Gift List
    self.gift_list = [attributes valueForKey:@"gift_list"];
    
    self.car = [attributes valueForKey:@"car"];
    self.live = [[attributes valueForKey:@"live"] boolValue];
    self.tag = [attributes valueForKey:@"tag"];
    self.week_spend = [[attributes valueForKey:@"week_spend"] longLongValue];
    
    return self;
}

#pragma mark - NSCoding Protocal

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:[NSNumber numberWithUnsignedInteger:self._id] forKey:@"_id"];
    [aCoder encodeObject:self.access_token forKey:@"access_token"];
    [aCoder encodeObject:[NSNumber numberWithUnsignedInteger:self.expires_at] forKey:@"expires_at"];
    [aCoder encodeObject:[NSNumber numberWithUnsignedInteger:self.expires_in] forKey:@"expires_in"];
    [aCoder encodeObject:self.nick_name forKey:@"nick_name"];
    [aCoder encodeObject:self.pic forKey:@"pic"];
    [aCoder encodeObject:[NSNumber numberWithUnsignedInteger:self.sex] forKey:@"sex"];
//    [aCoder encodeObject:self.tuid forKey:@"tuid"];
    [aCoder encodeObject:self.user_name forKey:@"user_name"];
    [aCoder encodeObject:self.via forKey:@"via"];
    [aCoder encodeObject:[NSNumber numberWithUnsignedInteger:self.weibo_enabled] forKey:@"weibo_enabled"];
    [aCoder encodeObject:@(self.rank) forKey:@"rank"];
    
    [aCoder encodeObject:self.location forKey:@"location"];
    [aCoder encodeObject:[NSNumber numberWithUnsignedInteger:self.constellation] forKey:@"constellation"];
    [aCoder encodeObject:[NSNumber numberWithUnsignedInteger:self.stature] forKey:@"stature"];
    [aCoder encodeObject:[NSNumber numberWithUnsignedInteger:self.priv] forKey:@"priv"];
    [aCoder encodeObject:[NSNumber numberWithUnsignedInteger:self.vip] forKey:@"vip"];
    [aCoder encodeObject:@(self.vip_expires) forKey:@"vip_expires"];
    
    [aCoder encodeObject:self.star forKey:@"star"];
    [aCoder encodeObject:self.finance forKey:@"finance"];
    [aCoder encodeObject:self.gift_list forKey:@"gift_list"];
    
    [aCoder encodeObject:self.car forKey:@"car"];
    [aCoder encodeObject:@(self.live) forKey:@"live"];
    [aCoder encodeObject:self.tag forKey:@"tag"];
    [aCoder encodeObject:@(self.week_spend) forKey:@"week_spend"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        self._id = [[aDecoder decodeObjectForKey:@"_id"] unsignedIntegerValue];
        self.access_token = [aDecoder decodeObjectForKey:@"access_token"];
        self.expires_at = [[aDecoder decodeObjectForKey:@"expires_at"] unsignedIntegerValue];
        self.expires_in = [[aDecoder decodeObjectForKey:@"expires_in"] unsignedIntegerValue];
        self.nick_name = [aDecoder decodeObjectForKey:@"nick_name"];
        self.pic = [aDecoder decodeObjectForKey:@"pic"];
        self.sex = [[aDecoder decodeObjectForKey:@"sex"] unsignedIntegerValue];
//        self.tuid = [aDecoder decodeObjectForKey:@"tuid"];
        self.user_name = [aDecoder decodeObjectForKey:@"user_name"];
        self.via = [aDecoder decodeObjectForKey:@"via"];
        self.weibo_enabled = [[aDecoder decodeObjectForKey:@"weibo_enabled"] unsignedIntegerValue];
        self.rank = [[aDecoder decodeObjectForKey:@"rank"] integerValue];
        
        self.location = [aDecoder decodeObjectForKey:@"location"];
        self.constellation = [[aDecoder decodeObjectForKey:@"constellation"] unsignedIntegerValue];
        self.stature = [[aDecoder decodeObjectForKey:@"stature"] unsignedIntegerValue];
        self.priv = [[aDecoder decodeObjectForKey:@"priv"] unsignedIntegerValue];
        self.vip = [[aDecoder decodeObjectForKey:@"vip"] unsignedIntegerValue];
        self.vip_expires = [[aDecoder decodeObjectForKey:@"vip_expires"] longLongValue];
        
        self.star = [aDecoder decodeObjectForKey:@"star"];
        self.finance = [aDecoder decodeObjectForKey:@"finance"];
        self.gift_list = [aDecoder decodeObjectForKey:@"gift_list"];
        
        self.car = [aDecoder decodeObjectForKey:@"car"];
        self.live = [[aDecoder decodeObjectForKey:@"live"] boolValue];
        self.tag = [aDecoder decodeObjectForKey:@"tag"];
        self.week_spend = [[aDecoder decodeObjectForKey:@"week_spend"] longLongValue];
    }
    return self;
}

+ (TTShowUser *)unarchiveUser
{
    @autoreleasepool
    {
        NSData *userData = [[NSUserDefaults standardUserDefaults] objectForKey:kUserKeyedArchiverKeyName];
        TTShowUser *user = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
        return user;
    }
}

+ (void)archiveUser:(TTShowUser *)user
{
    @autoreleasepool
    {
        NSData *userData = [NSKeyedArchiver archivedDataWithRootObject:user];
        [[NSUserDefaults standardUserDefaults] setObject:userData forKey:kUserKeyedArchiverKeyName];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

+ (BOOL)archiveDataValid
{
    @autoreleasepool
    {
        TTShowUser *user = [self unarchiveUser];
        if (user._id != 0
            // Because third party logining is nil.
            //        && (user.user_name != nil && ![user.user_name isEqualToString:@""])
            && (user.nick_name != nil && ![user.nick_name isEqualToString:@""])
            && (user.access_token != nil && ![user.access_token isEqualToString:@""]))
        {
            return YES;
        }
        return NO;
    }
}

+ (NSString *)access_token
{
    if (![TTShowUser archiveDataValid])
    {
        return nil;
    }
    
    return [TTShowUser unarchiveUser].access_token;
}

+ (NSString *)nick_name
{
    if (![TTShowUser archiveDataValid])
    {
        return nil;
    }
    
    return [[TTShowUser unarchiveUser].nick_name stringByUnescapingFromHTML];
}

+ (long long int)bean_count
{
    if (![TTShowUser archiveDataValid])
    {
        return 0;
    }
    
    Finance *finance = [[Finance alloc] initWithAttributes:[TTShowUser unarchiveUser].finance];
    
    return finance.bean_count;
}

+ (long long int)coin_spend_total
{
    if (![TTShowUser archiveDataValid])
    {
        return 0;
    }
    
    Finance *finance = [[Finance alloc] initWithAttributes:[TTShowUser unarchiveUser].finance];
    
    return finance.coin_spend_total;
}

+ (void)logout
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUserKeyedArchiverKeyName];
    [[NSUserDefaults standardUserDefaults] synchronize];

}

@end

@implementation TTShowAudience

- (id)initWithAttributes:(NSDictionary *)attributes
{
    self = [super initWithAttributes:attributes];
    if (!self) {
        return nil;
    }
    
    NSNumber *cs = [attributes valueForKey:@"coin_spend"];
    if (![cs isKindOfClass:[NSNull class]])
    {
        self.coin_spend = [cs longLongValue];
    }
    
    NSNumber *av = [attributes valueForKey:@"avtive_value"];
    if (![av isKindOfClass:[NSNull class]])
    {
        self.active_value = [av integerValue];
    }
    
    return self;
}

- (id)initWithUser:(TTShowUser *)user
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    // User.
    self._id = user._id;
    self.access_token = user.access_token;
    self.expires_at = user.expires_at;
    self.expires_in = user.expires_in;
    self.nick_name = user.nick_name;
    self.pic = user.pic;
    self.sex = user.sex;
//    self.tuid = user.tuid;
    self.user_name = user.user_name;
    self.via = user.via;
    self.weibo_enabled = user.weibo_enabled;
    
    self.location = user.location;
    self.constellation = user.constellation;
    self.stature = user.stature;
    self.priv = user.priv;
    self.vip = user.vip;
    self.vip_expires = user.vip_expires;
    
    // Star.
    self.star = user.star;
    
    // Finance.
    self.finance = user.finance;
    
    // Gift List
    self.gift_list = user.gift_list;
    
    self.car = user.car;
    self.live = user.live;
    self.tag = user.tag;
    self.week_spend = user.week_spend;
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    
    [aCoder encodeObject:@(self.coin_spend) forKey:@"coin_spend"];
    [aCoder encodeObject:@(self.active_value) forKey:@"avtive_value"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (!self) {
        return nil;
    }

    self.coin_spend = [[aDecoder decodeObjectForKey:@"coin_spend"] integerValue];
    self.active_value = [[aDecoder decodeObjectForKey:@"avtive_value"] integerValue];
    
    return self;
}

@end
