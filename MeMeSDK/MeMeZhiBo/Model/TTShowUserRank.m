//
//  TTShowUserRank.m
//  TTShow
//
//  Created by twb on 13-6-24.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import "TTShowUserRank.h"

@implementation TTShowUserRank
- (id)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    /*
     @property (nonatomic, assign) NSUInteger _id;
     @property (nonatomic, assign) NSUInteger rank;
     @property (nonatomic, assign) NSUInteger coin_spend;
     @property (nonatomic, assign) NSUInteger coin_spend_total;
     @property (nonatomic, strong) NSString *nick_name;
     @property (nonatomic, strong) NSString *pic;
     @property (nonatomic, strong) NSString *s;
     */
    
    self._id = [[attributes valueForKey:@"_id"] integerValue];
    self.rank = [[attributes valueForKey:@"rank"] integerValue];
    self.coin_spend = [[attributes valueForKey:@"coin_spend"] longLongValue];
    self.coin_spend_total = [[[attributes valueForKey:@"finance"] valueForKey:@"coin_spend_total"] longLongValue];
    self.nick_name = [[attributes valueForKey:@"nick_name"] stringByUnescapingFromHTML];
    self.pic = [attributes valueForKey:@"pic"];
    self.s = [attributes valueForKey:@"s"];
    
    return self;
}
@end
