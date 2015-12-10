//
//  TTShowRecord.m
//  TTShow
//
//  Created by twb on 14-5-20.
//  Copyright (c) 2014年 twb. All rights reserved.
//

#import "TTShowRecord.h"

#pragma mark - Charge records part.

@implementation TTShowRecord

- (id)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    /*
     @property (nonatomic, strong) NSString *_id;
     @property (nonatomic, assign) long long int coin;
     @property (nonatomic, strong) NSString *qd;
     @property (nonatomic, strong) NSDictionary *session;
     @property (nonatomic, assign) long long int timestamp;
     @property (nonatomic, assign) NSInteger user_id;
     @property (nonatomic, strong) NSString *via;
     @property (nonatomic, strong) NSString *via_desc;
     */
    
    self._id = attributes[@"_id"];
    self.coin = [attributes[@"coin"] longLongValue];
    self.qd = attributes[@"qd"];
    self.session = attributes[@"session"];
    self.timestamp = [attributes[@"timestamp"] longLongValue];
    self.user_id = [attributes[@"user_id"] integerValue];
    self.via = attributes[@"via"];
    self.via_desc = attributes[@"via_desc"];
    
    return self;
}

@end

#pragma mark - Lucky part.

@implementation LuckySessionContent

- (id)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self._id = [attributes[@"_id"] integerValue];
    self.category_id = [attributes[@"category_id"] integerValue];
    self.coin_price = [attributes[@"coin_price"] integerValue];
    self.name = attributes[@"name"];
    self.count = [attributes[@"count"] integerValue];
    self.xy_star_id = [attributes[@"xy_star_id"] integerValue];
    self.earned = [attributes[@"earned"] integerValue];
    self.xy_nick = attributes[@"xy_nick"];
    
    return self;
}

@end

@implementation LuckySession

- (id)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.nick_name = [attributes[@"nick_name"] stringByUnescapingFromHTML];
    self._id = [attributes[@"_id"] integerValue];
    self.priv = [attributes[@"priv"] integerValue];
    self.spend = [attributes[@"spend"] integerValue];
    self.data = attributes[@"data"];
    
    return self;
}

@end

@implementation TTShowLuckyRecord

- (id)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self._id = attributes[@"_id"];
    self.timestamp = [attributes[@"timestamp"] longLongValue];
    self.got = [attributes[@"got"] integerValue];
    self.power = [attributes[@"power"] integerValue];
    self.session = attributes[@"session"];
    self.room = [attributes[@"room"] integerValue];
    
    return self;
}

@end

#pragma mark - Consume part.

@implementation ConsumeRecordSessionData

- (id)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    /*
     @property (nonatomic, assign) NSInteger _id;
     @property (nonatomic, assign) NSInteger category_id;
     @property (nonatomic, assign) NSInteger coin_price;
     @property (nonatomic, strong) NSString *name;
     @property (nonatomic, assign) NSInteger count;
     @property (nonatomic, assign) NSInteger xy_star_id;
     @property (nonatomic, assign) NSInteger earned;
     @property (nonatomic, strong) NSString *xy_nick;
     */
    
    self._id = [attributes[@"_id"] integerValue];
    self.category_id = [attributes[@"category_id"] integerValue];
    self.coin_price = [attributes[@"coin_price"] integerValue];
    self.name = attributes[@"name"];
    self.count = [attributes[@"count"] integerValue];
    self.xy_star_id = [attributes[@"xy_star_id"] integerValue];
    self.earned = [attributes[@"earned"] integerValue];
    self.xy_nick = attributes[@"xy_nick"];
    
    return self;
}

@end

@implementation ConsumeRecordSession

- (id)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    /*
     @property (nonatomic, assign) NSInteger priv;
     @property (nonatomic, strong) NSString *nick_name;
     @property (nonatomic, assign) NSInteger spend;
     @property (nonatomic, assign) NSInteger _id;
     @property (nonatomic, strong) NSDictionary *data;
     */
    self.priv = [attributes[@"priv"] integerValue];
    self.nick_name = [attributes[@"nick_name"] stringByUnescapingFromHTML];
    self.spend = [attributes[@"spend"] integerValue];
    self._id = [attributes[@"_id"] integerValue];
    self.data = attributes[@"data"];
    
    return self;
}

