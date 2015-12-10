//
//  TTShowRemote+Car.m
//  memezhibo
//
//  Created by Xingai on 15/5/21.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "TTShowRemote+Car.h"
#import "TTShowCar.h"

@implementation TTShowRemote (Car)

- (void)retrieveCarList:(RemoteCompletionDoubleArray)completion
{
    NSString *urlString = [self.baseURLStr stringByAppendingString:urlArray[retrieve_car_list_index]];
    
    [[MMAFAppDotNetAPIClient sharedClient] getPath:urlString parameters:nil success:^(MMAFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *jsonData = [self parseJson:responseObject];
        
        NSMutableArray *carList1 = [NSMutableArray arrayWithCapacity:0];
        NSMutableArray *carList2 = [NSMutableArray arrayWithCapacity:0];
        
        if ([jsonData isRightKind])
        {
            if (![jsonData statusCodeOK])
            {
                completion(nil,nil, [NSError errorMsg:[jsonData message]]);
                return;
            }
            
            // ...
            NSArray *cars = [jsonData valueForKey:@"data"];
            
            NSArray *nosala = [jsonData valueForKey:@"no_sale"];
            
//            LOGINFO(@"cars = %@  nosala = %@",cars,nosala);
            
            for (NSDictionary *carDict in cars)
            {
                TTShowCar *car = [[TTShowCar alloc] initWithAttributes:carDict];
                [carList1 addObject:car];
                [carList2 addObject:car];
            }
            
            for (NSDictionary *nosalaCarDict in nosala)
            {
                TTShowCar *car = [[TTShowCar alloc] initWithAttributes:nosalaCarDict];
                [carList1 addObject:car];
            }
            
            
            if (completion)
            {
                completion(carList1, carList2,nil);
            }
        }
    } failure:^(MMAFHTTPRequestOperation *operation, NSError *error) {
        if (completion)
        {
            completion(nil,nil, error);
        }
    }];
}

// Car Information.
- (void)retrieveMyCarList:(void (^)(TTShowMyCar *myCar, NSError *error))block
{
    NSString *access_token = [TTShowUser access_token];
    if ([TTShowUser access_token] == nil)
    {
        block(nil, [NSError errorMsg:@"token 为空"]);
        return;
    }
    
    NSString *param = [NSString stringWithFormat:urlArray[retrieve_mycar_list_index], access_token];
    NSString *urlString = [self.baseURLStr stringByAppendingString:param];
    
    [[MMAFAppDotNetAPIClient sharedClient] getPath:urlString parameters:nil success:^(MMAFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *jsonData = [self parseJson:responseObject];
        
        if ([jsonData isRightKind])
        {
            NSDictionary *myCarDict = [jsonData valueForKey:@"data"];
            
            TTShowMyCar *myCar = [[TTShowMyCar alloc] initWithAttributes:myCarDict];
            
            block(myCar, nil);
        }
        
    } failure:^(MMAFHTTPRequestOperation *operation, NSError *error) {
        block(nil, error);
    }];
}

- (void)setMyDefaultCar:(NSInteger)carID completion:(RemoteCompletionBool)completion
{
    NSString *access_token = [TTShowUser access_token];
    if ([TTShowUser access_token] == nil)
    {
        completion(NO, [NSError errorMsg:@"token 为空"]);
        return;
    }
    
    NSString *param = [NSString stringWithFormat:urlArray[set_my_default_car_index], access_token, carID];
    NSString *urlString = [self.baseURLStr stringByAppendingString:param];
    
    [[MMAFAppDotNetAPIClient sharedClient] getPath:urlString parameters:nil success:^(MMAFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *jsonData = [self parseJson:responseObject];
        
        if ([jsonData isRightKind])
        {
            if (![jsonData statusCodeOK])
            {
                completion(NO, [NSError errorMsg:[jsonData message]]);
                return;
            }
            completion(YES, nil);
        }
        
    } failure:^(MMAFHTTPRequestOperation *operation, NSError *error) {
        completion(NO, error);
    }];
}

- (void)cancelMyDefaultCar:(RemoteCompletionBool)completion
{
    NSString *access_token = [TTShowUser access_token];
    if ([TTShowUser access_token] == nil)
    {
        completion(NO, [NSError errorMsg:@"token 为空"]);
        return;
    }
    
    NSString *param = [NSString stringWithFormat:urlArray[cancel_my_default_car_index], access_token];
    NSString *urlString = [self.baseURLStr stringByAppendingString:param];
    
    [[MMAFAppDotNetAPIClient sharedClient] getPath:urlString parameters:nil success:^(MMAFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *jsonData = [self parseJson:responseObject];
        
        if ([jsonData isRightKind])
        {
            if (![jsonData statusCodeOK])
            {
                completion(NO, [NSError errorMsg:[jsonData message]]);
                return;
            }
            completion(YES, nil);
        }
        
    } failure:^(MMAFHTTPRequestOperation *operation, NSError *error) {
        completion(NO, error);
    }];
}

// Buy Car.
- (void)buyCar:(NSInteger)carID completion:(RemoteCompletionBool)completion
{
    NSString *access_token = [TTShowUser access_token];
    if ([TTShowUser access_token] == nil)
    {
        completion(NO, [NSError errorMsg:@"token 为空"]);
        return;
    }
    
    NSString *param = [NSString stringWithFormat:urlArray[buy_car_index], access_token, carID];
    NSString *urlString = [self.baseURLStr stringByAppendingString:param];
    [[MMAFAppDotNetAPIClient sharedClient] getPath:urlString parameters:nil success:^(MMAFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *jsonData = [self parseJson:responseObject];
        if ([jsonData isRightKind])
        {
            if (![jsonData statusCodeOK])
            {
                if (completion)
                {
                    NSString *msg = [DataGlobalKit messageWithStatus:[jsonData statusCode]];
                    if (msg == nil)
                    {
                        msg = [jsonData message];
                    }
                    completion(NO, [NSError errorMsg:msg code:[jsonData statusCode]]);
                }
                return;
            }
            
            completion(YES, nil);
        }
    } failure:^(MMAFHTTPRequestOperation *operation, NSError *error) {
        completion(NO, [NSError errorMsg:@"未知错误"]);
    }];
}


@end
