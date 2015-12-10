//
//  TTShowAnchorRank.m
//  TTShow
//
//  Created by twb on 13-6-27.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import "TTShowAnchorRank.h"

@implementation TTShowAnchorRank
- (id)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    /*
     @property (nonatomic, assign) NSUInteger rank;
     @property (nonatomic, assign) NSUInteger num;
     @property (nonatomic, assign) BOOL live;
     @property (nonatomic, assign) NSUInteger _id;
     @property (nonatomic, strong) NSString *nick_name;
     @property (nonatomic, strong) NSString *pic;
     
     @property (nonatomic, assign) NSUInteger room_id;
     
     @property (nonatomic, assign) NSUInteger bean_count_total;
     @property (nonatomic, assign) NSUInteger coin_spend_total;
     */
    
    self.rank = [[attributes valueForKey:@"rank"] unsignedIntegerValue];
    self.num = [[attributes valueForKey:@"num"] longLongValue];
    self.live = [[attributes valueForKey:@"live"] boolValue];
    self._id = [[attributes valueForKey:@"_id"] integerValue];
    self.nick_name = [[attributes valueForKey:@"nick_name"] stringByUnescapingFromHTML];
    self.pic = [attributes valueForKey:@"pic"];
    
    self.room_id = [[[attributes valueForKey:@"star"] valueForKey:@"room_id"] unsignedIntegerValue];
    
    self.bean_count_total = [[[attributes valueForKey:@"finance"] valueForKey:@"bean_count_total"] longLongValue];
    self.coin_spend_total = [[[attributes valueForKey:@"finance"] valueForKey:@"coin_spend_total"] longLongValue];
    
    return self;
}
@end
