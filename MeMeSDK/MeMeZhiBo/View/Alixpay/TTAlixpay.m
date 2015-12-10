//
//  TTAlixpay.m
//  TTShow
//
//  Created by twb on 13-11-19.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import "TTAlixpay.h"
#import "JSON.h"

#define ALIPAY_SAFEPAY     @"SafePay"
#define ALIPAY_DATASTRING  @"dataString"
#define ALIPAY_SCHEME      @"fromAppUrlScheme"
#define ALIPAY_TYPE        @"requestType"

@implementation TTAlixpayResult

- (id)initWithResultString:(NSString *)string
{
	if (self = [super init]) {
		
		self.statusCode = kAlixpayFail;
		self.statusMessage = @"订单支付失败";
		
		SBJsonParserS * resultParser = [[SBJsonParserS alloc] init];
		NSDictionary * jsonQuery = [resultParser objectWithString:string];
		
		do
        {
			NSDictionary * jsonMemo = [jsonQuery objectForKey:@"memo"];
			if (jsonMemo == nil)
            {
				break;
			}
			self.statusCode = [[jsonMemo objectForKey:@"ResultStatus"] integerValue];
			self.statusMessage = [jsonMemo objectForKey:@"memo"];
			if (self.statusCode != kAlixpaySuccess)
            {
				break;
			}
			
			NSString *result = [jsonMemo objectForKey:@"result"];
			
			//
			// sign type
			//
			NSRange valueRange = [result rangeOfString:@"&sign_type=\""];
			if (valueRange.location == NSNotFound)
            {
				break;
			}
            
			self.resultString = [result substringToIndex:valueRange.location];
			valueRange.location += valueRange.length;
			valueRange.length = [result length] - valueRange.location;
			NSRange tempRange = [result rangeOfString:@"\"" options:NSCaseInsensitiveSearch range:valueRange];
			if (tempRange.location == NSNotFound)
            {
				break;
			}
			valueRange.length = tempRange.location - valueRange.location;
			if (valueRange.length <= 0)
            {
				break;
			}
			self.signType = [result substringWithRange:valueRange];
			//
			// sign string.
			//
			valueRange.location = tempRange.location;
			valueRange.length = [result length] - valueRange.location;
			valueRange = [result rangeOfString:@"sign=\"" options:NSCaseInsensitiveSearch range:valueRange];
			if (valueRange.location == NSNotFound)
            {
				break;
			}
			valueRange.location += valueRange.length;
			valueRange.length = [result length] - valueRange.location;
			tempRange = [result rangeOfString:@"\"" options:NSCaseInsensitiveSearch range:valueRange];
			if (tempRange.location == NSNotFound)
            {
				break;
			}
			valueRange.length = tempRange.location - valueRange.location;
			if (valueRange.length <= 0)
            {
				break;
			}
			self.signString = [result substringWithRange:valueRange];
			
		} while (0);
		
	}
	
	return self;
}

@end

@implementation TTAlixpayOrder

- (NSString *)description
{
	NSMutableString * discription = [NSMutableString string];
	[discription appendFormat:@"partner=\"%@\"", self.partner ? self.partner : @""];
	[discription appendFormat:@"&seller=\"%@\"", self.seller ? self.seller : @""];
	[discription appendFormat:@"&out_trade_no=\"%@\"", self.tradeNO ? self.tradeNO : @""];
	[discription appendFormat:@"&subject=\"%@\"", self.productName ? self.productName : @""];
	[discription appendFormat:@"&body=\"%@\"", self.productDescription ? self.productDescription : @""];
	[discription appendFormat:@"&total_fee=\"%@\"", self.amount ? self.amount : @""];
	[discription appendFormat:@"&notify_url=\"%@\"", self.notifyURL ? self.notifyURL : @""];
	for (NSString * key in [self.extraParams allKeys])
    {
		[discription appendFormat:@"&%@=\"%@\"", key, [self.extraParams objectForKey:key]];
	}
	return discription;
}

@end

@implementation TTAlixpay

+ (instancetype)sharedInstance
{
	static id instance;
	
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		instance = [[[self class] alloc] init];
	});
	
	return instance;
}

- (NSInteger)pay:(NSString *)orderString applicationScheme:(NSString *)scheme
{
    NSInteger ret = kSPErrorOK;
	NSDictionary * oderParams = [NSDictionary dictionaryWithObjectsAndKeys:
                                 orderString, ALIPAY_DATASTRING,
                                 scheme, ALIPAY_SCHEME,
                                 ALIPAY_SAFEPAY, ALIPAY_TYPE,
                                 nil];
	
	SBJsonWriterS * OderJsonwriter = [[SBJsonWriterS alloc] init];
	NSString * jsonString = [OderJsonwriter stringWithObject:oderParams];
	
	//将数据拼接成符合alipay规范的Url
    //注意：这里改为接入独立安全支付客户端
	NSString *urlString = [NSString stringWithFormat:@"safepay://alipayclient/?%@",
							[jsonString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	NSURL *dataUrl = [NSURL URLWithString:urlString];
	
	//通过打开Url调用安全支付服务
	//实质上,外部商户只需保证把商品信息拼接成符合规范的字符串转为Url并打开,其余任何函数代码都可以自行优化
	if ([[UIApplication sharedApplication] canOpenURL:dataUrl])
    {
		[[UIApplication sharedApplication] openURL:dataUrl];
	}
	else
    {
		ret = kSPErrorAlipayClientNotInstalled;
	}	
	return ret;
}

- (TTAlixpayResult *)resultFromURL:(NSURL *)url
{
	NSString * query = [[url query] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	return [[TTAlixpayResult alloc] initWithResultString:query];
}

- (TTAlixpayResult *)handleOpenURL:(NSURL *)url
{
	TTAlixpayResult * result = nil;
	
	if (url != nil && [[url host] isEqualToString:@"safepay"])
    {
		result = [self resultFromURL:url];
	}
    
	return result;
}

@end
