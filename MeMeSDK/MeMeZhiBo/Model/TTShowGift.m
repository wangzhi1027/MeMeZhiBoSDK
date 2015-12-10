//
//  TTShowGift.m
//  TTShow
//
//  Created by twb on 13-6-18.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import "TTShowGift.h"

#pragma mark - Gift Category

@implementation TTShowGiftCategory

- (id)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    /*
     @property (nonatomic, assign) NSUInteger _id;
     @property (nonatomic, assign) NSUInteger lucky;
     @property (nonatomic, strong) NSString *name;
     @property (nonatomic, assign) NSUInteger order;
     @property (nonatomic, assign) CGFloat ratio;
     @property (nonatomic, assign) NSUInteger status;
     @property (nonatomic, assign) NSUInteger vip;
     */
    self._id = [[attributes valueForKey:@"_id"] unsignedIntegerValue];
    self.lucky = [[attributes valueForKey:@"lucky"] unsignedIntegerValue];
    self.name = [attributes valueForKey:@"name"];
    self.order = [[attributes valueForKey:@"order"] unsignedIntegerValue];
    self.ratio = [[attributes valueForKey:@"ratio"] floatValue];
    self.status = [[attributes valueForKey:@"status"] unsignedIntegerValue];
    self.vip = [[attributes valueForKey:@"vip"] unsignedIntegerValue];
    
    
    return self;
}

@end

#pragma mark - Gift Class.

@implementation TTShowGift

- (id)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    /*
     @property (nonatomic, assign) NSUInteger _id;
     @property (nonatomic, strong) NSString *name;
     @property (nonatomic, strong) NSString *pic_url;
     @property (nonatomic, strong) NSString *swf_url;
     @property (nonatomic, strong) NSString *pic_pre_url;
     @property (nonatomic, assign) NSUInteger coin_price;
     @property (nonatomic, assign) NSUInteger category_id;
     @property (nonatomic, assign) NSUInteger count;
     
     @property (nonatomic, assign) NSUInteger star;
     @property (nonatomic, assign) NSUInteger star_limit;
     @property (nonatomic, assign) NSUInteger status;
     @property (nonatomic, assign) NSUInteger order;
     */
    self._id = [[attributes valueForKey:@"_id"] unsignedIntegerValue];
    self.name = [attributes valueForKey:@"name"];
    self.pic_url = [attributes valueForKey:@"pic_url"];
    self.swf_url = [attributes valueForKey:@"swf_url"];
    self.pic_pre_url = [attributes valueForKey:@"pic_pre_url"];
    self.coin_price = [[attributes valueForKey:@"coin_price"] unsignedIntegerValue];
    self.category_id = [[attributes valueForKey:@"category_id"] unsignedIntegerValue];
    self.count = [[attributes valueForKey:@"count"] unsignedIntegerValue];
    self.sale = [[attributes valueForKey:@"sale"] boolValue];
//    self.sale = [[attributes valueForKey:@"isHot"] boolValue];
//    self.sale = [[attributes valueForKey:@"isNew"] boolValue];
    
    self.star = [[attributes valueForKey:@"star"] unsignedIntegerValue];
    self.star_limit = [[attributes valueForKey:@"star_limit"] unsignedIntegerValue];
    self.status = [[attributes valueForKey:@"status"] unsignedIntegerValue];
    self.order = [[attributes valueForKey:@"order"] unsignedIntegerValue];
    
    return self;
}

