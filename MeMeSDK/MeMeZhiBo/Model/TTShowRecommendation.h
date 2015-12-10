//
//  TTShowRecommendation.h
//  memezhibo
//
//  Created by Xingai on 15/5/22.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTShowRecommendation : NSObject

@property (nonatomic, assign) NSUInteger _id;
@property (nonatomic, strong) NSString *nick_name;
@property (nonatomic, assign) BOOL live;
@property (nonatomic, strong) NSString *pic_url;
@property (nonatomic, assign) NSInteger visiter_count;
@property (nonatomic, assign) NSInteger followers;
@property (nonatomic, assign) long long int found_time;
@property (nonatomic, strong) NSArray *gift_week;


- (id)initWithAttributes:(NSDictionary *)attributes;

@end