@end

@implementation TTShowConsumeRecord

- (id)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    /*
     @property (nonatomic, strong) NSString *_id;
     @property (nonatomic, assign) long long int timestamp;
     @property (nonatomic, strong) NSDictionary *session;
     @property (nonatomic, assign) NSInteger family_id;
     @property (nonatomic, strong) NSString *type;
     @property (nonatomic, assign) NSInteger cost;
     @property (nonatomic, strong) NSString *live;
     @property (nonatomic, assign) NSInteger room;
     @property (nonatomic, strong) NSString *qd;
     */
    self._id = attributes[@"_id"];
    self.timestamp = [attributes[@"timestamp"] longLongValue];
    self.session = attributes[@"session"];
    self.family_id = [attributes[@"family_id"] integerValue];
    self.type = attributes[@"type"];
    self.cost = [attributes[@"cost"] integerValue];
    self.live = attributes[@"live"];
    self.room = [attributes[@"room"] integerValue];
    self.qd = attributes[@"qd"];
    
    return self;
}

@end

#pragma mark - Received Gift records part.

@implementation RecGiftSessionData

- (id)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    /*
     @property (nonatomic, assign) NSInteger _id;
     @property (nonatomic, strong) NSString *name;
     @property (nonatomic, assign) NSInteger category_id;
     @property (nonatomic, assign) NSInteger coin_price;
     @property (nonatomic, assign) NSInteger count;
     @property (nonatomic, assign) NSInteger xy_user_id;
     @property (nonatomic ,assign) NSInteger earned;
     @property (nonatomic, strong) NSString *xy_nick;
     */
    self._id = [attributes[@"_id"] integerValue];
    self.name = attributes[@"name"];
    self.category_id = [attributes[@"category_id"] integerValue];
    self.coin_price = [attributes[@"coin_price"] integerValue];
    self.count = [attributes[@"count"] integerValue];
    self.xy_user_id = [attributes[@"xy_user_id"] integerValue];
    self.earned = [attributes[@"earned"] integerValue];
    self.xy_nick = [attributes[@"xy_nick"] stringByUnescapingFromHTML];
    
    return self;
}

@end

@implementation RecGiftSession

- (id)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    /*
     @property (nonatomic, assign) NSInteger spend;
     @property (nonatomic, assign) NSInteger _id;
     @property (nonatomic, assign) NSInteger priv;
     @property (nonatomic, strong) NSString *nick_name;
     @property (nonatomic, strong) NSDictionary *data;
     */
    self.spend = [attributes[@"spend"] integerValue];
    self._id = [attributes[@"_id"] integerValue];
    self.priv = [attributes[@"priv"] integerValue];
    self.nick_name = [attributes[@"nick_name"] stringByUnescapingFromHTML];
    self.data = attributes[@"data"];
    
    return self;
}

@end

@implementation TTShowRecGiftRecord

- (id)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    /*
     @property (nonatomic, strong) NSString *_id;
     @property (nonatomic, assign) long long int timestamp;
     @property (nonatomic, strong) NSDictionary *session;
     @property (nonatomic, strong) NSString *type;
     @property (nonatomic, assign) NSInteger cost;
     @property (nonatomic, strong) NSString *live;
     @property (nonatomic, assign) NSInteger room;
     @property (nonatomic, strong) NSString *qd;
     */
    
    self._id = attributes[@"_id"];
    self.timestamp = [attributes[@"timestamp"] longLongValue];
    self.session = attributes[@"session"];
    self.type = attributes[@"type"];
    self.cost = [attributes[@"cost"] integerValue];
    self.live = attributes[@"live"];
    self.room = [attributes[@"room"] integerValue];
    self.qd = attributes[@"qd"];
    
    return self;
}

@end




