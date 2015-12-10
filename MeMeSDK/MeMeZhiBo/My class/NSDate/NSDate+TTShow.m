//
//  NSDate+TTShow.m
//  TTShow
//
//  Created by twb on 13-7-3.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import "NSDate+TTShow.h"
#import "GlobalStatics.h"

// dateWithTimeIntervalSince1970

@implementation NSDate (TTShow)

+ (NSString *)currentDateTimeString
{
	return [[NSDate date] dateTimeString];
}

+ (NSString *)currentDateString
{
	return [[NSDate date] dateString];
}

+ (NSString *)currentTimeString
{
	return [[NSDate date] timeString];
}

+ (NSDate *)time2Date:(long long int)timestamp
{
    return [NSDate dateWithTimeIntervalSince1970:[DataGlobalKit filterTimeStamp:[NSString stringWithFormat:@"%lld", timestamp]]];
}

+ (long long int)currentTimeStamp
{
    return [[NSDate date] timeIntervalSince1970] * 1000;
}

- (NSString *)dateTimeString
{
	return [[GlobalStatics DATETIME_FMT] stringFromDate:self];
}

- (NSString *)dateTimeMinuteString
{
    return [[GlobalStatics DATETIME_MINUTE_FMT] stringFromDate:self];
}

- (NSString *)monthMinuteString
{
    return [[GlobalStatics MONTH_MINUTE_FMT] stringFromDate:self];
}

- (NSString *)dateString
{
	return [[GlobalStatics DATE_FMT] stringFromDate:self];
}

- (NSString *)timeString
{
	return [[GlobalStatics TIME_FMT] stringFromDate:self];
}

@end
