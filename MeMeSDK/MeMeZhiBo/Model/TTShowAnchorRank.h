//
//  TTShowAnchorRank.h
//  TTShow
//
//  Created by twb on 13-6-27.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTShowAnchorRank : NSObject

@property (nonatomic, assign) NSUInteger rank;
// Feather Count.
@property (nonatomic, assign) long long int num;
@property (nonatomic, assign) BOOL live;
@property (nonatomic, assign) NSUInteger _id;
@property (nonatomic, strong) NSString *nick_name;
@property (nonatomic, strong) NSString *pic;

@property (nonatomic, assign) NSUInteger room_id;

@property (nonatomic, assign) long long int bean_count_total;
@property (nonatomic, assign) long long int coin_spend_total;

- (id)initWithAttributes:(NSDictionary *)attributes;

@end
