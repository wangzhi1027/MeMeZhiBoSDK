//
//  NSError+Private.h
//  TTShow
//
//  Created by twb on 13-8-8.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSError (Private)

+ (NSError *)errorMsg:(NSString *)localDesc;
+ (NSError *)errorMsg:(NSString *)localDesc code:(NSInteger)code;
+ (NSError *)errorDataFormat;
@end
