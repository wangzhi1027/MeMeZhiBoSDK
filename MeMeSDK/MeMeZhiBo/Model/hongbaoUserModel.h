//
//  hongbaoUserModel.h
//  memezhibo
//
//  Created by Xingai on 15/8/18.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface hongbaoUserModel : NSObject

@property (assign, nonatomic) NSInteger _id;
@property (strong, nonatomic) NSString *nick_name;
@property (strong, nonatomic) NSString *pic;
@property (strong, nonatomic) NSDictionary *finance;
@property (assign, nonatomic) long long int timestamp;
@property (assign, nonatomic) NSInteger coins;

- (id)initWithAttributes:(NSDictionary *)attributes;

@end
