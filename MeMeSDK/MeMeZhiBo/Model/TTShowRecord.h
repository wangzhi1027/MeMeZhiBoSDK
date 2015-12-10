//
//  TTShowRecord.h
//  TTShow
//
//  Created by twb on 14-5-20.
//  Copyright (c) 2014年 twb. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - Charge records part.

@interface TTShowRecord : NSObject

// Charge Records.
@property (nonatomic, strong) NSString *_id;
@property (nonatomic, assign) long long int coin;
@property (nonatomic, strong) NSString *qd;
@property (nonatomic, strong) NSDictionary *session;
@property (nonatomic, assign) long long int timestamp;
@property (nonatomic, assign) NSInteger user_id;
@property (nonatomic, strong) NSString *via;
@property (nonatomic, strong) NSString *via_desc;

- (id)initWithAttributes:(NSDictionary *)attributes;

@end

#pragma mark - Lucky part.

@interface LuckySessionContent : NSObject

@property (nonatomic, assign) NSInteger _id;
@property (nonatomic, assign) NSInteger category_id;
@property (nonatomic, assign) NSInteger coin_price;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, assign) NSInteger xy_star_id;
@property (nonatomic, assign) NSInteger earned;
@property (nonatomic, strong) NSString *xy_nick;

- (id)initWithAttributes:(NSDictionary *)attributes;

@end

@interface LuckySession : NSObject

@property (nonatomic, strong) NSString *nick_name;
@property (nonatomic, assign) NSInteger _id;
@property (nonatomic, assign) NSInteger priv;
@property (nonatomic, assign) NSInteger spend;
@property (nonatomic, strong) NSDictionary *data;

- (id)initWithAttributes:(NSDictionary *)attributes;

@end

@interface TTShowLuckyRecord : NSObject

@property (nonatomic, strong) NSDictionary *_id;
@property (nonatomic, assign) long long int timestamp;
@property (nonatomic, assign) NSInteger got;
@property (nonatomic, assign) NSInteger  power;
@property (nonatomic, strong) NSDictionary *session;
@property (nonatomic, assign) NSInteger room;

- (id)initWithAttributes:(NSDictionary *)attributes;

@end

#pragma mark - Consume part.

@interface ConsumeRecordSessionData : NSObject

@property (nonatomic, assign) NSInteger _id;
@property (nonatomic, assign) NSInteger category_id;
@property (nonatomic, assign) NSInteger coin_price;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, assign) NSInteger xy_star_id;
@property (nonatomic, assign) NSInteger earned;
@property (nonatomic, strong) NSString *xy_nick;

- (id)initWithAttributes:(NSDictionary *)attributes;

@end

@interface ConsumeRecordSession : NSObject

@property (nonatomic, assign) NSInteger priv;
@property (nonatomic, strong) NSString *nick_name;
@property (nonatomic, assign) NSInteger spend;
@property (nonatomic, assign) NSInteger _id;
@property (nonatomic, strong) NSDictionary *data;

- (id)initWithAttributes:(NSDictionary *)attributes;

@end

@interface TTShowConsumeRecord : NSObject

@property (nonatomic, strong) NSString *_id;
@property (nonatomic, assign) long long int timestamp;
@property (nonatomic, strong) NSDictionary *session;
@property (nonatomic, assign) NSInteger family_id;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, assign) NSInteger cost;
@property (nonatomic, strong) NSString *live;
@property (nonatomic, assign) NSInteger room;
@property (nonatomic, strong) NSString *qd;

- (id)initWithAttributes:(NSDictionary *)attributes;

@end

#pragma mark - Received Gift records part.

@interface RecGiftSessionData : NSObject

@property (nonatomic, assign) NSInteger _id;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSInteger category_id;
@property (nonatomic, assign) NSInteger coin_price;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, assign) NSInteger xy_user_id;
@property (nonatomic ,assign) NSInteger earned;
@property (nonatomic, strong) NSString *xy_nick;

- (id)initWithAttributes:(NSDictionary *)attributes;

@end

@interface RecGiftSession : NSObject

@property (nonatomic, assign) NSInteger spend;
@property (nonatomic, assign) NSInteger _id;
@property (nonatomic, assign) NSInteger priv;
@property (nonatomic, strong) NSString *nick_name;
@property (nonatomic, strong) NSDictionary *data;

- (id)initWithAttributes:(NSDictionary *)attributes;

@end

@interface TTShowRecGiftRecord : NSObject

@property (nonatomic, strong) NSString *_id;
@property (nonatomic, assign) long long int timestamp;
@property (nonatomic, strong) NSDictionary *session;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, assign) NSInteger cost;
@property (nonatomic, strong) NSString *live;
@property (nonatomic, assign) NSInteger room;
@property (nonatomic, strong) NSString *qd;

- (id)initWithAttributes:(NSDictionary *)attributes;

@end