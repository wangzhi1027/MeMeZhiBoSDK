//
//  TTShowRemote+Gift.h
//  TTShow
//
//  Created by twb on 13-10-11.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import "TTShowRemote.h"

@interface TTShowRemote (Gift)

- (void)retrieveGiftListWithCompeletion:(RemoteCompletionDoubleArray)completion;
- (void)_sendGiftWithParam:(NSDictionary *)param completion:(RemoteCompletionBool)completion;
- (void)sendFortune:(NSInteger)roomId count:(NSInteger)count successBlock:(SuccessBlock)successBlock failBlock:(FailBlock)failBlock;
- (void)sendBagGift:(NSInteger)roomId giftId:(NSInteger)giftId userId:(NSInteger)userId count:(NSInteger)count successBlock:(SuccessBlock)successBlock failBlock:(FailBlock)failBlock;
// Yesterday Special Gift.
//- (void)_retrieveYesterdaySpecialGift:(void (^)(TTShowSpecialGiftRank *specialGift, NSError *error))block;
//// Today Special Gift
//- (void)_retrieveTodaySpecialGift:(NSInteger)roomID block:(void (^)(TTShowTodaySpecialGift *today, NSError *error))block;

- (void)_sendFortune:(NSInteger)roomId count:(NSInteger)count successBlock:(SuccessBlock)successBlock failBlock:(FailBlock)failBlock;

@end
