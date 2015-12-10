//
//  TTShowHeadRank.h
//  TTShow
//
//  Created by twb on 13-10-21.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, HeadRankType)
{
    kHeadRankStar = 0,
    kHeadRankRich,
    kHeadRankDemand,
    kHeadRankCharm,
    kHeadRankGiftWeek,
    kHeadRankSpecialGift,
    kHeadRankMax
};

#define kHeadRankImageNodeName @"pic"


@interface TTShowHeadRank : NSObject

@property (nonatomic, assign) HeadRankType type;
@property (nonatomic, strong) NSMutableArray *pics;

- (id)initWithAttributes:(NSDictionary *)attributes;

@end
