//
//  NSObject+SaveValueWithJSON.m
//

#import "NSObject+SafeValueWithJSON.h"

@implementation NSObject (SafeValueWithJSON)

- (id)safeValueFromJSON
{
    return self == [NSNull null] ? nil : self;
}

- (id)safeObjectWithClass:(Class)aClass
{
    if ([self isKindOfClass:aClass]) {
        return self;
    } else {
//        NSAssert(NO,
//                 @"Object class not matched, self is %@, should be %@",
//                 NSStringFromClass([self class]),
//                 NSStringFromClass(aClass));
        return nil;
    }
}

- (NSString *)safeString
{
    return [self safeObjectWithClass:[NSString class]];
}

- (NSNumber *)safeNumber
{
    return [self safeObjectWithClass:[NSNumber class]];
}

- (NSArray *)safeArray
{
    return [self safeObjectWithClass:[NSArray class]];
}

- (NSDictionary *)safeDictionary
{
    return [self safeObjectWithClass:[NSDictionary class]];
}

- (NSDate *)safeDate
{
    return [self safeObjectWithClass:[NSDate class]];
}

@end
