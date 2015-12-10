//
//  hongbaoUserModel.m
//  memezhibo
//
//  Created by Xingai on 15/8/18.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "hongbaoUserModel.h"

@implementation hongbaoUserModel

- (id)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if (!self)
    {
        return nil;
    }
    self._id = [[attributes valueForKey:@"_id"] integerValue];
    
    self.nick_name = [[attributes valueForKey:@"nick_name"]stringByUnescapingFromHTML];
    self.pic = [attributes valueForKey:@"pic"];
    self.finance = [attributes valueForKey:@"finance"];
    self.coins = [[attributes valueForKey:@"coins"] integerValue];
    self.timestamp = [attributes[@"timestamp"] longLongValue];
    
    return self;
}

@end
