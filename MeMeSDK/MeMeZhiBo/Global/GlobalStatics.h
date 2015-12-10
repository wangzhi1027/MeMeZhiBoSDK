//
//  GlobalStatics.h
//  TTShow
//
//  Created by twb on 13-7-3.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTExpressionKeyboard.h"
//#import "ShortcutView.h"

@interface GlobalStatics : NSObject

+ (void) initAll;

+ (NSString *)DOCUMENT_PATH;
+ (NSDateFormatter *)DATETIME_FMT;
+ (NSDateFormatter *)DATETIME_MINUTE_FMT;
+ (NSDateFormatter *)MONTH_MINUTE_FMT;
+ (NSDateFormatter *)DATETIME_LOG_FMT;
+ (NSDateFormatter *)DATETIME_SIGN_FMT;
+ (NSDateFormatter *)TIME_BROADCAST_FMT;
+ (NSDateFormatter *)DATETIME_FMT_NO_EAST8;
+ (NSDateFormatter *)DATE_FMT;
+ (NSDateFormatter *)TIME_FMT;
+ (void)SET_SERVER_DATETIME:(NSDate *)date;
+ (NSDate *)SERVER_DATETIME;
+ (NSDecimalNumberHandler *)DEC_FLOOR_HANDLER;
+ (NSDecimalNumberHandler *)DEF_ROUND_HANDLER;
+ (NSNumberFormatter *)DEF_DECIMAL_FORMATTER;
+ (UIView *)EMPTY_INPUT_VIEW;
+ (NSNumberFormatter *)PRICE_FORMATTER;
+ (TTExpressionKeyboard *)EXPRESSION_KEYBOARD;
+ (void)REMOVE_EXPRESSION_KEYBOARD;
//+ (ShortcutView *)SHORTCUTVIEW;
//+ (void)REMOVE_SHORTCUTVIEW;
+ (NSArray *)EXPRESSIONS;
+ (NSArray *)IAP_PRODUCTS;
+ (void)SET_IAP_PRODUCTS:(NSArray *)products;

@end
