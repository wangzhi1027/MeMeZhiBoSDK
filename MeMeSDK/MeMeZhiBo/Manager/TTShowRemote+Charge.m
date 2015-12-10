//
//  TTShowRemote+Charge.m
//  TTShow
//
//  Created by twb on 13-10-10.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import "TTShowRemote+Charge.h"
#import "MMAFAppDotNetAPIClient.h"
#import "MMAFHTTPRequestOperation.h"
#import "TTShowUser.h"
#import "TTShowWapPay.h"
#import "ProductModel.h"
#import "TalkingDataAppCpa.h"
#import "qudaoModel.h"


#define kProductUrl @"http://api.memeyule.com/properties/ios_list"

#define kTestProductUrl @"http://test.api.memeyule.com/properties/ios_list"



#define kIsJailBreakTest @"http://test.api.memeyule.com/properties/ios_list"

#define kIsJailBreak @"http://api.memeyule.com/properties/ios_list"

#if 1
#define kRetrieveProductUrl @"http://www.2339.com/app/apple_product.json"
#else
#define kRetrieveProductUrl @"http://test.api.2339.com/app/apple_product"
#endif

@implementation TTShowRemote (Charge)

-(void)retrieveProducts:(RemoteCompletionArray)completition
{
    [[MMAFAppDotNetAPIClient sharedClient] getPath:self.dataManager.filter.testModeOn?kTestProductUrl:kProductUrl parameters:nil success:^(MMAFHTTPRequestOperation *operation, id responseObject) {
        
        if (responseObject == nil)
        {
            completition(nil, [NSError errorMsg:@"服务器返回产品列表为空."]);
            return;
        }
        NSDictionary *dic = [self parseJson:responseObject];
        if ([dic isRightKind])
        {
            if (![dic statusCodeOK])
            {
                completition(nil, [NSError errorMsg:@"服务器返回产品列表失败."]);
                return;
            }
            
            
            NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
            NSDictionary *products1 = [dic valueForKey:@"data"];
            
            
            for (NSDictionary *dict in products1) {
                if ([[dict objectForKey:@"_id"] isEqual:@"price_list"]) {
                    NSData* jsonData = [[dict objectForKey:@"content"] dataUsingEncoding:NSUTF8StringEncoding];

                    NSError *error;
                    NSDictionary *arr1 = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
                    for (NSDictionary *attributes in arr1)
                    {
                        ProductModel *productList = [[ProductModel alloc] initWithAttributes:attributes];
                        [arr addObject:productList];
                    }
                }
            }
            completition(arr, nil);
        }
        else
        {
            completition(nil, [NSError errorMsg:@"服务器返回数据类型错误."]);
        }
    } failure:^(MMAFHTTPRequestOperation *operation, NSError *error) {
        if (completition)
        {
            completition(nil, error);
        }
    }];
}

-(void)retrieveIsJailBreak:(RemoteCompletionBool)completition
{
    [[MMAFAppDotNetAPIClient sharedClient] getPath:self.dataManager.filter.testModeOn?kIsJailBreakTest:kIsJailBreak parameters:nil success:^(MMAFHTTPRequestOperation *operation, id responseObject) {
        
        if (responseObject == nil)
        {
            completition(NO, [NSError errorMsg:@"服务器返回产品列表为空."]);
            return;
        }
        NSDictionary *dic = [self parseJson:responseObject];
        
        if ([dic isRightKind])
        {
            if (![dic statusCodeOK])
            {
                completition(NO, [NSError errorMsg:@"服务器返回产品列表失败."]);
                return;
            }
            
//            NSMutableArray *arr1 = [NSMutableArray arrayWithCapacity:0];
            
            NSArray *products1 = [dic valueForKey:@"data"];
            
            
            for (NSDictionary *attributes in products1)
            {
                if ([[attributes objectForKey:@"_id"] isEqual:@"pay_plugs_meme"]) {
                    completition([[attributes objectForKey:@"content"] boolValue], nil);
                }
            }
        }
        else
        {
            completition(NO, [NSError errorMsg:@"服务器返回数据类型错误."]);
        }
    } failure:^(MMAFHTTPRequestOperation *operation, NSError *error) {
        if (completition)
        {
            completition(NO, error);
        }
    }];
}


