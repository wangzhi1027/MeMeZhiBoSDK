//
//  ProductModel.h
//  memezhibo
//
//  Created by Xingai on 15/6/30.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductModel : NSObject

@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *key;
@property (nonatomic, assign) NSInteger price;

- (id)initWithAttributes:(NSDictionary *)attributes;

@end
