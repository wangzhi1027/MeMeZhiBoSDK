//
//  HttpUtils.m
//  TTShow
//
//  Created by xh on 15/4/3.
//  Copyright (c) 2015年 twb. All rights reserved.
//

#import "HttpUtils.h"
#import "MMAFAppDotNetAPIClient.h"

@implementation HttpUtils

+ (void)executeGetMethodWithUrl:(NSString *)url params:(NSDictionary *)params successBlock:(SuccessBlock)successBlock failBlock:(FailBlock)failBlock
{
    
    [[MMAFAppDotNetAPIClient sharedClient] getPath:url parameters:params success:^(MMAFHTTPRequestOperation *operation, id responseObject) {
        
        NSError *error;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
        
        
        if ([dict isRightKind]) {
            if ([dict statusCodeOK]) {
                if (successBlock) {
                    successBlock(dict);
                }
            } else {
                NSInteger code = [dict statusCode];
                if (failBlock) {
                    failBlock([NSError errorMsg:[DataGlobalKit messageWithStatus:code]
                                           code:code]);
                }
            }
        } else {
            if (failBlock) {
                failBlock([NSError errorDataFormat]);
            }
        }
    } failure:^(MMAFHTTPRequestOperation *operation, NSError *error) {
        if (failBlock) {
            failBlock(error);
        }
    }];

}
@end