- (NSArray *)_retrieveSyncProducts
{
    HttpClientSyn *http = [[HttpClientSyn alloc] init];
    NSDictionary *jsonData = [http sendRequestForJSONResponse:[NSMutableURLRequest GETRequestForURL:kRetrieveProductUrl]];
    
//    LOGINFO(@"jsonData = %@", jsonData);
    
    if (jsonData == nil)
    {
        return nil;
    }
    
    if ([jsonData isRightKind])
    {
        if (![jsonData statusCodeOK])
        {
            return nil;
        }
        
        return [jsonData valueForKey:@"data"];
    }
    
    return nil;
}

- (void)_retrieveAsyncProductsWithCompletition:(RemoteCompletionArray)completition
{
    [[MMAFAppDotNetAPIClient sharedClient] getPath:kRetrieveProductUrl parameters:nil success:^(MMAFHTTPRequestOperation *operation, id responseObject) {
        
        if (responseObject == nil)
        {
            completition(nil, [NSError errorMsg:@"服务器返回产品列表为空."]);
            return;
        }
        
        if ([responseObject isRightKind])
        {
            if (![responseObject statusCodeOK])
            {
                completition(nil, [NSError errorMsg:@"服务器返回产品列表失败."]);
                return;
            }
            
            NSArray *products = [responseObject valueForKey:@"data"];
            completition(products, nil);
        }
        else
        {
            completition(nil, [NSError errorMsg:@"服务器返回数据类型错误."]);
        }
    } failure:^(MMAFHTTPRequestOperation *operation, NSError *error) {
        if (completition)
        {
            completition(nil, error);
        }
    }];
}

- (BOOL)_chargeFromAppStore:(NSData *)data isSandbox:(NSInteger)flag
{
    //    charge_from_app_store_index
    NSString *access_token = [TTShowUser access_token];
    if ([TTShowUser access_token] == nil)
    {
        return NO;
    }
    
    NSString *param = [NSString stringWithFormat:urlArray[charge_from_app_store_index], access_token,flag];
    NSString *urlString = [self.baseURLStr stringByAppendingString:param];
    
    
    HttpClientSyn *http = [[HttpClientSyn alloc] init];
    NSMutableURLRequest *request = [NSMutableURLRequest POSTRequestForURL:urlString withJSONData:data];
    NSDictionary *result = [http sendRequestForJSONResponse:request];
    //  NSLog(@"%@",result);
    
    if ([result isRightKind])
    {
        if (![result statusCodeOK])
        {
            return NO;
        }
        
        TTShowUser *user = [TTShowUser unarchiveUser];
        [TalkingDataAppCpa onOrderPaySucc:user.user_name withOrderId:@"1" withAmount:(int)user._id withCurrencyType:@"CNY" withPayType:@"IAP"];
        return YES;
    }
    return NO;
}


