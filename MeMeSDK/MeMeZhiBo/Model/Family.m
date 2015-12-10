//
//  Family.m
//  TTShow
//
//  Created by xh on 15/3/12.
//  Copyright (c) 2015年 twb. All rights reserved.
//

#import "Family.h"

@implementation Family

- (id)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    /*
     @property (nonatomic, assign) NSUInteger bean_count;
     @property (nonatomic, assign) NSUInteger bean_count_total;
     @property (nonatomic, assign) NSUInteger coin_count;
     @property (nonatomic, assign) NSUInteger coin_spend_total;
     @property (nonatomic, assign) NSUInteger spend_star_level;
     @property (nonatomic, assign) NSInteger feather_count;
     @property (nonatomic, assign) long long int feather_last;
     @property (nonatomic, assign) long long int feather_send_total;
     */
    
    self.family_id = [[attributes valueForKey:@"family_id"] integerValue];
    self.family_priv = [[attributes valueForKey:@"family_priv"] integerValue];
    self.timestamp = [[attributes valueForKey:@"timestamp"] longLongValue];
    self.family_name = [attributes valueForKey:@"family_name"];
    self.badge_name = [attributes valueForKey:@"badge_name"];
    
    
    

    
    return self;
}

@end
