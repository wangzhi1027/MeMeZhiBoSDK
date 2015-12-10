//
//  TTShowGiftRank.h
//  TTShow
//
//  Created by twb on 13-6-28.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTShowGift.h"

@interface TTShowRank : NSObject

@property (nonatomic, assign) NSUInteger _id;
@property (nonatomic, assign) NSUInteger count;
@property (nonatomic, assign) NSUInteger earned;
@property (nonatomic, assign) NSUInteger user_id;
@property (nonatomic, assign) NSUInteger gift_id;
@property (nonatomic, strong) NSString *pic_url;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) long long int bean_count_total;
@property (nonatomic, strong) NSString *nick_name;
@property (nonatomic, strong) NSString *pic;
@property (nonatomic, assign) BOOL live;
@property (nonatomic, assign) NSUInteger level;

- (id)initWithAttributes:(NSDictionary *)attributes;

@end

@interface TTShowGiftRank : NSObject

@property (nonatomic, strong) TTShowGift *gift;
@property (nonatomic, strong) NSMutableArray *ranks;

- (id)initWithAttributes:(NSDictionary *)attributes;

@end