// (wap?_id=userid&amount=金额)
- (void)_getWapPayURLByMethod:(WapPayMethod)method amount:(NSInteger)amount completion:(RemoteCompletionWapPay)completion
{
    if ([TTShowUser access_token] == nil)
    {
        completion(nil, nil);
    }
    
    RemoteType remoteType;
    switch (method)
    {
        default:
        case kTenWapPay:
            remoteType = get_tenpay_wap_url_index;
            break;
        case kAliWapPay:
            remoteType = get_alipay_wap_url_index;
            break;
    }
    
    NSString *parameterString = [NSString stringWithFormat:urlArray[remoteType], [TTShowUser unarchiveUser]._id, amount];
    NSString *urlString = [self.baseURLStr stringByAppendingString:parameterString];
    
    [[MMAFAppDotNetAPIClient sharedClient] getPath:urlString parameters:nil success:^(MMAFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *jsonData = [self parseJson:responseObject];
        if ([jsonData isRightKind])
        {
            if (![jsonData statusCodeOK])
            {
                completion(nil, [NSError errorMsg:[DataGlobalKit messageWithStatus:[jsonData statusCode]] code:[jsonData statusCode]]);
                return;
            }
            
            switch (method)
            {
                default:
                case kTenWapPay:
                {
                    NSString *wapPayURLString = [[jsonData valueForKey:@"data"] valueForKey:@"wapPayRequestUrl"];
                    NSString *callbackURL = [[jsonData valueForKey:@"data"] valueForKey:@"callback_url"];
                    NSString *notifyURL = [[jsonData valueForKey:@"data"] valueForKey:@"notify_url"];
                    
                    NSDictionary *paramDict = @{@"requestURL": wapPayURLString,
                                                @"callbackURL" : callbackURL,
                                                @"notifyURL" : notifyURL,
                                                @"partner" : @"",
                                                @"service" : @""
                                                };
                    TTShowWapPay *wapPay = [[TTShowWapPay alloc] initWithAttributes:paramDict];
                    completion(wapPay, nil);
                }
                    break;
                case kAliWapPay:
                {
                    /*
                     @property (nonatomic, strong) NSString *partner;
                     @property (nonatomic, strong) NSString *service;
                     @property (nonatomic, strong) NSString *format;
                     @property (nonatomic, strong) NSString *req_data;
                     @property (nonatomic, strong) NSString *sec_id;
                     @property (nonatomic, strong) NSString *v;
                     @property (nonatomic, strong) NSString *sign;
                     */
                    
                    NSString *requestURL = [[jsonData valueForKey:@"data"] valueForKey:@"action"];
                    NSString *callbackURL = [[jsonData valueForKey:@"data"] valueForKey:@"call_back_url"];
                    NSString *notifyURL = [[jsonData valueForKey:@"data"] valueForKey:@"call_back_url"];
                    NSString *partner = [[jsonData valueForKey:@"data"] valueForKey:@"partner"];
                    NSString *service = [[jsonData valueForKey:@"data"] valueForKey:@"service"];
                    NSString *format = [[jsonData valueForKey:@"data"] valueForKey:@"format"];
                    NSString *req_data = [[jsonData valueForKey:@"data"] valueForKey:@"req_data"];
                    NSString *sec_id = [[jsonData valueForKey:@"data"] valueForKey:@"sec_id"];
                    NSString *v = [[jsonData valueForKey:@"data"] valueForKey:@"v"];
                    NSString *sign = [[jsonData valueForKey:@"data"] valueForKey:@"sign"];
                    
                    if (callbackURL == nil)
                    {
                        callbackURL = @"http://m.show.dongting.com/";
                    }
                    
                    NSMutableDictionary *paramDictionary = [[NSMutableDictionary alloc] initWithCapacity:0];
                    [paramDictionary setObject:kNotNilString(requestURL) forKey:@"requestURL"];
                    [paramDictionary setObject:kNotNilString(callbackURL) forKey:@"callbackURL"];
                    [paramDictionary setObject:kNotNilString(notifyURL) forKey:@"notifyURL"];
                    [paramDictionary setObject:kNotNilString(partner) forKey:@"partner"];
                    [paramDictionary setObject:kNotNilString(service) forKey:@"service"];
                    [paramDictionary setObject:kNotNilString(format) forKey:@"format"];
                    [paramDictionary setObject:kNotNilString(req_data) forKey:@"req_data"];
                    [paramDictionary setObject:kNotNilString(sec_id) forKey:@"sec_id"];
                    [paramDictionary setObject:kNotNilString(v) forKey:@"v"];
                    [paramDictionary setObject:kNotNilString(sign) forKey:@"sign"];
                    
                    TTShowWapPay *wapPay = [[TTShowWapPay alloc] initWithAttributes:paramDictionary];
                    completion(wapPay, nil);
                }
                    break;
            }
        }
        else
        {
            completion(nil, [NSError errorMsg:@"jsonData is wrong kind."]);
        }
        
    } failure:^(MMAFHTTPRequestOperation *operation, NSError *error) {
        completion(nil, nil);
    }];
}

@end
