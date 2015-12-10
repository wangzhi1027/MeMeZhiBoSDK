//
//  TTShowRoom.h
//  TTShow
//
//  Created by twb on 13-6-3.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTShowFollowStar.h"

@interface TTShowRoom : NSObject

@property (nonatomic, assign) NSUInteger _id;
@property (nonatomic, assign) NSInteger audit_pic_status;
@property (nonatomic, strong) NSString *audit_pic_url;
@property (nonatomic, assign) long long int bean;
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

- (id)initWithAttributes:(NSDictionary *)attributes;
- (id)initWithFollowStar:(TTShowFollowRoomStar *)followRoomStar;

@end
