//
//  IAPHelper.m
//  In App Rage
//
//  Created by Ray Wenderlich on 9/5/12.
//  Copyright (c) 2012 Razeware LLC. All rights reserved.
//

// 1
#import "IAPHelper.h"
#import <StoreKit/StoreKit.h>
#import "TTShowRemote.h"
#import "TTShowRemote+Charge.h"

//#if 0
//#define kPurchaseVerifyUrl @"https://buy.itunes.apple.com/verifyReceipt"
//#else
//#define kPurchaseVerifyUrl @"https://sandbox.itunes.apple.com/verifyReceipt"
//#endif


NSString *const IAPHelperProductPurchasedNotification = @"IAPHelperProductPurchasedNotification";
NSString *const IAPHelperProductPurchaseFailureNotification = @"IAPHelperProductPurchaseFailureNotification";

// 2
@interface IAPHelper () <SKProductsRequestDelegate, SKPaymentTransactionObserver>
@end

// 3
@implementation IAPHelper
{
    SKProductsRequest * _productsRequest;
    RequestProductsCompletionHandler _completionHandler;
    
    NSSet * _productIdentifiers;
    NSMutableSet * _purchasedProductIdentifiers;
}

#pragma mark - Life cycle.

- (void)dealloc
{
    _completionHandler = nil;
    _productsRequest.delegate = nil;
    _productsRequest = nil;
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
}

- (id)initWithProductIdentifiers:(NSSet *)productIdentifiers
{
    if ((self = [super init]))
    {
        // Store product identifiers
        _productIdentifiers = productIdentifiers;
        
        // Check for previously purchased products
        _purchasedProductIdentifiers = [NSMutableSet set];
        for (NSString * productIdentifier in _productIdentifiers)
        {
            BOOL productPurchased = [[NSUserDefaults standardUserDefaults] boolForKey:productIdentifier];
            if (productPurchased)
            {
                [_purchasedProductIdentifiers addObject:productIdentifier];
            }
            else
            {
            }
        }
        // Add self as transaction observer
        [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    }
    return self;
}

// Base64 Encode. Apple's rules.
static NSString *IAPBase64EncodedStringFromString(NSString *string)
{
    NSData *data = [NSData dataWithBytes:[string UTF8String] length:[string lengthOfBytesUsingEncoding:NSUTF8StringEncoding]];
    NSUInteger length = [data length];
    NSMutableData *mutableData = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
    
    uint8_t *input = (uint8_t *)[data bytes];
    uint8_t *output = (uint8_t *)[mutableData mutableBytes];
    
    for (NSUInteger i = 0; i < length; i += 3)
    {
        NSUInteger value = 0;
        for (NSUInteger j = i; j < (i + 3); j++)
        {
            value <<= 8;
            if (j < length) {
                value |= (0xFF & input[j]);
            }
        }
        
        static uint8_t const kAFBase64EncodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
        
        NSUInteger idx = (i / 3) * 4;
        output[idx + 0] = kAFBase64EncodingTable[(value >> 18) & 0x3F];
        output[idx + 1] = kAFBase64EncodingTable[(value >> 12) & 0x3F];
        output[idx + 2] = (i + 1) < length ? kAFBase64EncodingTable[(value >> 6)  & 0x3F] : '=';
        output[idx + 3] = (i + 2) < length ? kAFBase64EncodingTable[(value >> 0)  & 0x3F] : '=';
    }
    
    return [[NSString alloc] initWithData:mutableData encoding:NSASCIIStringEncoding];
}

- (void)requestProductsWithCompletionHandler:(RequestProductsCompletionHandler)completionHandler
{
    // 1
    _completionHandler = [completionHandler copy];
    
    // 2
    _productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:_productIdentifiers];
    _productsRequest.delegate = self;
    NSLog(@"%@",_productsRequest);
    [_productsRequest start];
    
}

//用户是否允许应用内付费YES开始购买请求    NO提示用户禁用了应用内付费
//- (void)buyProduct:(NSString *)productIdentifier
//{
//    if ([SKPaymentQueue canMakePayments]) {
//        NSSet * productIdentifiers = [NSSet setWithObject:productIdentifier];
//        _productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:productIdentifiers];
//        _productsRequest.delegate = self;
//        [_productsRequest start];
//    }
//    else{
//        
//    }
//}

- (BOOL)productPurchased:(NSString *)productIdentifier
{
    return [_purchasedProductIdentifiers containsObject:productIdentifier];
}

