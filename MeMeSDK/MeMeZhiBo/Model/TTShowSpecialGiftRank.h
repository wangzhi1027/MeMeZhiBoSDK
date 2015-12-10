//
//  TTShowSpecialGiftRank.h
//  TTShow
//
//  Created by twb on 13-7-3.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTShowSpecialGift : NSObject

@property (nonatomic, assign) NSInteger _id;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *pic_url;
@property (nonatomic, strong) NSString *swf_url;
@property (nonatomic, strong) NSString *pic_pre_url;
@property (nonatomic, assign) BOOL status;
@property (nonatomic, assign) BOOL star;
@property (nonatomic, assign) NSInteger category_id;
@property (nonatomic, assign) NSInteger order;
@property (nonatomic, assign) NSInteger coin_price;

- (id)initWithAttributes:(NSDictionary *)attributes;

@end

@interface TTShowSpecialStar : NSObject

@property (nonatomic, assign) NSInteger _id;
@property (nonatomic, assign) NSUInteger live;

@property (nonatomic, assign) NSInteger count;
@property (nonatomic, assign) NSInteger earned;
@property (nonatomic, assign) NSInteger bonus;
@property (nonatomic, assign) long long int bean_count_total;
@property (nonatomic, assign) long long int coin_spend_total;
@property (nonatomic, strong) NSString *nick_name;
@property (nonatomic, strong) NSString *pic;

- (id)initWithAttributes:(NSDictionary *)attributes;

@end

@interface TTShowSpecialFan : NSObject

@property (nonatomic, assign) NSInteger _id;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, assign) long long int bean_count_total;
@property (nonatomic, assign) long long int coin_spend_total;
@property (nonatomic, strong) NSString *nick_name;
@property (nonatomic, strong) NSString *pic;

- (id)initWithAttributes:(NSDictionary *)attributes;

@end

@interface TTShowSpecialGiftRank : NSObject

@property (nonatomic, strong) NSString *_id;
@property (nonatomic, assign) NSInteger stime;
@property (nonatomic, assign) NSInteger etime;
@property (nonatomic, assign) CGFloat ratio;
@property (nonatomic, strong) TTShowSpecialGift *gift;
@property (nonatomic, strong) TTShowSpecialStar *star;
@property (nonatomic, strong) TTShowSpecialFan *fan;

- (id)initWithAttributes:(NSDictionary *)attributes;

@end
