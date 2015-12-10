//
//  HongbaoListModel.m
//  memezhibo
//
//  Created by Xingai on 15/8/18.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "HongbaoListModel.h"

@implementation HongbaoListModel

- (id)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if (!self)
    {
        return nil;
    }
    self._id = [attributes valueForKey:@"_id"];
    
    self.user = [attributes valueForKey:@"user"];
    
    self.timestamp = [[attributes valueForKey:@"timestamp"] longLongValue];
    
    
    
    self.coins = [[attributes valueForKey:@"coins"] integerValue];
    
    return self;
}

@end
