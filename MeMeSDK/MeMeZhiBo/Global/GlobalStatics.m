//
//  GlobalStatics.m
//  TTShow
//
//  Created by twb on 13-7-3.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import "GlobalStatics.h"
#import "NSBundle+SDK.h"

static NSString *_DOCUMENT_PATH = nil;
static NSDateFormatter *_DATETIME_FMT = nil;
static NSDateFormatter *_DATETIME_MINUTE_FMT = nil;
static NSDateFormatter *_MONTH_MINUTE_FMT = nil;
static NSDateFormatter *_DATETIME_LOG_FMT = nil;
static NSDateFormatter *_DATETIME_SIGN_FMT = nil;
static NSDateFormatter *_TIME_BROADCAST_FMT = nil;
static NSDateFormatter *_DATETIME_FMT_NO_EAST8 = nil;
static NSDateFormatter *_DATE_FMT = nil;
static NSDateFormatter *_TIME_FMT = nil;
static NSDate *_SERVER_DATETIME = nil;
static NSDecimalNumberHandler *_DEC_FLOOR_HANDLER = nil;
static NSDecimalNumberHandler *_DEF_ROUND_HANDLER = nil;
static NSNumberFormatter *_DEF_DECIMAL_FORMATTER = nil;
static UIView *_EMPTY_INPUT_VIEW = nil;
static NSNumberFormatter * _PRICE_FORMATTER = nil;
static TTExpressionKeyboard *_EXPRESSION_KEYBOARD = nil;
//static ShortcutView *_SHORTCUTVIEW = nil;
static NSArray *_EXPRESSIONS = nil;
static NSArray *_IAP_PRODUCTS = nil;

@implementation GlobalStatics

+ (void) initAll
{
	_DOCUMENT_PATH = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
	_DATETIME_FMT = [[NSDateFormatter alloc] init];
	_DATETIME_FMT.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"Asia/Shanghai"];
	_DATETIME_FMT.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    _DATETIME_MINUTE_FMT = [[NSDateFormatter alloc] init];
    _DATETIME_MINUTE_FMT.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"Asia/Shanghai"];
    _DATETIME_MINUTE_FMT.dateFormat = @"yyyy-MM-dd HH:mm";
    
    _MONTH_MINUTE_FMT = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    _MONTH_MINUTE_FMT = [[NSDateFormatter alloc] init];
    _MONTH_MINUTE_FMT.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"Asia/Shanghai"];
    _MONTH_MINUTE_FMT.dateFormat = @"MM-dd HH:mm";
    
    _DATETIME_LOG_FMT = [[NSDateFormatter alloc] init];
	_DATETIME_LOG_FMT.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"Asia/Shanghai"];
	_DATETIME_LOG_FMT.dateFormat = @"yyyyMMddHHmm";
    
    _DATETIME_SIGN_FMT = [[NSDateFormatter alloc] init];
    _DATETIME_SIGN_FMT.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"Asia/Shanghai"];
    _DATETIME_SIGN_FMT.dateFormat = @"yyyyMMdd";
    
    _TIME_BROADCAST_FMT = [[NSDateFormatter alloc] init];
    _TIME_BROADCAST_FMT.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"Asia/Shanghai"];
    _TIME_BROADCAST_FMT.dateFormat = @"HH:mm";
    
    _DATETIME_FMT_NO_EAST8 = [[NSDateFormatter alloc] init];
    _DATETIME_FMT_NO_EAST8.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    _DATETIME_FMT_NO_EAST8.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
	_DATE_FMT = [[NSDateFormatter alloc] init];
	_DATE_FMT.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"Asia/Shanghai"];
	_DATE_FMT.dateFormat = @"yyyy-MM-dd";
	
	_TIME_FMT = [[NSDateFormatter alloc] init];
	_TIME_FMT.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"Asia/Shanghai"];
	_TIME_FMT.dateFormat = @"HHmmss";
	
	_DEC_FLOOR_HANDLER = [[NSDecimalNumberHandler alloc]
                          initWithRoundingMode: NSRoundDown
                          scale:0
                          raiseOnExactness:NO
                          raiseOnOverflow:NO
                          raiseOnUnderflow:NO
                          raiseOnDivideByZero:NO];
	_DEF_ROUND_HANDLER = [[NSDecimalNumberHandler alloc]
                          initWithRoundingMode: NSRoundPlain
                          scale:4
                          raiseOnExactness:NO
                          raiseOnOverflow:NO
                          raiseOnUnderflow:NO
                          raiseOnDivideByZero:NO];
	_DEF_DECIMAL_FORMATTER = [[NSNumberFormatter alloc] init];
	[_DEF_DECIMAL_FORMATTER setNumberStyle:NSNumberFormatterDecimalStyle];
	[_DEF_DECIMAL_FORMATTER setMaximumFractionDigits:2];
	[_DEF_DECIMAL_FORMATTER setRoundingMode: NSNumberFormatterRoundDown];
	_EMPTY_INPUT_VIEW = [[UIView alloc] initWithFrame:CGRectZero];
    _PRICE_FORMATTER = [[NSNumberFormatter alloc] init];
    [_PRICE_FORMATTER setFormatterBehavior:NSNumberFormatterBehavior10_4];
    [_PRICE_FORMATTER setNumberStyle:NSNumberFormatterCurrencyStyle];
    
    NSString *expressionsPath = [[NSBundle SDKResourcesBundle] pathForResource:@"pics/TTShowExpression" ofType:@"plist"];
    _EXPRESSIONS = [NSArray arrayWithContentsOfFile:expressionsPath];
    
    _EXPRESSION_KEYBOARD = [[TTExpressionKeyboard alloc] initWithFrame:CGRectMake(0.0f, kScreenHeight, kScreenWidth, 216.0f)];
}

