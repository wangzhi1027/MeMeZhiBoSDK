//
//  NSDictionary+SafeValue.h
//  PPTVCore
//
//  Created by ospreyren on 5/14/14.
//  Copyright (c) 2014 PPLive Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (SafeValue)
/**
 @brief   取一个安全的NSString对象
 @return  akey对应的实例不是NSString则返回nil
 */
- (NSString *)safeStringForKey:(id)aKey;

/**
 @brief   取一个安全的NSNumber对象
 @return  akey对应的实例不是NSNumber则返回nil
 */
- (NSNumber *)safeNumberForKey:(id)aKey;

/**
 @brief   取一个安全的NSArray对象
 @return  akey对应的实例不是NSArray则返回nil
 */
- (NSArray *)safeArrayForKey:(id)aKey;

/**
 @brief   取一个安全的NSDictionary对象
 @return  akey对应的实例不是NSDictionary则返回nil
 */
- (NSDictionary *)safeDictionaryForKey:(id)aKey;

@end
