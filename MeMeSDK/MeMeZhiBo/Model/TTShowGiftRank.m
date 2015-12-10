//
//  TTShowGiftRank.m
//  TTShow
//
//  Created by twb on 13-6-28.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import "TTShowGiftRank.h"

@implementation TTShowRank

- (id)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if (!self)
    {
        return nil;
    }
    
    /*
     @property (nonatomic, assign) NSUInteger _id;
     @property (nonatomic, assign) NSUInteger count;
     @property (nonatomic, assign) NSUInteger earned;
     @property (nonatomic, assign) NSUInteger user_id;
     @property (nonatomic, assign) NSUInteger gift_id;
     @property (nonatomic, strong) NSString *pic_url;
     @property (nonatomic, strong) NSString *name;
     @property (nonatomic, assign) NSUInteger bean_count_total;
     @property (nonatomic, strong) NSString *nick_name;
     @property (nonatomic, strong) NSString *pic;
     @property (nonatomic, assign) BOOL live;
     @property (nonatomic, assign) NSUInteger level;
     */
    
    self._id = [[attributes valueForKey:@"_id"] integerValue];
    self.count = [[attributes valueForKey:@"count"] integerValue];
    self.earned = [[attributes valueForKey:@"earned"] integerValue];
    self.user_id = [[attributes valueForKey:@"user_id"] integerValue];
    self.gift_id = [[attributes valueForKey:@"gift_id"] integerValue];
    self.pic_url = [attributes valueForKey:@"pic_url"];
    self.name = [attributes valueForKey:@"name"];
    self.bean_count_total = [[[attributes valueForKey:@"finance"] valueForKey:@"bean_count_total"] longLongValue];
    self.nick_name = [[attributes valueForKey:@"nick_name"] stringByUnescapingFromHTML];
    self.pic = [attributes valueForKey:@"pic"];
    self.live = [[attributes valueForKey:@"live"] boolValue];
    self.level = [[attributes valueForKey:@"level"] integerValue];
    
    return self;
}

@end

@implementation TTShowGiftRank

- (id)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if (!self)
    {
        return nil;
    }
    
    /*
     @property (nonatomic, strong) TTShowGift *gift;
     @property (nonatomic, strong) NSMutableArray *ranks;
     */
    
    self.gift = [[TTShowGift alloc] initWithAttributes:attributes];
    
    NSArray *rankList = [attributes valueForKey:@"rank"];
    self.ranks = [NSMutableArray arrayWithCapacity:0];
    for (NSDictionary *dict in rankList)
    {
        TTShowRank *rank = [[TTShowRank alloc] initWithAttributes:dict];
        [self.ranks addObject:rank];
    }
    
    return self;
}

@end
