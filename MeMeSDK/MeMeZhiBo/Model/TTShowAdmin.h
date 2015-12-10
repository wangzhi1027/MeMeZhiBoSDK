//
//  TTShowAdmin.h
//  TTShow
//
//  Created by twb on 13-7-3.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTShowAdmin : NSObject

@property (nonatomic, assign) NSInteger _id;
@property (nonatomic, strong) NSString *nick_name;
@property (nonatomic, strong) NSString *pic;
@property (nonatomic, assign) long long int coin_count;           //当前拥有柠檬数
@property (nonatomic, assign) long long int coin_spend_total;     //历史消费柠檬总数
@property (nonatomic, assign) long long int coin_spend;           //本场消费金额

- (id)initWithAttributes:(NSDictionary *)attributes;

@end