#pragma mark - NSCoding Protocal

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:[NSNumber numberWithUnsignedInteger:self._id] forKey:@"_id"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.pic_url forKey:@"pic_url"];
    [aCoder encodeObject:self.swf_url forKey:@"swf_url"];
    [aCoder encodeObject:self.pic_pre_url forKey:@"pic_pre_url"];
    [aCoder encodeObject:[NSNumber numberWithUnsignedInteger:self.coin_price] forKey:@"coin_price"];
    [aCoder encodeObject:[NSNumber numberWithUnsignedInteger:self.category_id] forKey:@"category_id"];
    [aCoder encodeObject:[NSNumber numberWithUnsignedInteger:self.count] forKey:@"count"];
    [aCoder encodeObject:[NSNumber numberWithBool:self.sale] forKey:@"sale"];
    
    [aCoder encodeObject:@(self.star) forKey:@"star"];
    [aCoder encodeObject:@(self.star_limit) forKey:@"star_limit"];
    [aCoder encodeObject:@(self.status) forKey:@"status"];
    [aCoder encodeObject:@(self.order) forKey:@"order"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        self._id = [[aDecoder decodeObjectForKey:@"_id"] unsignedIntegerValue];
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.pic_url = [aDecoder decodeObjectForKey:@"pic_url"];
        self.swf_url = [aDecoder decodeObjectForKey:@"swf_url"];
        self.pic_pre_url = [aDecoder decodeObjectForKey:@"pic_pre_url"];
        self.coin_price = [[aDecoder decodeObjectForKey:@"coin_price"] unsignedIntegerValue];
        self.category_id = [[aDecoder decodeObjectForKey:@"category_id"] unsignedIntegerValue];
        self.count = [[aDecoder decodeObjectForKey:@"count"] unsignedIntegerValue];
        self.sale = [[aDecoder decodeObjectForKey:@"sale"] boolValue];
        
        self.star = [[aDecoder decodeObjectForKey:@"star"] unsignedIntegerValue];
        self.star_limit = [[aDecoder decodeObjectForKey:@"star_limit"] unsignedIntegerValue];
        self.status = [[aDecoder decodeObjectForKey:@"status"] unsignedIntegerValue];
        self.order = [[aDecoder decodeObjectForKey:@"order"] unsignedIntegerValue];
    }
    return self;
}

@end

#pragma mark - Xiaowo Class.

@implementation XiaowoGift

- (id)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    /*
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
     
     */
    self._id = [[attributes valueForKey:@"_id"] unsignedIntegerValue];
    self.name = [attributes valueForKey:@"name"];
    self.pic_url = [attributes valueForKey:@"pic_url"];
    self.swf_url = [attributes valueForKey:@"swf_url"];
    self.pic_pre_url = [attributes valueForKey:@"pic_pre_url"];
    self.coin_price = [[attributes valueForKey:@"coin_price"] unsignedIntegerValue];
    self.status = [[attributes valueForKey:@"status"] unsignedIntegerValue];
    self.order = [[attributes valueForKey:@"order"] unsignedIntegerValue];
    
    self.boxer_ratio = [[attributes valueForKey:@"boxer_ratio"] floatValue];
    self.ratio = [[attributes valueForKey:@"order"] floatValue];
    
    return self;
}

#pragma mark - NSCoding Protocal

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:[NSNumber numberWithUnsignedInteger:self._id] forKey:@"_id"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.pic_url forKey:@"pic_url"];
    [aCoder encodeObject:self.swf_url forKey:@"swf_url"];
    [aCoder encodeObject:self.pic_pre_url forKey:@"pic_pre_url"];
    [aCoder encodeObject:[NSNumber numberWithUnsignedInteger:self.coin_price] forKey:@"coin_price"];
    
    //    boxer_ratio ratio
    [aCoder encodeObject:@(self.status) forKey:@"status"];
    [aCoder encodeObject:@(self.order) forKey:@"order"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        self._id = [[aDecoder decodeObjectForKey:@"_id"] unsignedIntegerValue];
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.pic_url = [aDecoder decodeObjectForKey:@"pic_url"];
        self.swf_url = [aDecoder decodeObjectForKey:@"swf_url"];
        self.pic_pre_url = [aDecoder decodeObjectForKey:@"pic_pre_url"];
        self.coin_price = [[aDecoder decodeObjectForKey:@"coin_price"] unsignedIntegerValue];
        
        //      boxer_ratio ratio
        self.status = [[aDecoder decodeObjectForKey:@"status"] unsignedIntegerValue];
        self.order = [[aDecoder decodeObjectForKey:@"order"] unsignedIntegerValue];
    }
    return self;
}

@end