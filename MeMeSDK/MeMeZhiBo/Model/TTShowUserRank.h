//
//  TTShowUserRank.h
//  TTShow
//
//  Created by twb on 13-6-24.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTShowUserRank : NSObject
@property (nonatomic, assign) NSUInteger _id;
@property (nonatomic, assign) NSUInteger rank;
@property (nonatomic, assign) long long int coin_spend;
@property (nonatomic, assign) long long int coin_spend_total;
@property (nonatomic, strong) NSString *nick_name;
@property (nonatomic, strong) NSString *pic;
@property (nonatomic, strong) NSString *s;

- (id)initWithAttributes:(NSDictionary *)attributes;
@end