+ (NSString *)DOCUMENT_PATH
{
	return _DOCUMENT_PATH;
}

+ (NSDateFormatter *)DATETIME_FMT
{
	return _DATETIME_FMT;
}

+ (NSDateFormatter *)DATETIME_MINUTE_FMT
{
    return _DATETIME_MINUTE_FMT;
}

+ (NSDateFormatter *)MONTH_MINUTE_FMT
{
    return _MONTH_MINUTE_FMT;
}

+ (NSDateFormatter *)DATETIME_LOG_FMT
{
    return _DATETIME_LOG_FMT;
}

+ (NSDateFormatter *)DATETIME_SIGN_FMT
{
    return _DATETIME_SIGN_FMT;
}

+ (NSDateFormatter *)TIME_BROADCAST_FMT
{
    return _TIME_BROADCAST_FMT;
}

+ (NSDateFormatter *)DATETIME_FMT_NO_EAST8
{
    return _DATETIME_FMT_NO_EAST8;
}

+ (NSDateFormatter *)DATE_FMT
{
	return _DATE_FMT;
}

+ (NSDateFormatter *)TIME_FMT
{
	return _TIME_FMT;
}

+ (void)SET_SERVER_DATETIME:(NSDate *)date
{
    if (_SERVER_DATETIME != nil)
    {
        _SERVER_DATETIME = nil;
    }
    
    _SERVER_DATETIME = date;
}

+ (NSDate *)SERVER_DATETIME
{
    return _SERVER_DATETIME;
}

+ (NSDecimalNumberHandler *)DEC_FLOOR_HANDLER
{
	return _DEC_FLOOR_HANDLER;
}

+ (NSDecimalNumberHandler *)DEF_ROUND_HANDLER
{
	return _DEF_ROUND_HANDLER;
}

+ (NSNumberFormatter *)DEF_DECIMAL_FORMATTER
{
	return _DEF_DECIMAL_FORMATTER;
}

+ (UIView *)EMPTY_INPUT_VIEW
{
	return _EMPTY_INPUT_VIEW;
}

+ (NSNumberFormatter *)PRICE_FORMATTER
{
    return _PRICE_FORMATTER;
}

+ (TTExpressionKeyboard *)EXPRESSION_KEYBOARD
{
    if (_EXPRESSION_KEYBOARD == nil)
    {
        _EXPRESSION_KEYBOARD = [[TTExpressionKeyboard alloc] initWithFrame:CGRectMake(0.0f, kScreenHeight, kScreenWidth, 216.0f)];
    }
    return _EXPRESSION_KEYBOARD;
}

+ (void)REMOVE_EXPRESSION_KEYBOARD
{
    if (_EXPRESSION_KEYBOARD != nil)
    {
        [_EXPRESSION_KEYBOARD removeFromSuperview];
        _EXPRESSION_KEYBOARD = nil;
    }
}

//+ (ShortcutView *)SHORTCUTVIEW
//{
//    if (_SHORTCUTVIEW == nil)
//    {
//        _SHORTCUTVIEW = [[ShortcutView alloc] initWithFrame:CGRectMake(0.0f, kScreenHeight, kScreenWidth, 216.0f)];
//    }
//    return _SHORTCUTVIEW;
//}
//
//+ (void)REMOVE_SHORTCUTVIEW
//{
//    if (_SHORTCUTVIEW != nil)
//    {
//        [_SHORTCUTVIEW removeFromSuperview];
//        _SHORTCUTVIEW = nil;
//    }
//}

+ (NSArray *)EXPRESSIONS
{
    return _EXPRESSIONS;
}

+ (NSArray *)IAP_PRODUCTS
{
    return _IAP_PRODUCTS;
}

+ (void)SET_IAP_PRODUCTS:(NSArray *)products
{
    if (!_IAP_PRODUCTS)
    {
        _IAP_PRODUCTS = [NSArray arrayWithArray:products];
    }
}

@end
