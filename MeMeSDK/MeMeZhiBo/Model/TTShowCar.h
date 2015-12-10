//
//  TTShowCar.h
//  TTShow
//
//  Created by twb on 13-7-12.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTShowCar : NSObject

@property (nonatomic, assign) NSInteger _id;
@property (nonatomic, assign) NSInteger cat;
@property (nonatomic, strong) NSString *swf_url;
@property (nonatomic, assign) NSInteger order;
@property (nonatomic, assign) BOOL status;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSInteger coin_price;
@property (nonatomic, strong) NSString *pic_pre_url;
@property (nonatomic, strong) NSString *pic_url;

- (id)initWithAttributes:(NSDictionary *)attributes;

@end
