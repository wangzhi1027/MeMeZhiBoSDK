//
//  TTShowMessage.h
//  TTShow
//
//  Created by twb on 14-5-22.
//  Copyright (c) 2014年 twb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTShowMessage : NSObject

@property (nonatomic, strong) NSString *_id;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, assign) NSInteger t;
@property (nonatomic, assign) NSInteger tdel;
@property (nonatomic, assign) NSInteger tread;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, assign) long long int timestamp;

- (id)initWithAttributes:(NSDictionary *)attributes;

- (BOOL)isAlreadyRead;
@end

@interface TTShowRemind : NSObject

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

- (id)initWithAttributes:(NSDictionary *)attributes;

- (BOOL)isAlreadyRead;
@end