- (void)buyProduct:(SKProduct *)product
{
    self.purchasing = YES;
    
    SKPayment * payment = [SKPayment paymentWithProduct:product];
    [[SKPaymentQueue defaultQueue] addPayment:payment];
    
}

#pragma mark - SKProductsRequestDelegate

- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
{
    
    NSArray * skProducts = response.products;
    
    // sort by price.
    NSSortDescriptor *sortByPrice = [NSSortDescriptor sortDescriptorWithKey:@"price" ascending:YES];
    NSArray *results = [skProducts sortedArrayUsingDescriptors:@[sortByPrice]];
    
#if 0
    for (SKProduct * skProduct in results)
    {
                skProduct.productIdentifier,
                skProduct.localizedTitle,
                skProduct.price.floatValue);
    }
#endif
    
    if (_completionHandler)
    {
        _completionHandler(YES, results, nil);
    }
}

- (void)request:(SKRequest *)request didFailWithError:(NSError *)error
{
    
    if (_completionHandler)
    {
        _completionHandler(NO, nil, error);
    }
}

#pragma mark SKPaymentTransactionOBserver

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{
    for (SKPaymentTransaction * transaction in transactions)
    {
        switch (transaction.transactionState)
        {
            case SKPaymentTransactionStatePurchased:
                [self completeTransaction:transaction];
                break;
            case SKPaymentTransactionStateFailed:
                [self failedTransaction:transaction];
                break;
            case SKPaymentTransactionStateRestored:
                [self restoreTransaction:transaction];
            default:
                break;
        }
    };
}

// Verify purchased results.
- (BOOL)verifyTransaction:(SKPaymentTransaction *)transaction
{
    
    NSString *recptStr = [NSString stringWithUTF8String:[transaction transactionReceipt].bytes];
    
    NSRange range = [recptStr rangeOfString:@"\"Sandbox\";"];
    
    NSString *base64String = IAPBase64EncodedStringFromString([NSString stringWithUTF8String:[transaction transactionReceipt].bytes]);
    NSDictionary *tempDict = [NSDictionary dictionaryWithObject:base64String forKey:@"receipt-data"];
    
    NSString *josnValue = [tempDict JSONRepresentation];
    NSData *postData = [NSData dataWithBytes:[josnValue UTF8String] length:[josnValue length]];
    
    BOOL chargeSuccess;
    if (range.location != NSNotFound)
    {
        chargeSuccess  = [[TTShowRemote sharedInstance] _chargeFromAppStore:postData isSandbox:1];
    }else
    {
        chargeSuccess  = [[TTShowRemote sharedInstance] _chargeFromAppStore:postData isSandbox:0];
    }
    
    
    return chargeSuccess;}

- (void)completeTransaction:(SKPaymentTransaction *)transaction
{
    
    BOOL purchaseSuccess = [self verifyTransaction:transaction];
    [self provideContentForTransaction:transaction successful:purchaseSuccess];
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
    self.purchasing = NO;
}

- (void)restoreTransaction:(SKPaymentTransaction *)transaction
{
    
    [self provideContentForTransaction:transaction successful:YES];
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
    self.purchasing = NO;
}

- (void)failedTransaction:(SKPaymentTransaction *)transaction
{
    if (transaction.error.code != SKErrorPaymentCancelled)
    {
    }
    
    switch (transaction.error.code)
    {
        case SKErrorUnknown:
            break;
        case SKErrorClientInvalid:
            break;
        case SKErrorPaymentCancelled:
            break;
        case SKErrorPaymentInvalid:
            break;
        case SKErrorPaymentNotAllowed:
            break;
        default:
            break;
    }
    
    if (transaction != nil)
    {
        [kNotificationCenter postNotificationName:IAPHelperProductPurchaseFailureNotification object:@"" userInfo:nil];
    }
    
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
    self.purchasing = NO;
}

- (void)provideContentForTransaction:(SKPaymentTransaction *)transaction successful:(BOOL)s
{
    if (s)
    {
        [_purchasedProductIdentifiers addObject:transaction.payment.productIdentifier];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:transaction.payment.productIdentifier];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [kNotificationCenter postNotificationName:IAPHelperProductPurchasedNotification object:transaction userInfo:nil];
    }
    else
    {
        [kNotificationCenter postNotificationName:IAPHelperProductPurchaseFailureNotification object:transaction userInfo:nil];
    }
}

- (void)restoreCompletedTransactions
{
    [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
}

@end