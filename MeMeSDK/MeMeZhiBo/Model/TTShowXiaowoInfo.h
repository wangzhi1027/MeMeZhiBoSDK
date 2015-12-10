//
//  TTShowXiaowoInfo.h
//  TTShow
//
//  Created by wangyifeng on 15-3-18.
//  Copyright (c) 2015年 twb. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JSONModel.h"

@interface TTShowXiaowoInfo : JSONModel

@property (nonatomic, assign) NSUInteger _id;
@property (nonatomic, assign) NSUInteger user_id;
@property (nonatomic, assign) NSUInteger m_count;
@property (nonatomic, assign) NSUInteger visitor_count;
@property (nonatomic, assign) NSUInteger followers;
@property (nonatomic, assign) long long int  timestamp;

@property (nonatomic, assign) NSInteger mic_first;
@property (nonatomic, assign) NSInteger mic_sec;

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *notice;
@property (nonatomic, strong) NSString *pic;

@property (nonatomic, strong) NSDictionary *sec_user_info;

@property (nonatomic, strong) NSDictionary *first_user_info;

@property (nonatomic, strong) NSArray *admin;

@property (nonatomic, strong) NSDictionary *creator;

- (id)initWithAttributes:(NSDictionary *)attributes;

@end
