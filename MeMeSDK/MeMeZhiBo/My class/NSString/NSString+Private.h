//
//  NSString+Private.h
//  TTShow
//
//  Created by twb on 13-6-3.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Private)

- (NSString *)MD5String;
- (NSString *)stringByUnescapingFromHTML;
- (BOOL)isAllDigit;
//- (BOOL)containsString:(NSString *)otherString;
@end
