//
//  TTAlixpay.h
//  TTShow
//
//  Created by twb on 13-11-19.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, TTAlixpayCode)
{
    kSPErrorOK = 0,
    kSPErrorAlipayClientNotInstalled,
    kSPErrorSignError
};

typedef NS_ENUM(NSInteger, TTAlixpayStatusCode)
{
    kAlixpayException = 4000,
    kAlixpayFormatError = 40001,
    // Other code ...
    // ...
    // ============
    // Common status code.
    kAlixpayFail = 4006,
    kAlixpaySuccess = 9000
};

@interface TTAlixpayResult : NSObject

@property(nonatomic, assign) NSInteger statusCode;
@property(nonatomic, strong) NSString *statusMessage;
@property(nonatomic, strong) NSString *resultString;
@property(nonatomic, strong) NSString *signString;
@property(nonatomic, strong) NSString *signType;

- (id)initWithResultString:(NSString *)string;

@end

@interface TTAlixpayOrder : NSObject

@property(nonatomic, strong) NSString * partner;
@property(nonatomic, strong) NSString * seller;
@property(nonatomic, strong) NSString * tradeNO;
@property(nonatomic, strong) NSString * productName;
@property(nonatomic, strong) NSString * productDescription;
@property(nonatomic, strong) NSString * amount;
@property(nonatomic, strong) NSString * notifyURL;
@property(nonatomic, strong) NSMutableDictionary * extraParams;

@end

@interface TTAlixpay : NSObject

// Singleton for global shared functions.
+ (instancetype)sharedInstance;

- (NSInteger)pay:(NSString *)orderString applicationScheme:(NSString *)scheme;
- (TTAlixpayResult *)handleOpenURL:(NSURL *)url;

@end
