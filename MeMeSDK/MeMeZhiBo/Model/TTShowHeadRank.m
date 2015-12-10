//
//  TTShowHeadRank.m
//  TTShow
//
//  Created by twb on 13-10-21.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import "TTShowHeadRank.h"


@implementation TTShowHeadRank

- (id)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    /*
     @property (nonatomic, assign) HeadRankType type;
     @property (nonatomic, strong) NSMutableArray *pics;
     */
    
    self.type = [[attributes valueForKey:@"type"] integerValue];
    self.pics = [attributes valueForKey:@"pics"];
    
    return self;
}

@end
