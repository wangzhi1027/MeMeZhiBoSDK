//
//  TTShowBadge.m
//  memezhibo
//
//  Created by XIN on 15/10/27.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//  TTShow
//
//  Created by twb on 14-5-14.
//  Copyright (c) 2014年 twb. All rights reserved.
//

#import "TTShowBadge.h"

@implementation TTShowBadge

- (id)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    /*
     @property (nonatomic, assign) NSInteger _id;
     @property (nonatomic, strong) NSString *desc;
     @property (nonatomic, assign) NSInteger expiry_days;
     @property (nonatomic, strong) NSString *grey_pic;
     @property (nonatomic, assign) NSInteger medal_type;
     @property (nonatomic, strong) NSString *name;
     @property (nonatomic, assign) NSInteger order;
     @property (nonatomic, strong) NSString *pic_url;
     @property (nonatomic, strong) NSString *small_pic;
     @property (nonatomic, assign) BOOL status;
     @property (nonatomic, assign) long long int timestamp;
     @property (nonatomic, assign) NSInteger type;
     @property (nonatomic, assign) NSInteger sum_cost;
     @property (nonatomic, assign) long long int expire;
     @property (nonatomic, assign) BOOL award;
     */
    
    self._id = [attributes[@"_id"] integerValue];
    self.desc = attributes[@"desc"];
    self.expiry_days = [attributes[@"expiry_days"] integerValue];
    self.grey_pic = attributes[@"grey_pic"];
    self.medal_type = [attributes[@"medal_type"] integerValue];
    self.name = attributes[@"name"];
    self.order = [attributes[@"order"] integerValue];
    self.pic_url = attributes[@"pic_url"];
    self.small_pic = attributes[@"small_pic"];
    self.status = [attributes[@"status"] boolValue];
    self.timestamp = [attributes[@"timestamp"] longLongValue];
    self.type = [attributes[@"type"] integerValue];
    self.sum_cost = [attributes[@"sum_cost"] integerValue];
    self.expire = [attributes[@"expire"] longLongValue];
    self.award = [attributes[@"award"] boolValue];
    
    return self;
}

@end
