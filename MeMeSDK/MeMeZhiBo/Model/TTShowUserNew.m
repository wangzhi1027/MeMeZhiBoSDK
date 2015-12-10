//
//  TTShowUserNew.m
//  TTShow
//
//  Created by twb on 13-6-7.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import "TTShowUserNew.h"


@implementation FamilyNew

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
    
    self.family_id = [[attributes valueForKey:@"family_id"] integerValue];
    self.family_priv = [[attributes valueForKey:@"family_priv"] integerValue];
    self.timestamp = [[attributes valueForKey:@"timestamp"] longLongValue];
    self.family_name = [attributes valueForKey:@"family_name"];
    self.badge_name = [attributes valueForKey:@"badge_name"];
//    self.week_support = [[attributes valueForKey:@"week_support"] integerValue];
    
    return self;
}

@end

#pragma mark - Star Class.

@implementation TTShowUserNewStar

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

#pragma mark - User Class.

@implementation TTShowUserNew

- (id)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    /*
     @property (nonatomic, assign) NSUInteger _id;
     @property (nonatomic, strong) NSString *access_token;
     @property (nonatomic, assign) NSUInteger expires_at;
     @property (nonatomic, assign) NSUInteger expires_in;
     @property (nonatomic, strong) NSString *nick_name;
     @property (nonatomic, strong) NSString *pic;
     @property (nonatomic, assign) NSUInteger sex;
     @property (nonatomic, strong) NSString * tuid;
     @property (nonatomic, strong) NSString *user_name;
     @property (nonatomic, strong) NSString *via;
     @property (nonatomic, assign) NSUInteger weibo_enabled;
     @property (nonatomic, assign) NSInteger rank;
     
     @property (nonatomic, strong) NSString *location;
     @property (nonatomic, assign) NSUInteger constellation;
     @property (nonatomic, assign) NSUInteger stature;
     @property (nonatomic, assign) NSUInteger priv;
     @property (nonatomic, assign) NSUInteger vip;
     @property (nonatomic, assign) NSUInteger vip_expires;
     */
    
    // User.
    self.momo_num = [[attributes valueForKey:@"mm_no"] unsignedIntegerValue];
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
    self.bean_rank = [attributes[@"bean_rank"] integerValue];
    
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
    self.family = [attributes valueForKey:@"family"];

    
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
    [aCoder encodeObject:@(self.bean_rank) forKey:@"bean_rank"];
    
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
        self.bean_rank = [[aDecoder decodeObjectForKey:@"bean_rank"] integerValue];
        
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

+ (TTShowUserNew *)unarchiveUser
{
    @autoreleasepool
    {
        NSData *userData = [[NSUserDefaults standardUserDefaults] objectForKey:kUserKeyedArchiverKeyName];
        TTShowUserNew *user = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
        return user;
    }
}

+ (void)archiveUser:(TTShowUserNew *)user
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
        TTShowUserNew *user = [self unarchiveUser];
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
    if (![TTShowUserNew archiveDataValid])
    {
        return nil;
    }
    
    return [TTShowUserNew unarchiveUser].access_token;
}

+ (NSString *)nick_name
{
    if (![TTShowUserNew archiveDataValid])
    {
        return nil;
    }
    
    return [[TTShowUserNew unarchiveUser].nick_name stringByUnescapingFromHTML];
}

+ (long long int)bean_count
{
    if (![TTShowUserNew archiveDataValid])
    {
        return 0;
    }
    
    Finance *finance = [[Finance alloc] initWithAttributes:[TTShowUserNew unarchiveUser].finance];
    
    return finance.bean_count;
}

+ (long long int)coin_spend_total
{
    if (![TTShowUserNew archiveDataValid])
    {
        return 0;
    }
    
    Finance *finance = [[Finance alloc] initWithAttributes:[TTShowUserNew unarchiveUser].finance];
    
    return finance.coin_spend_total;
}

+ (void)logout
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUserKeyedArchiverKeyName];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
