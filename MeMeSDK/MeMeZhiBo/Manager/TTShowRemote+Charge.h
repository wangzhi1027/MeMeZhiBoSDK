//
//  TTShowRemote+Charge.h
//  TTShow
//
//  Created by twb on 13-10-10.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import "TTShowRemote.h"

@interface TTShowRemote (Charge)

- (NSArray *)_retrieveSyncProducts;
- (void)_retrieveAsyncProductsWithCompletition:(RemoteCompletionArray)completition;
- (BOOL)_chargeFromAppStore:(NSData *)data isSandbox:(NSInteger)flag;
- (void)_getWapPayURLByMethod:(WapPayMethod)method amount:(NSInteger)amount completion:(RemoteCompletionWapPay)completion;
-(void)retrieveProducts:(RemoteCompletionArray)completition;

-(void)retrieveIsJailBreak:(RemoteCompletionBool)completition;
@end
