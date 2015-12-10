//
//  TTShowXiaowoList.m
//  memezhibo
//
//  Created by Xingai on 15/5/25.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "TTShowXiaowoList.h"

@implementation TTShowXiaowoList

- (id)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if (!self)
    {
        return nil;
    }
    

    self.name = [attributes valueForKey:@"name"];
    self.pic = [attributes valueForKey:@"pic"];
    self.m_count = [[attributes valueForKey:@"m_count"] integerValue];

    
    
    return self;
}

@end
