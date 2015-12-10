//
//  UpYun.m
//  UpYunSDK2.0
//
//  Created by jack zhou on 13-8-6.
//  Copyright (c) 2013年 upyun. All rights reserved.
//

#import "UpYun.h"
#define ERROR_DOMAIN @"upyun.com"
#define DATE_STRING(expiresIn) [NSString stringWithFormat:@"%.0f",[[NSDate date] timeIntervalSince1970] + expiresIn]
#define REQUEST_URL(bucket) [NSURL URLWithString:[NSString stringWithFormat:@"%@%@/",API_DOMAIN,bucket]]

#define SUB_SAVE_KEY_FILENAME @"{filename}"

@implementation UpYun
-(id)init
{
    if (self = [super init]) {
        self.expiresIn = DEFAULT_EXPIRES_IN;
        self.passcode = DEFAULT_PASSCODE;
	}
	return self;
}

- (void) uploadImage:(UIImage *)image bucket:(NSString *)bucket policy:(NSString *)policy signature:(NSString *)signature
{
    NSData *imageData = UIImagePNGRepresentation(image);
    [self uploadImageData:imageData bucket:bucket policy:policy signature:signature];
}

- (void) uploadImagePath:(NSString *)path bucket:(NSString *)bucket policy:(NSString *)policy signature:(NSString *)signature
{
    [self uploadFilePath:path bucket:bucket policy:policy signature:signature];
}

- (void) uploadImageData:(NSData *)data bucket:(NSString *)bucket policy:(NSString *)policy signature:(NSString *)signature
{
    [self uploadFileData:data bucket:bucket policy:policy signature:signature];
}

- (void) uploadFilePath:(NSString *)path bucket:(NSString *)bucket policy:(NSString *)policy signature:(NSString *)signature
{
    MMAFHTTPRequestOperation * operation = [self creatOperationWithBucket:bucket policy:policy signature:signature data:nil filePath:path];
    [operation start];
}

- (void) uploadFileData:(NSData *)data bucket:(NSString *)bucket policy:(NSString *)policy signature:(NSString *)signature
{
    MMAFHTTPRequestOperation * operation = [self creatOperationWithBucket:bucket policy:policy signature:signature data:data filePath:nil];
    [operation start];
}


- (void)uploadFile:(id)file bucket:(NSString *)bucket policy:(NSString *)policy signature:(NSString *)signature
{
    if (![file isKindOfClass:[NSString class]])//非path传入的需要检查savekey
    {
        return;
    }
    if([file isKindOfClass:[UIImage class]]){
        [self uploadImage:file bucket:bucket policy:policy signature:signature];
    }else if([file isKindOfClass:[NSData class]]) {
        [self uploadFileData:file bucket:bucket policy:policy signature:signature];
    }else if([file isKindOfClass:[NSString class]]) {
        [self uploadFilePath:file bucket:bucket policy:policy signature:signature];
    }else {
        NSError *err = [NSError errorWithDomain:ERROR_DOMAIN
                                           code:-1999
                                       userInfo:@{@"message":@"传入参数类型错误"}];
        if (_failBlocker) {
            _failBlocker(err);
        }
    }
}

- (id <AFMultipartFormData>)setData:(id <AFMultipartFormData>)formData
                               data:(NSData *)data
                           filePath:(NSString *)filePath
{
    if (data) {
        [formData appendPartWithFileData:data
                                    name:@"file"
                                fileName:[NSString stringWithFormat:@"file%@",[data detectImageSuffix]]
                                mimeType:@"multipart/form-data"];
        return formData;
    }
    if (filePath) {
        NSURL * url = [NSURL fileURLWithPath:filePath];
        NSString * fileName = [filePath lastPathComponent];
        fileName = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                         (CFStringRef)fileName,
                                                                                         NULL,
                                                                                         (CFStringRef)@"!*'();:@&=+$,?%#[]",
                                                                                         kCFStringEncodingUTF8));
        NSError * error = [[NSError alloc]init];
        [formData appendPartWithFileURL:url
                                   name:@"file"
                               fileName:fileName
                               mimeType:@"multipart/form-data"
                                  error:&error];
        
        return formData;
    }
    return nil;
}

