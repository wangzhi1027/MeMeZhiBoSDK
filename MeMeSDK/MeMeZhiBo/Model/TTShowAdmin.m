//
//  TTShowAdmin.m
//  TTShow
//
//  Created by twb on 13-7-3.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import "TTShowAdmin.h"

@implementation TTShowAdmin


- (id)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if (!self)
    {
        return nil;
    }
    
    /*
     @property (nonatomic, assign) NSInteger _id;
     @property (nonatomic, strong) NSString *nick_name;
     @property (nonatomic, strong) NSString *pic;
     @property (nonatomic, assign) NSInteger coin_count;           //当前拥有柠檬数
     @property (nonatomic, assign) NSInteger coin_spend_total;     //历史消费柠檬总数
     @property (nonatomic, assign) NSInteger coin_spend;           //本场消费金额
     */
    
    self._id = [[attributes valueForKey:@"_id"] integerValue];
    self.nick_name = [[attributes valueForKey:@"nick_name"] stringByUnescapingFromHTML];
    self.pic = [attributes valueForKey:@"pic"];
    self.coin_count = [[attributes valueForKey:@"coin_count"] longLongValue];
    self.coin_spend_total = [[attributes valueForKey:@"coin_spend_total"] longLongValue];
//    self.coin_spend = [[attributes valueForKey:@"coin_spend"] integerValue];
    
    return self;
}


@end
