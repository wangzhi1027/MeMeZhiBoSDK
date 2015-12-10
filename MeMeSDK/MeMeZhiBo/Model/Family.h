//
//  Family.h
//  TTShow
//
//  Created by xh on 15/3/12.
//  Copyright (c) 2015年 twb. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Family : JSONModel
@property (assign, nonatomic) NSInteger family_id;
@property (assign, nonatomic) NSInteger family_priv;
@property (assign, nonatomic) long long int timestamp;
@property (strong, nonatomic) NSString* family_name;
@property (strong, nonatomic) NSString* badge_name;
@property (assign, nonatomic) NSInteger week_support;

- (id)initWithAttributes:(NSDictionary *)attributes;

@end