- (MMAFHTTPRequestOperation *)creatOperationWithBucket:(NSString *)bucket
                                              policy:(NSString *)policy
                                           signature:(NSString *)signature
                                                data:(NSData *)data
                                            filePath:(NSString *)filePath{
    //进度回调
    void(^progress)(NSUInteger bytesWritten,long long totalBytesWritten,long long totalBytesExpectedToWrite) = ^(NSUInteger bytesWritten,long long totalBytesWritten,long long totalBytesExpectedToWrite){
        CGFloat percent = totalBytesWritten/(float)totalBytesExpectedToWrite;
        if (_progressBlocker) {
            _progressBlocker(percent,totalBytesWritten);
        }
    };
    //成功回调
    void(^success)(MMAFHTTPRequestOperation *operation, id responseObject)= ^(MMAFHTTPRequestOperation *operation, id responseObject){
        NSLog(@"upyun upload success");
        NSDictionary * jsonDic = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingAllowFragments error:NULL];
        NSString *msg = [jsonDic objectForKey:@"message"];
        if ([@"ok" isEqualToString:msg]) {
            NSString *url = [jsonDic objectForKey:@"url"];
            NSString *urlHost = [NSString stringWithFormat:URL_DOMAIN, bucket];
            NSString *fullUrl = [urlHost stringByAppendingString:url];
            NSLog(@"upyun upload success %@", fullUrl);
            if (_successBlocker) {
                _successBlocker(fullUrl);
            }
        } else {
            NSError *err = [NSError errorWithDomain:ERROR_DOMAIN
                                               code:[[jsonDic objectForKey:@"code"] intValue]
                                           userInfo:jsonDic];
            if (_failBlocker) {
                _failBlocker(err);
            }
        }
    };
    //失败回调
    void(^fail)(MMAFHTTPRequestOperation * opetation,NSError * error)= ^(MMAFHTTPRequestOperation * opetation,NSError * error){
        NSLog(@"upyun upload failed %@", error);
        if (_failBlocker) {
            _failBlocker(error);
        }
    };
    
    NSDictionary * parameDic = @{@"policy":policy, @"signature":signature};
    
    __block UpYun * blockSelf = self;
//    AFHTTPRequestOperationManager *httpManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:REQUEST_URL(bucket)];
//    httpManager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    AFHTTPRequestOperation *operation = [httpManager POST:@"" parameters:parameDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//        [blockSelf setData:formData data:data filePath:filePath];
//        
//    } success:success failure:fail];
    NSMutableURLRequest *request = [[MMAFAppDotNetAPIClient sharedClient] multipartFormRequestWithMethod:@"POST" path:[NSString stringWithFormat:@"%@%@/",API_DOMAIN,bucket] parameters:parameDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [blockSelf setData:formData data:data filePath:filePath];
    }];
    MMAFHTTPRequestOperation *operation = [[MMAFAppDotNetAPIClient sharedClient] HTTPRequestOperationWithRequest:request success:success failure:fail];
    
    //[operation setUploadProgressBlock:progress];
    
    return operation;
}
/*- (NSURLSessionTask *)aacreatOperationWithSaveKey:(NSString *)saveKey
                                                 data:(NSData *)data
                                             filePath:(NSString *)filePath{
    //进度回调
    void(^progress)(NSUInteger bytesWritten,NSInteger totalBytesWritten,NSInteger totalBytesExpectedToWrite) = ^(NSUInteger bytesWritten,NSInteger totalBytesWritten,NSInteger totalBytesExpectedToWrite){
        CGFloat percent = totalBytesWritten/(float)totalBytesExpectedToWrite;
        if (_progressBlocker) {
            _progressBlocker(percent,totalBytesWritten);
        }
    };
    //成功回调
    void(^success)(NSURLSessionDataTask *operation, id responseObject)= ^(NSURLSessionDataTask *operation, id responseObject){
        NSDictionary * jsonDic = responseObject;
        NSString *message = [jsonDic objectForKey:@"message"];
        if ([@"ok" isEqualToString:message]) {
            if (_successBlocker) {
                _successBlocker(jsonDic);
            }
        } else {
            NSError *err = [NSError errorWithDomain:ERROR_DOMAIN
                                               code:[[jsonDic objectForKey:@"code"] intValue]
                                           userInfo:jsonDic];
            if (_failBlocker) {
                _failBlocker(err);
            }
        }
    };
    //失败回调
    void(^fail)(NSURLSessionDataTask * opetation,NSError * error)= ^(NSURLSessionDataTask * opetation,NSError * error){
        if (_failBlocker) {
            _failBlocker(error);
        }
    };
    
    NSString *policy = [self getPolicyWithSaveKey:saveKey];
    NSString *signature = [self getSignatureWithPolicy:policy];
    NSDictionary * parameDic = @{@"policy":policy, @"signature":signature};
    
    __block UpYun * blockSelf = self;
    AFHTTPSessionManager *httpManager = [[AFHTTPSessionManager alloc] initWithBaseURL:REQUEST_URL(self.bucket)];
    httpManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSURLSessionTask *task = [httpManager POST:@"" parameters:parameDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [blockSelf setData:formData data:data filePath:filePath];
    } success:success failure:fail];
    
    return task;
}*/

@end
