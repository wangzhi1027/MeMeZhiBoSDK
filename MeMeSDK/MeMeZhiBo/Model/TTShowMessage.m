//
//  TTShowMessage.m
//  TTShow
//
//  Created by twb on 14-5-22.
//  Copyright (c) 2014年 twb. All rights reserved.
//

#import "TTShowMessage.h"

@implementation TTShowMessage

- (id)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    /*
     @property (nonatomic, strong) NSString *_id;
     @property (nonatomic, assign) NSInteger type;
     @property (nonatomic, assign) NSInteger t;
     @property (nonatomic, assign) NSInteger tdel;
     @property (nonatomic, assign) NSInteger tread;
     @property (nonatomic, strong) NSString *title;
     @property (nonatomic, strong) NSString *content;
     @property (nonatomic, assign) long long int timestamp;
     */
    self._id = attributes[@"_id"];
    self.type = [attributes[@"type"] integerValue];
    self.t = [attributes[@"t"] integerValue];
    self.tdel = [attributes[@"tdel"] integerValue];
    self.tread = [attributes[@"tread"] integerValue];
    self.title = attributes[@"title"];
    self.content = attributes[@"content"];
    self.timestamp = [attributes[@"timestamp"] longLongValue];
    
    return self;
}

- (BOOL)isAlreadyRead
{
    return self.tread == 1;
}

@end

@implementation TTShowRemind

- (id)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    /*
     @property (nonatomic, strong) NSString *_id;
     @property (nonatomic, assign) NSInteger t;
     @property (nonatomic, strong) NSString *tid;
     @property (nonatomic, assign) NSInteger remind;
     @property (nonatomic, assign) NSInteger tdel;
     @property (nonatomic, assign) NSInteger tread;
     @property (nonatomic, strong) NSString *cid;
     @property (nonatomic, assign) NSInteger cate;
     @property (nonatomic, assign) NSInteger type;
     @property (nonatomic, strong) NSString *content;
     @property (nonatomic, assign) long long int timestamp;
     */
    self._id = attributes[@"_id"];
    self.t = [attributes[@"t"] integerValue];
    self.tid = attributes[@"tid"];
    self.remind = [attributes[@"remind"] integerValue];
    self.tdel = [attributes[@"tdel"] integerValue];
    self.tread = [attributes[@"tread"] integerValue];
    self.cid = attributes[@"cid"];
    self.cate = [attributes[@"cate"] integerValue];
    self.type = [attributes[@"type"] integerValue];
    self.content = attributes[@"content"];
    self.timestamp = [attributes[@"timestamp"] longLongValue];
    
    return self;
}

- (BOOL)isAlreadyRead
{
    return self.tread == 1;
}
@end
