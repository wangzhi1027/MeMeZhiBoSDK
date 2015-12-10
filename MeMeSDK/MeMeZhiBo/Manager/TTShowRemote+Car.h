//
//  TTShowRemote+Car.h
//  memezhibo
//
//  Created by Xingai on 15/5/21.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "TTShowRemote.h"
#import "TTShowMyCar.h"

@interface TTShowRemote (Car)

- (void)retrieveCarList:(RemoteCompletionDoubleArray)completion;

- (void)retrieveMyCarList:(void (^)(TTShowMyCar *myCar, NSError *error))block;

- (void)setMyDefaultCar:(NSInteger)carID completion:(RemoteCompletionBool)completion;

- (void)cancelMyDefaultCar:(RemoteCompletionBool)completion;

- (void)buyCar:(NSInteger)carID completion:(RemoteCompletionBool)completion;

@end
