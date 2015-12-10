//
//  NSDate+TTShow.h
//  TTShow
//
//  Created by twb on 13-7-3.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (TTShow)

+ (NSString *)currentDateTimeString;
+ (NSString *)currentDateString;
+ (NSString *)currentTimeString;
+ (NSDate *)time2Date:(long long int)timestamp;
+ (long long int)currentTimeStamp;
- (NSString *)dateTimeString;
- (NSString *)dateTimeMinuteString;
- (NSString *)monthMinuteString;
- (NSString *)dateString;
- (NSString *)timeString;
@end
