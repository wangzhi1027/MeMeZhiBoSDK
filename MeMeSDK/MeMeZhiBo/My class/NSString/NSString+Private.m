//
//  NSString+Private.m
//  TTShow
//
//  Created by twb on 13-6-3.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import "NSString+Private.h"
#import <CommonCrypto/CommonDigest.h>

#define kMD5Length (16)

@implementation NSString (Private)

-(NSString *)MD5String
{
    const char *original_str = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, (CC_LONG)strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < kMD5Length; i++)
    {
        [hash appendFormat:@"%02X", result[i]];
    }
    return [hash lowercaseString];
}

- (NSString *)stringByUnescapingFromHTML
{
    return [self gtm_stringByUnescapingFromHTML];
}

- (BOOL)isAllDigit
{
    unichar c;
    for (NSInteger i = 0; i < self.length; i++)
    {
        c = [self characterAtIndex:i];
        if (!isdigit(c))
        {
            return NO;
        }
    }
    return YES;
}

@end
