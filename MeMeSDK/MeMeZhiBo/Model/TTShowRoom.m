//
//  TTShowRoom.m
//  TTShow
//
//  Created by twb on 13-6-3.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import "TTShowRoom.h"

@implementation TTShowRoom

- (id)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    /*
     @property (nonatomic, assign) NSUInteger _id;
     @property (nonatomic, assign) NSInteger audit_pic_status;
     @property (nonatomic, strong) NSString *audit_pic_url;
     @property (nonatomic, assign) NSUInteger bean;
     @property (nonatomic, assign) NSInteger followers;
     @property (nonatomic, assign) long long int found_time;
     @property (nonatomic, assign) long long int lastmodif;
     @property (nonatomic, assign) BOOL live;
     @property (nonatomic, assign) long long int live_end_time;
     @property (nonatomic, strong) NSString *pic;
     @property (nonatomic, strong) NSString *pic_url;
     @property (nonatomic, assign) NSInteger plugin;
     @property (nonatomic, assign) NSInteger real_sex;
     @property (nonatomic, assign) NSInteger room_ids;
     @property (nonatomic, strong) NSDictionary *tag;
     @property (nonatomic, assign) NSInteger rank;
     @property (nonatomic, assign) long long int timestamp;
     @property (nonatomic, assign) NSUInteger visiter_count;
     @property (nonatomic, assign) NSUInteger xy_star_id;
     @property (nonatomic, strong) NSString *nick_name;
     @property (nonatomic, assign) NSUInteger L;
     @property (nonatomic, strong) NSArray *gift_week;
     */
    
    self._id = [[attributes valueForKey:@"_id"] integerValue];
    self.audit_pic_status = [attributes[@"audit_pic_status"] integerValue];
    self.audit_pic_url = attributes[@"audit_pic_url"];
    self.bean = [[attributes valueForKey:@"bean"] integerValue];
    self.followers = [attributes[@"followers"] integerValue];
    self.found_time = [attributes[@"found_time"] longLongValue];
    self.lastmodif = [attributes[@"lastmodif"] longLongValue];
    self.live = [[attributes valueForKey:@"live"] boolValue];
    self.live_end_time = [attributes[@"live_end_time"] longLongValue];
    self.pic = attributes[@"pic"];
    self.pic_url = [attributes valueForKey:@"pic_url"];
    self.plugin = [attributes[@"plugin"] integerValue];
    self.real_sex = [attributes[@"real_sex"] integerValue];
    self.room_ids = [attributes[@"room_ids"] integerValue];
    self.tag = attributes[@"tag"];
    self.rank = [[attributes valueForKey:@"rank"] integerValue];
    self.timestamp = [[attributes valueForKey:@"timestamp"] longLongValue];
    self.visiter_count = [[attributes valueForKey:@"visiter_count"] integerValue];
    self.xy_star_id = [[attributes valueForKey:@"xy_star_id"] integerValue];
    self.nick_name = [attributes valueForKey:@"nick_name"];
    self.L = [[attributes valueForKey:@"L"] integerValue];
    self.gift_week = [[attributes valueForKey:@"star"] valueForKey:@"gift_week"];
    
    
    return self;
}

- (id)initWithFollowStar:(TTShowFollowRoomStar *)followRoomStar
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self._id = followRoomStar.roomID;
    self.bean = followRoomStar.bean_count_total;
    self.followers = followRoomStar.followers;
    self.found_time = followRoomStar.found_time;
    self.live = followRoomStar.live;
    self.pic = followRoomStar.pic;
    self.pic_url = followRoomStar.pic_url;
    self.timestamp = followRoomStar.timestamp;
    self.visiter_count = followRoomStar.visiter_count;
    self.xy_star_id = followRoomStar.xy_star_id;
    self.nick_name = followRoomStar.nick_name;
    
    return self;
}

-(BOOL)isEqual:(id)object
{
    if ([object isKindOfClass:[TTShowRoom class]]) {
        TTShowRoom *room = object;
        return self._id == room._id;
    }
    return NO;
}

-(NSUInteger)hash
{
    return self._id;
}

@end
