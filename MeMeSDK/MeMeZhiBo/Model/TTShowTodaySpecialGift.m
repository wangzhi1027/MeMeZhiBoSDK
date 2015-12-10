//
//  TTShowTodaySpecialGift.m
//  TTShow
//
//  Created by twb on 13-7-24.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import "TTShowTodaySpecialGift.h"

@implementation TTShowTodaySpecialGift

- (id)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if (!self)
    {
        return nil;
    }
    
    /*
     @property (nonatomic, assign) NSInteger s;
     @property (nonatomic, assign) NSInteger t;
     @property (nonatomic, assign) NSInteger my;
     
     @property (nonatomic, assign) NSInteger etime;
     @property (nonatomic, assign) NSInteger stime;
     @property (nonatomic, assign) CGFloat ratio;
     
     @property (nonatomic, strong) TTShowSpecialGift *gift;
     @property (nonatomic, strong) NSArray *stars;
     */
    
    self.s = [[attributes valueForKey:@"s"] integerValue];
    
    NSString *serverTimeStamp = [[attributes valueForKey:@"t"] stringValue];
    self.t = (NSInteger)[DataGlobalKit filterTimeStamp:serverTimeStamp];
    
    self.my = [[attributes valueForKey:@"my"] integerValue];
    
    // Data.
    NSDictionary *dataDict = [attributes valueForKey:@"data"];
    
    NSString *etimeString = [[dataDict valueForKey:@"etime"] stringValue];
    self.etime = (NSInteger)[DataGlobalKit filterTimeStamp:etimeString];
    
    NSString *stimeString = [[dataDict valueForKey:@"stime"] stringValue];
    self.stime = (NSInteger)[DataGlobalKit filterTimeStamp:stimeString];
    
    
    self.ratio = [[dataDict valueForKey:@"ratio"] floatValue];
    
    self.gift = [[TTShowSpecialGift alloc] initWithAttributes:[dataDict valueForKey:@"gift"]];
    
    if (self.s == kSpecialGiftProcessUnderWay)
    {
        self.stars = [NSMutableArray arrayWithCapacity:0];
        NSArray *topStars = [dataDict valueForKey:@"top"];
        for (NSDictionary *starDict in topStars)
        {
            TTShowSpecialStar *star = [[TTShowSpecialStar alloc] initWithAttributes:starDict];
            [self.stars addObject:star];
        }
    }

    if (self.t == 0)
    {
        self.specialGiftOver = [[TTShowSpecialGiftRank alloc] initWithAttributes:dataDict];
    }
    
    return self;
}

@end
