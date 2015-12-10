//
//  qudaoModel.m
//  memezhibo
//
//  Created by Xingai on 15/7/9.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "qudaoModel.h"

@implementation qudaoModel

- (id)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if (!self)
    {
        return nil;
    }
    
    
    self.isJailBreak = [[attributes valueForKey:@"isJailBreak"] boolValue];
    self.isJailBreak = [[attributes valueForKey:@"guanfangqudao"] boolValue];
    return self;
}

@end
