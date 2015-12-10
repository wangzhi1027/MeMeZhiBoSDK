//
//  DataGlobalKit.h
//  TTShow
//
//  Created by twb on 13-11-15.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GlobalKit.h"

#define kCommonerChangeRoomDisplayCondition (50)

@interface DataGlobalKit : GlobalKit

@property (nonatomic, readonly) BOOL login;
//@property (nonatomic) NSString* phonenumber;

// Singleton for global shared functions.
+ (instancetype)sharedInstance;

// User is Login?
- (BOOL)isUserlogin;
- (void)logout;
//-(NSString*)getPhonenumber;


// Global TTShow Expressions.
+ (NSArray *)TTShowExpressions;

// China Location.
+ (NSDictionary *)locations;
+ (NSArray *)statures;
+ (NSArray *)staturesWomen;
+ (NSArray *)constellations;
+ (NSArray *)sexes;

// get grade image string
- (NSString *)anchorImageString:(NSInteger)grade;
- (NSString *)wealthImageString:(NSInteger)grade;

// get grade image
- (UIImage *)anchorImage:(NSInteger)grade;
- (UIImage *)wealthImage:(NSInteger)grade;

// Convert Server Time Stamp, Give off Micro Second.
+ (long long int)filterTimeStamp:(NSString *)s;
+ (long long int)filterTimeStampWithInteger:(long long int)s;

//
+ (long long int)shamVistorCount:(long long int)count;
+ (long long int)shamVistorCountInMainPage:(long long int)count;
+ (NSInteger)getRandomNumber:(NSInteger)from to:(NSInteger)to;

+ (BOOL)checkHostIsRegular;
//+ (BOOL)checkInternetIsRegular;
+ (BOOL)checkWifiIsRegular;
//+ (BOOL)networkOK;

+ (NSArray *)userManageStatus;
+ (NSString *)messageWithStatus:(NSInteger)code;
// Common Code.
- (BOOL)balanceNotEnoughWithCode:(NSInteger)code;
- (BOOL)authorityNotEnoughWithCode:(NSInteger)code;
- (BOOL)needMailAuth:(NSInteger)code;
- (BOOL)needPhoneAuth:(NSInteger)code;

- (NSInteger)vipRemainDays:(long long int)expires;

// caculate day between now and some date.
- (NSInteger)daysBetweenNowAndDate:(NSDate *)date;
- (NSInteger)remainHoursBetweenNowAndDate:(NSDate *)date;
- (NSDateComponents *)componentsBetweenNowAndDate:(NSDate *)date;
- (NSDateComponents *)componentsBetweenNowAndDate:(NSDate *)date flags:(unsigned int)flags;

// Vip Image String by Member Type.
- (NSString *)vipImageString:(MemberType)type;

- (CGFloat)getLabelLength:(NSString *)text fontSize:(CGFloat)fontSize;
- (CGFloat)getLabelHeight:(NSString *)text width:(CGFloat)width fontSize:(CGFloat)fontSize;

@end
