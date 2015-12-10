//
//  NSBundle+SDK.m
//  MeMeZhiBo
//
//  Created by XIN on 15/11/23.
//  Copyright (c) 2015年 XIN. All rights reserved.
//

#import "NSBundle+SDK.h"

@implementation NSBundle (SDK)

+ (NSBundle*)SDKResourcesBundle
{
    static dispatch_once_t onceToken;
    static NSBundle *myResourceBundle = nil;
    dispatch_once(&onceToken, ^{
        myResourceBundle = [NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:@"Resources" withExtension:@"bundle"]];
    });
    return myResourceBundle;
}

@end
