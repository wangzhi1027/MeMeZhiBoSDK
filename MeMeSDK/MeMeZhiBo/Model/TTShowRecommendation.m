//
//  TTShowRecommendation.m
//  memezhibo
//
//  Created by Xingai on 15/5/22.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "TTShowRecommendation.h"

@implementation TTShowRecommendation

- (id)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if (!self)
    {
        return nil;
    }
    
    /*
     @property (nonatomic, assign) NSInteger _id;
     @property (nonatomic, strong) NSString *cat;
     @property (nonatomic, strong) NSString *swf_url;
     @property (nonatomic, assign) NSInteger order;
     @property (nonatomic, assign) BOOL status;
     @property (nonatomic, strong) NSString *name;
     @property (nonatomic, assign) NSInteger coin_price;
     @property (nonatomic, strong) NSString *pic_pre_url;
     @property (nonatomic, strong) NSString *pic_url;
     */
    
    self._id = [[attributes valueForKey:@"_id"] integerValue];
    self.nick_name = [attributes valueForKey:@"nick_name"];
    self.pic_url = [attributes valueForKey:@"pic_url"];
    self.live = [[attributes valueForKey:@"live"] boolValue];
    self.visiter_count = [[attributes valueForKey:@"visiter_count"] integerValue];
    self.followers = [[attributes valueForKey:@"followers"] integerValue];
    self.found_time = [attributes[@"found_time"] longLongValue];
    self.gift_week = [[attributes valueForKey:@"star"] valueForKey:@"gift_week"];
    
    
    return self;
}



@end
