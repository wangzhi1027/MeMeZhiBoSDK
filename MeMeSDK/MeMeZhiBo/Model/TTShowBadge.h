//
//  TTShowBadge.h
//  memezhibo
//
//  Created by XIN on 15/10/27.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//  TTShow
//
//  Created by twb on 14-5-14.
//  Copyright (c) 2014年 twb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTShowBadge : NSObject

@property (nonatomic, assign) NSInteger _id;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, assign) NSInteger expiry_days;
@property (nonatomic, strong) NSString *grey_pic;
@property (nonatomic, assign) NSInteger medal_type;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSInteger order;
@property (nonatomic, strong) NSString *pic_url;
@property (nonatomic, strong) NSString *small_pic;
@property (nonatomic, assign) BOOL status;
@property (nonatomic, assign) long long int timestamp;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, assign) NSInteger sum_cost;
@property (nonatomic, assign) long long int expire;
@property (nonatomic, assign) BOOL award;

- (id)initWithAttributes:(NSDictionary *)attributes;

@end
