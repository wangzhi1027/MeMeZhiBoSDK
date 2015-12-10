//
//  TTShowSpecialGiftRank.m
//  TTShow
//
//  Created by twb on 13-7-3.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import "TTShowSpecialGiftRank.h"


@implementation TTShowSpecialGift

- (id)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if (!self)
    {
        return nil;
    }
    
    /*
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
     */
    
    self._id = [[attributes valueForKey:@"_id"] integerValue];
    self.name = [attributes valueForKey:@"name"];
    self.pic_url = [attributes valueForKey:@"pic_url"];
    self.swf_url = [attributes valueForKey:@"swf_url"];
    self.status = [[attributes valueForKey:@"status"] boolValue];
    self.star = [[attributes valueForKey:@"star"] boolValue];
    self.category_id = [[attributes valueForKey:@"category_id"] integerValue];
    self.order = [[attributes valueForKey:@"order"] integerValue];
    self.coin_price = [[attributes valueForKey:@"coin_price"] integerValue];
    
    return self;
}

@end

@implementation TTShowSpecialStar

- (id)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if (!self)
    {
        return nil;
    }
    
    /*
     @property (nonatomic, assign) NSInteger _id;
     @property (nonatomic, assign) NSInteger count;
     @property (nonatomic, assign) NSInteger earned;
     @property (nonatomic, assign) NSInteger bonus;
     @property (nonatomic, assign) NSInteger bean_count_total;
     @property (nonatomic, assign) NSInteger coin_spend_total;
     @property (nonatomic, strong) NSString *nick_name;
     @property (nonatomic, strong) NSString *pic;
     */
    
    self._id = [[attributes valueForKey:@"_id"] integerValue];
    self.live = [[attributes valueForKey:@"live"] boolValue];
    self.count = [[attributes valueForKey:@"count"] integerValue];
    self.earned = [[attributes valueForKey:@"earned"] integerValue];
    self.bonus = [[attributes valueForKey:@"bonus"] integerValue];
    self.bean_count_total = [[[attributes valueForKey:@"finance"] valueForKey:@"bean_count_total"] longLongValue];
    self.coin_spend_total = [[[attributes valueForKey:@"finance"] valueForKey:@"coin_spend_total"] longLongValue];
    self.nick_name = [attributes valueForKey:@"nick_name"];
    self.pic = [attributes valueForKey:@"pic"];
    
    return self;
}

@end

@implementation TTShowSpecialFan

- (id)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if (!self)
    {
        return nil;
    }
    
    /*
     @property (nonatomic, assign) NSInteger _id;
     @property (nonatomic, assign) NSInteger count;
     @property (nonatomic, assign) NSInteger bean_count_total;
     @property (nonatomic, assign) NSInteger coin_spend_total;
     @property (nonatomic, strong) NSString *nick_name;
     @property (nonatomic, strong) NSString *pic;
     */
    
    self._id = [[attributes valueForKey:@"_id"] integerValue];
    self.count = [[attributes valueForKey:@"count"] integerValue];
    self.bean_count_total = [[[attributes valueForKey:@"finance"] valueForKey:@"bean_count_total"] longLongValue];
    self.coin_spend_total = [[[attributes valueForKey:@"finance"] valueForKey:@"coin_spend_total"] longLongValue];
    self.nick_name = [attributes valueForKey:@"nick_name"];
    self.pic = [attributes valueForKey:@"pic"];
    
    return self;
}

@end

@implementation TTShowSpecialGiftRank

- (id)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if (!self)
    {
        return nil;
    }
    
    /*
     @property (nonatomic, strong) NSString *_id;
     @property (nonatomic, assign) NSInteger stime;
     @property (nonatomic, assign) NSInteger etime;
     @property (nonatomic, assign) CGFloat ratio;
     @property (nonatomic, strong) TTShowSpecialGift *gift;
     @property (nonatomic, strong) TTShowSpecialStar *star;
     @property (nonatomic, strong) TTShowSpecialFan *fan;
     */
    
    self._id = [attributes valueForKey:@"_id"];
    self.stime = [[attributes valueForKey:@"stime"] integerValue];
    self.etime = [[attributes valueForKey:@"etime"] integerValue];
    self.ratio = [[attributes valueForKey:@"ratio"] floatValue];

    self.gift = [[TTShowSpecialGift alloc] initWithAttributes:[attributes valueForKey:@"gift"]];
    self.star = [[TTShowSpecialStar alloc] initWithAttributes:[attributes valueForKey:@"star1"]];
    self.fan = [[TTShowSpecialFan alloc] initWithAttributes:[attributes valueForKey:@"fan1"]];
    
    return self;
}

@end
