//
//  BagGift.m
//  TTShow
//
//  Created by xh on 15/4/8.
//  Copyright (c) 2015年 twb. All rights reserved.
//

#import "BagGift.h"

@implementation BagGift

+(JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc]initWithDictionary:@{
                                                      @"data.bag" : @"bag"}];
}
@end
