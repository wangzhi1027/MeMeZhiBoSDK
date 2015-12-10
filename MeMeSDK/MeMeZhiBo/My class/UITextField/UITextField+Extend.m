//
//  UITextField+Extend.m
//  TTShow
//
//  Created by Xingai on 15/9/16.
//  Copyright (c) 2015年 twb. All rights reserved.
//

#import "UITextField+Extend.h"

@implementation UITextField (Extend)

- (BOOL)containExpression:(NSString *)exp max:(NSInteger)maxLength
{
    if ([self getLastExpression:maxLength].length >= maxLength
        && [exp isEqualToString:[self getLastExpression:maxLength]])
    {
        return YES;
    }
    return NO;
}

- (NSString *)getLastExpression:(NSInteger)maxLength
{
    NSInteger loc = self.text.length - maxLength;
    if (loc < 0)
    {
        return nil;
    }
    return [self.text substringFromIndex:loc];
}

- (NSString *)getRemainText:(NSInteger)maxLength
{
    NSInteger loc = self.text.length - maxLength;
    if (loc < 0)
    {
        return nil;
    }
    return [self.text substringToIndex:loc];
}

- (void)deleteBackwardForExpression
{
//    NSAssert(self.selectedRange.location >= 0, @"deleteBackwardForExpression Error.");
//    NSString *fullString = [self.text substringToIndex:self.selectedRange.location];
    
    NSArray *arr = [self.text componentsSeparatedByString:@"/"];
    
    NSString *fullString = [NSString stringWithFormat:@"/%@",arr[arr.count-1]];
    BOOL containExpression = NO;
    
    
    if (fullString == nil || [fullString isEqualToString:@""])
    {
        return;
    }
    
    for (NSString *exp in [GlobalStatics EXPRESSIONS])
    {
        if ([self containExpression:exp max:2])
        {
            fullString = [self getRemainText:2];
            containExpression = YES;
            break;
        }
        if ([self containExpression:exp max:3])
        {
            fullString = [self getRemainText:3];
            containExpression = YES;
            break;
        }
        if ([self containExpression:exp max:4])
        {
            fullString = [self getRemainText:4];
            containExpression = YES;
            break;
        }
        if ([self containExpression:exp max:5])
        {
            fullString = [self getRemainText:5];
            containExpression = YES;
            break;
        }
    }
    
    if (containExpression)
    {
        self.text = fullString;
    }
    else
    {
        [self deleteBackward];
    }
}


@end
