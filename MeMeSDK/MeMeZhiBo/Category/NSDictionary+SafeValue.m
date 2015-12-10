//
//  NSDictionary+SafeValue.m
//  PPTVCore
//
//  Created by ospreyren on 5/14/14.
//  Copyright (c) 2014 PPLive Corporation. All rights reserved.
//

#import "NSDictionary+SafeValue.h"
#import "NSObject+SafeValueWithJSON.h"

@implementation NSDictionary (SafeValue)

- (NSString *)safeStringForKey:(id)aKey {
    return [[self objectForKey:aKey] safeString];
}

- (NSNumber *)safeNumberForKey:(id)aKey {
    return [[self objectForKey:aKey] safeNumber];
}

- (NSArray *)safeArrayForKey:(id)aKey {
    return [[self objectForKey:aKey] safeArray];
}

- (NSDictionary *)safeDictionaryForKey:(id)aKey {
    return [[self objectForKey:aKey] safeDictionary];
}

@end
