//
//  TTShowMyCar.m
//  TTShow
//
//  Created by twb on 13-7-16.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import "TTShowMyCar.h"

@implementation TTShowMyCar

- (id)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if (!self)
    {
        return nil;
    }
    
    /*
     @property (nonatomic, assign) NSInteger _id;
     @property (nonatomic, strong) NSMutableArray *cars;
     @property (nonatomic, assign) NSInteger curr;
     */
    NSDictionary *carsDict = [attributes valueForKey:@"car"];
    
    self._id = [[attributes valueForKey:@"_id"] integerValue];
    self.curr = [[carsDict valueForKey:@"curr"] integerValue];
    
    if (!self.cars)
    {
        self.cars = [NSMutableArray arrayWithCapacity:0];
    }
    else
    {
        [self.cars removeAllObjects];
    }
    
    NSInteger carID = 0;
    long long int carExpireTimeStamp = 0;
    
    
    for (NSString *key in [carsDict allKeys])
    {
        if (![key isEqualToString:@"curr"])
        {
            carID = [key integerValue];
            carExpireTimeStamp = [[carsDict valueForKey:key] longLongValue];
            
            NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@(carID), kTTShowMyCarIDKey, @(carExpireTimeStamp), kTTShowMyCarExpireTimeStampKey, nil];
            
            [self.cars addObject:dict];
        }
    }
    
    return self;
}

@end
