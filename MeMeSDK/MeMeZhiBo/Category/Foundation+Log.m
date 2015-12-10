//
//  Foundation+Log.h
//  Test
//
//  Created by XIN on 15/10/28.
//  Copyright © 2015年 XIN. All rights reserved.
//

#import "Foundation+Log.h"

@implementation NSDictionary (Log)

- (NSString *)descriptionWithLocale:(id)locale
{
    NSMutableString *str = [NSMutableString string];
    
    [str appendString:@"{\n"];
    
    // 遍历字典的所有键值对
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [str appendFormat:@"\t%@ = %@,\n", key, obj];
    }];
    
    [str appendString:@"}"];
    
    // 查出最后一个,的范围
    NSRange range = [str rangeOfString:@"," options:NSBackwardsSearch];
    if (range.length != 0) {
        // 删掉最后一个,
        [str deleteCharactersInRange:range];
    }
    
    return str;
}

@end

@implementation NSArray (Log)

/*
- (NSString *)descriptionWithLocale:(id)locale
{
    NSMutableString *str = [NSMutableString string];
    
    [str appendString:@"[\n"];
    
    // 遍历数组的所有元素
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [str appendFormat:@"%@,\n", obj];
    }];
    
    [str appendString:@"]"];
    
    // 查出最后一个,的范围
    NSRange range = [str rangeOfString:@"," options:NSBackwardsSearch];
    if (range.length != 0) {
        // 删掉最后一个,
        [str deleteCharactersInRange:range];
    }
    
    return str;
}
*/

// 如果要跟踪NSArray中的内容，需要重写descriptionWithLocale方法
- (NSString *)descriptionWithLocale:(id)locale
{
    NSMutableString *string = [NSMutableString string];
    
    [string appendFormat:@"%tu (", self.count];
    
    for (id obj in self) {
        [string appendFormat:@"\n\t\"%@\",", obj];
    }
    
    [string appendString:@"\n)"];
    
    return string;
}

/*
 第一种方法输出结果：
 [
 1,
 2,
 张新,
 我是哈哈
 ]
 
第二种方法输出结果：
 4 (
 "1",
 "2",
 "张新",
 "我是哈哈",
 )
 */

@end
