//
//  TTShowFollowStar.m
//  TTShow
//
//  Created by twb on 13-7-16.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import "TTShowFollowStar.h"

@implementation TTShowFollowRoomStar

- (id)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if (!self)
    {
        return nil;
    }
    
    /*
     // Room
     @property (nonatomic, assign) NSInteger roomID;
     @property (nonatomic, assign) NSInteger followers;
     @property (nonatomic, assign) long long int found_time;
     @property (nonatomic, assign) BOOL live;
     @property (nonatomic, strong) NSString *pic_url;
     @property (nonatomic, assign) long long int timestamp;
     @property (nonatomic, assign) NSInteger visiter_count;
     @property (nonatomic, assign) NSUInteger xy_star_id;
     // Star
     @property (nonatomic, assign) NSInteger starID;
     @property (nonatomic, assign) NSInteger bean_count_total;
     @property (nonatomic, strong) NSString *nick_name;
     @property (nonatomic, strong) NSString *pic;

     */
    NSDictionary *userDict = [attributes valueForKey:@"user"];
    NSDictionary *roomDict = [attributes valueForKey:@"room"];
    
    self.roomID = [[roomDict valueForKey:@"_id"] integerValue];
    self.followers = [roomDict[@"followers"] integerValue];
    self.found_time = [roomDict[@"found_time"] longLongValue];
    self.live = [[roomDict valueForKey:@"live"] boolValue];
    self.pic_url = roomDict[@"pic_url"];
    self.timestamp = [[roomDict valueForKey:@"timestamp"] longLongValue];
    self.visiter_count = [roomDict[@"visiter_count"] integerValue];
    self.xy_star_id = [[roomDict valueForKey:@"xy_star_id"] unsignedIntegerValue];
    
    self.starID = [[userDict valueForKey:@"_id"] integerValue];
    self.bean_count_total = [[[userDict valueForKey:@"finance"] valueForKey:@"bean_count_total"] longLongValue];
    self.nick_name = [userDict valueForKey:@"nick_name"];
    self.pic = [userDict valueForKey:@"pic"];
    
    return self;
}

#pragma mark - NSCoding Protocal

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:@(self.roomID) forKey:@"roomID"];
    [aCoder encodeObject:@(self.live) forKey:@"live"];
    [aCoder encodeObject:@(self.timestamp) forKey:@"timestamp"];
    [aCoder encodeObject:@(self.xy_star_id) forKey:@"xy_star_id"];
    
    [aCoder encodeObject:@(self.starID) forKey:@"starID"];
    [aCoder encodeObject:@(self.bean_count_total) forKey:@"bean_count_total"];
    [aCoder encodeObject:self.nick_name forKey:@"nick_name"];
    [aCoder encodeObject:self.pic forKey:@"pic"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        self.roomID = [[aDecoder decodeObjectForKey:@"roomID"] integerValue];
        self.live = [[aDecoder decodeObjectForKey:@"live"] boolValue];
        self.timestamp = [[aDecoder decodeObjectForKey:@"timestamp"] longLongValue];
        self.xy_star_id = [[aDecoder decodeObjectForKey:@"xy_star_id"] integerValue];
        
        self.starID = [[aDecoder decodeObjectForKey:@"starID"] integerValue];
        self.bean_count_total = [[aDecoder decodeObjectForKey:@"bean_count_total"] longLongValue];
        self.nick_name = [aDecoder decodeObjectForKey:@"nick_name"];
        self.pic = [aDecoder decodeObjectForKey:@"pic"];
    }
    return self;
}


@end
