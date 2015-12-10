//
//  TTShowTodaySpecialGift.h
//  TTShow
//
//  Created by twb on 13-7-24.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTShowSpecialGiftRank.h"

typedef NS_ENUM(NSInteger, SpecialGiftProcess)
{
    kSpecialGiftProcessStart = 0,
    kSpecialGiftProcessUnderWay,
    kSpecialGiftProcessOver,
    kSpecialGiftProcessMax
};

@interface TTShowTodaySpecialGift : NSObject

@property (nonatomic, assign) NSInteger s;
@property (nonatomic, assign) NSInteger t;
@property (nonatomic, assign) NSInteger my;

@property (nonatomic, assign) NSInteger etime;
@property (nonatomic, assign) NSInteger stime;
@property (nonatomic, assign) CGFloat ratio;

@property (nonatomic, strong) TTShowSpecialGift *gift;
@property (nonatomic, strong) NSMutableArray *stars;

@property (nonatomic, strong) TTShowSpecialGiftRank *specialGiftOver;

- (id)initWithAttributes:(NSDictionary *)attributes;

@end
