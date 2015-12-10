//
//  TTShowCar.m
//  TTShow
//
//  Created by twb on 13-7-12.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import "TTShowCar.h"

@implementation TTShowCar

- (id)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if (!self)
    {
        return nil;
    }
    
    /*
     @property (nonatomic, assign) NSInteger _id;
     @property (nonatomic, strong) NSString *cat;
     @property (nonatomic, strong) NSString *swf_url;
     @property (nonatomic, assign) NSInteger order;
     @property (nonatomic, assign) BOOL status;
     @property (nonatomic, strong) NSString *name;
     @property (nonatomic, assign) NSInteger coin_price;
     @property (nonatomic, strong) NSString *pic_pre_url;
     @property (nonatomic, strong) NSString *pic_url;
     */
    
    self._id = [[attributes valueForKey:@"_id"] integerValue];
    self.cat = [[attributes valueForKey:@"cat"] integerValue];
    self.swf_url = [attributes valueForKey:@"swf_url"];
    self.order = [[attributes valueForKey:@"order"] integerValue];
    self.status = [[attributes valueForKey:@"status"] boolValue];
    self.name = [attributes valueForKey:@"name"];
    self.coin_price = [[attributes valueForKey:@"coin_price"] integerValue];
    self.pic_pre_url = [attributes valueForKey:@"pic_pre_url"];
    self.pic_url = [attributes valueForKey:@"pic_url"];
    
    return self;
}

@end
