//
//  TTShowGift.h
//  TTShow
//
//  Created by twb on 13-6-18.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - Gift Category.

@interface TTShowGiftCategory : NSObject

@property (nonatomic, assign) NSUInteger _id;
@property (nonatomic, assign) NSUInteger lucky;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSUInteger order;
@property (nonatomic, assign) CGFloat ratio;
@property (nonatomic, assign) NSUInteger status;
@property (nonatomic, assign) NSUInteger vip;

- (id)initWithAttributes:(NSDictionary *)attributes;

@end

#pragma mark - Gift Class.

@interface TTShowGift : NSObject <NSCoding>

@property (nonatomic, assign) NSUInteger _id;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *pic_url;
@property (nonatomic, strong) NSString *swf_url;
@property (nonatomic, strong) NSString *pic_pre_url;
@property (nonatomic, assign) NSUInteger coin_price;
@property (nonatomic, assign) NSUInteger category_id;
@property (nonatomic, assign) NSUInteger count;
@property (nonatomic, assign) BOOL sale;
//@property (nonatomic, assign) BOOL isHot;
//@property (nonatomic, assign) BOOL isNew;

@property (nonatomic, assign) NSUInteger star;
@property (nonatomic, assign) NSUInteger star_limit;
@property (nonatomic, assign) NSUInteger status;
@property (nonatomic, assign) NSUInteger order;

- (id)initWithAttributes:(NSDictionary *)attributes;

@end

#pragma mark - XiaowoGift Class.

@interface XiaowoGift : NSObject <NSCoding>

@property (nonatomic, assign) NSUInteger _id;
@property (nonatomic, strong) NSString *swf_url;
@property (nonatomic, assign) float boxer_ratio;
@property (nonatomic, assign) NSUInteger order;
@property (nonatomic, assign) float ratio;
@property (nonatomic, assign) NSUInteger status;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSUInteger coin_price;
@property (nonatomic, strong) NSString *pic_url;
@property (nonatomic, strong) NSString *pic_pre_url;


- (id)initWithAttributes:(NSDictionary *)attributes;

@end
