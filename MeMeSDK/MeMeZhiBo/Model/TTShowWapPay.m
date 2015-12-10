//
//  TTShowWapPay.m
//  TTShow
//
//  Created by twb on 13-12-2.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import "TTShowWapPay.h"

@implementation TTShowWapPay

- (id)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    /*
     @property (nonatomic, strong) NSString *requestURL;
     @property (nonatomic, strong) NSString *callbackURL;
     @property (nonatomic, strong) NSString *notifyURL;

     @property (nonatomic, strong) NSString *partner;
     @property (nonatomic, strong) NSString *service;
     @property (nonatomic, strong) NSString *format;
     @property (nonatomic, strong) NSString *req_data;
     @property (nonatomic, strong) NSString *sec_id;
     @property (nonatomic, strong) NSString *v;
     @property (nonatomic, strong) NSString *sign;
     */
    
    self.requestURL = attributes[@"requestURL"];
    self.callbackURL = attributes[@"callbackURL"];
    self.notifyURL = attributes[@"notifyURL"];
    
    self.partner = attributes[@"partner"];
    self.service = attributes[@"service"];
    self.format = attributes[@"format"];
    self.req_data = attributes[@"req_data"];
    self.sec_id = attributes[@"sec_id"];
    self.v = attributes[@"v"];
    self.sign = attributes[@"sign"];
    
#if 1
    if (![self.partner isEqualToString:@""] && ![self.service isEqualToString:@""])
    {
        self.requestURL = [NSString stringWithFormat:
                           @"%@?req_data=%@&service=%@&sec_id=%@&partner=%@&sign=%@&format=%@&v=%@",
                           self.requestURL,
                           self.req_data,
                           self.service,
                           self.sec_id,
                           self.partner,
                           self.sign,
                           self.format,
                           self.v];
    }
#endif
    
    return self;
}

@end
