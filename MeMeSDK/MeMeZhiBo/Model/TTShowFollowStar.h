//
//  TTShowFollowStar.h
//  TTShow
//
//  Created by twb on 13-7-16.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTShowFollowRoomStar : NSObject

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
@property (nonatomic, assign) long long int bean_count_total;
@property (nonatomic, strong) NSString *nick_name;
@property (nonatomic, strong) NSString *pic;

- (id)initWithAttributes:(NSDictionary *)attributes;

@end
