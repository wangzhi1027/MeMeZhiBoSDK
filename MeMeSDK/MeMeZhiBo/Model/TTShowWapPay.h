//
//  TTShowWapPay.h
//  TTShow
//
//  Created by twb on 13-12-2.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTShowWapPay : NSObject

@property (nonatomic, strong) NSString *requestURL;
@property (nonatomic, strong) NSString *callbackURL;
@property (nonatomic, strong) NSString *notifyURL;
// only for alipay ---.
@property (nonatomic, strong) NSString *partner;
@property (nonatomic, strong) NSString *service;
@property (nonatomic, strong) NSString *format;
@property (nonatomic, strong) NSString *req_data;
@property (nonatomic, strong) NSString *sec_id;
@property (nonatomic, strong) NSString *v;
@property (nonatomic, strong) NSString *sign;
// only for alipay ---.

- (id)initWithAttributes:(NSDictionary *)attributes;

@end
