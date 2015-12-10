//
//  CommonParameter.h
//  TTShow
//
//  Created by twb on 13-9-22.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonParameter : NSObject

@property (nonatomic, readonly, strong) NSString *uid;
@property (nonatomic, readonly, strong) NSString *app;
@property (nonatomic, readonly, strong) NSString *hid;
//@property (nonatomic, readonly, strong) NSString *openid;
@property (nonatomic, readonly, strong) NSString *v;
@property (nonatomic, readonly, strong) NSString *f;
@property (nonatomic, readonly, strong) NSString *s;
@property (nonatomic, readonly, strong) NSString *imsi;
@property (nonatomic, assign) NSInteger net;
@property (nonatomic, readonly, strong) NSString *mid;
@property (nonatomic, readonly, strong) NSString *splus;
@property (nonatomic, assign) NSInteger active;
@property (nonatomic, assign) NSInteger tid;

// Opeartion Type.
@property (nonatomic, strong) NSDictionary *openDictionary;

// singleton for global shared functions.
+ (instancetype)sharedInstance;

@end
