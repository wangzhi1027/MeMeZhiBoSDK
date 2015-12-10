//
//  RageIAPHelper.m
//  In App Rage
//
//  Created by Ray Wenderlich on 9/5/12.
//  Copyright (c) 2012 Razeware LLC. All rights reserved.
//
//  Another Sample. https://github.com/saturngod/IAPHelper/tree/master/IAPHelper

#import "RageIAPHelper.h"
#import "TTShowRemote.h"

@implementation RageIAPHelper

//+ (RageIAPHelper *)sharedInstance {
//    static dispatch_once_t once;
//    static RageIAPHelper * sharedInstance;
//    dispatch_once(&once, ^{
//#if 1
//        NSArray *products = [[TTShowRemote sharedInstance] retrieveSyncProducts];
//        if (products != nil)
//        {
//            NSSet *productIdentifiers = [NSSet setWithArray:products];
//            sharedInstance = [[self alloc] initWithProductIdentifiers:productIdentifiers];
//        }
//        else
//        {
//            LOGERROR(@"Retrieve products failure.");
//            
//            NSMutableSet *productIdentifiers = [NSMutableSet set];
//            [productIdentifiers addObject:@"com.ttpod.show.coin560"];
//            [productIdentifiers addObject:@"com.ttpod.show.coin1260"];
//            [productIdentifiers addObject:@"com.ttpod.show.coin2100"];
//            [productIdentifiers addObject:@"com.ttpod.show.coin3500"];
//            [productIdentifiers addObject:@"com.ttpod.show.coin1260"];
//            [productIdentifiers addObject:@"com.ttpod.show.coin7560"];
//            [productIdentifiers addObject:@"com.ttpod.show.coin22960"];
//            [productIdentifiers addObject:@"com.ttpod.show.coin41160"];
//            [productIdentifiers addObject:@"com.ttpod.show.coin69860"];
//            sharedInstance = [[self alloc] initWithProductIdentifiers:productIdentifiers];
//        }
//#else
//            NSMutableSet *productIdentifiers = [NSMutableSet set];
//            [productIdentifiers addObject:@"com.ttpod.show.coin560"];
//            [productIdentifiers addObject:@"com.ttpod.show.coin1260"];
//            [productIdentifiers addObject:@"com.ttpod.show.coin2100"];
//            [productIdentifiers addObject:@"com.ttpod.show.coin3500"];
//            [productIdentifiers addObject:@"com.ttpod.show.coin1260"];
//            [productIdentifiers addObject:@"com.ttpod.show.coin7560"];
//            [productIdentifiers addObject:@"com.ttpod.show.coin22960"];
//            [productIdentifiers addObject:@"com.ttpod.show.coin41160"];
//            [productIdentifiers addObject:@"com.ttpod.show.coin69860"];
//            sharedInstance = [[self alloc] initWithProductIdentifiers:productIdentifiers];
//#endif
//    });
//    return sharedInstance;
//}

@end
