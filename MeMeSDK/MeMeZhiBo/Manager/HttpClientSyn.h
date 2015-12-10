//
//  HttpClientSyn.h
//  TTShow
//
//  Created by twb on 13-6-23.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableURLRequest (TTShow)

+ (NSMutableURLRequest *)GETRequestForURL:(NSString *)url;
+ (NSMutableURLRequest *)POSTRequestForURL:(NSString *)url;
+ (NSMutableURLRequest *)POSTRequestForURL:(NSString *)url withJSONData:(NSData *)data;
+ (NSMutableURLRequest *)POSTRequestForURL:(NSString *)url withImageData:(NSData *)data;

@end

@interface HttpClientSyn : NSObject<NSURLConnectionDataDelegate>

@property (nonatomic, assign) NSInteger lastStatusCode;

- (id)init;
- (NSData *)sendRequest:(NSURLRequest *)request;
- (id)sendRequestForJSONResponse:(NSURLRequest *)request;
- (NSData *)getFromURL:(NSString *)url;
- (NSData *)postData:(NSData *)data toURL:(NSString *)url;
- (NSError *)lastError;

@end
