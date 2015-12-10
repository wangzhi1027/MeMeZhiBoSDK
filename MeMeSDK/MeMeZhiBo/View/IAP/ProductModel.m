//
//  ProductModel.m
//  memezhibo
//
//  Created by Xingai on 15/6/30.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "ProductModel.h"

@implementation ProductModel

- (id)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.desc = attributes[@"desc"];
    
    self.key = attributes[@"key"];

    self.price = [attributes[@"price"] integerValue];
    
    return self;
}

@end
