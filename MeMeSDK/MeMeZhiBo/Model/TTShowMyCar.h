//
//  TTShowMyCar.h
//  TTShow
//
//  Created by twb on 13-7-16.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kTTShowMyCarIDKey @"mycarid"
#define kTTShowMyCarExpireTimeStampKey @"mycartimestamp"

@interface TTShowMyCar : NSObject

@property (nonatomic, assign) NSInteger _id;
@property (nonatomic, strong) NSMutableArray *cars;
@property (nonatomic, assign) NSInteger curr;

- (id)initWithAttributes:(NSDictionary *)attributes;

@end
