//
//  NSError+Private.m
//  TTShow
//
//  Created by twb on 13-8-8.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import "NSError+Private.h"

@implementation NSError (Private)

+ (NSError *)errorMsg:(NSString *)localDesc
{
    return [self errorMsg:localDesc code:0];
}

+ (NSError *)errorMsg:(NSString *)localDesc code:(NSInteger)code
{
    if (localDesc == nil || [localDesc isEqualToString:@""])
    {
        return [NSError errorWithDomain:@"TTShow" code:0 userInfo:[NSDictionary dictionaryWithObject:@"未知错误" forKey:NSLocalizedDescriptionKey]];
    }
    
    return [NSError errorWithDomain:@"TTShow" code:code userInfo:[NSDictionary dictionaryWithObject:localDesc forKey:NSLocalizedDescriptionKey]];
}

+ (NSError *)errorDataFormat
{
    return [NSError errorWithDomain:@"TTShow" code:0 userInfo:[NSDictionary dictionaryWithObject:@"数据解析异常" forKey:NSLocalizedDescriptionKey]];
}


@end
