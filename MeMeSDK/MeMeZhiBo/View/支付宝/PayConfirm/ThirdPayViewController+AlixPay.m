//
//  ThirdPayViewController+AlixPay.m
//  TTShow
//
//  Created by twb on 13-11-25.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import "ThirdPayViewController+AlixPay.h"
#import "DataSigner.h"
#import "TTShowProduct.h"
#import "TTShowUser.h"

@implementation ThirdPayViewController (AlixPay)

- (void)buyProductWithAlixpay:(TTShowProduct *)product
{
    NSString *partner = kInfoObjectForKey(@"Partner");
    NSString *seller = kInfoObjectForKey(@"Seller");
    
    if ([partner length] == 0 || [seller length] == 0)
	{
        [UIAlertView showInfoMessage:@"缺少partner或者seller."];
		return;
	}
    
    TTAlixpayOrder *order = [[TTAlixpayOrder alloc] init];
	order.partner = partner;
	order.seller = seller;
	order.tradeNO = [self productTradeNO:product];
	order.productName = [self productName:product];
	order.productDescription = [self productDescription:product];
	order.amount = [self productPrice:product];
	order.notifyURL = [self notifyURL]; // callback url.
    
	// debug commodity information.
	NSString *orderSpec = [order description];
	NSLog(@"orderSpec = %@",orderSpec);
    
    // sign parameters execept for 'sign and sign_type' parameter.
	id<DataSigner> signer = CreateRSADataSigner(kInfoObjectForKey(@"RSA private key"));
	NSString *signedString = [signer signString:orderSpec];
	
	// combine order url with strings which has signed.
	NSString *orderString = nil;
	if (signedString != nil)
    {
		orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        
        // call alixpay interface.
        NSInteger ret = [self.dataManager.alixpay pay:orderString applicationScheme:kAppScheme];
        
        if (ret == kSPErrorAlipayClientNotInstalled)
        {
            [UIAlertView showInfoMessage:@"您还没有安装支付宝快捷支付,请先安装."];
        }
        else if (ret == kSPErrorSignError)
        {
        }
	}
}

- (NSString *)productTradeNO:(TTShowProduct *)product
{
    // trade NO is combine with current date ,user id and product id, 20131121_230012
//    [[NSDate date] timeIntervalSinceNow]
//    NSString *curDateString = [[GlobalStatics DATE_FMT] stringFromDate:[NSDate date]];
    NSTimeInterval dateFromNowInterval = [[NSDate date] timeIntervalSince1970];
    NSUInteger userid = [TTShowUser unarchiveUser]._id;
    
    NSString *tradeNO = [NSString stringWithFormat:@"%lu_%.0f", (unsigned long)userid, dateFromNowInterval];
    return tradeNO;
}

- (NSString *)productName:(TTShowProduct *)product
{
    return product.title;
}

- (NSString *)productDescription:(TTShowProduct *)product
{
    return product.detail;
}

- (NSString *)productPrice:(TTShowProduct *)product
{
    // just for testing...
#if 0
    return @"0.01";
#else
    return product.price;
#endif
}

- (NSString *)notifyURL
{
    return self.dataManager.filter.testModeOn ? @"http://test.api.2339.com/pay/ali_mobile_notify" : @"http://api.2339.com/pay/ali_mobile_notify";
}

@end
