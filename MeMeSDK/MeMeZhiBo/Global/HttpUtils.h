//
//  HttpUtils.h
//  TTShow
//
//  Created by xh on 15/4/3.
//  Copyright (c) 2015年 twb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpUtils : NSObject
typedef void (^SuccessBlock)(NSDictionary *dict);
typedef void (^FailBlock)(NSError *error);

+ (void)executeGetMethodWithUrl:(NSString *)url params:(NSDictionary *)params successBlock:(SuccessBlock)successBlock failBlock:(FailBlock)failBlock;

@end
