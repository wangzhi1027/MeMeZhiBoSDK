//
//  TTShowRoomStar.h
//  TTShow
//
//  Created by twb on 13-6-20.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTShowRoomStar : NSObject

@property (nonatomic, assign) NSUInteger _id;
@property (nonatomic, strong) NSString *nick_name;
@property (nonatomic, assign) BOOL isLive;

@property (nonatomic, assign) NSUInteger day_rank;
@property (nonatomic, strong) NSArray *gift_week;
@property (nonatomic, assign) NSUInteger room_id;

@property (nonatomic, assign) long long int bean_count_total;
@property (nonatomic, assign) long long int coin_spend_total;
@property (nonatomic, assign) NSUInteger feather_receive_total;

@property (nonatomic, strong) NSString *pic;
@property (nonatomic, strong) NSDictionary *tag;

@property (nonatomic, strong) NSString *live_id;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSString *greetings;
@property (nonatomic, strong) NSString *pic_url;

@property (nonatomic, assign) NSInteger vip;

- (id)initWithAttributes:(NSDictionary *)attributes;

@end
