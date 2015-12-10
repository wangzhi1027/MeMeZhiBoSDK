//
//  HongbaoListModel.h
//  memezhibo
//
//  Created by Xingai on 15/8/18.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTShowUserNew.h"

@interface HongbaoListModel : NSObject

@property (assign, nonatomic) NSString *_id;
@property (assign, nonatomic) NSInteger amount;
@property (assign, nonatomic) NSInteger coins;
@property (assign, nonatomic) NSInteger count;
@property (assign, nonatomic) NSInteger nest_id;
@property (assign, nonatomic) long long int timestamp;
@property (strong, nonatomic) NSDictionary *user;

- (id)initWithAttributes:(NSDictionary *)attributes;

@end
