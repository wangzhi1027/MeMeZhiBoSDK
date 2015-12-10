//
//  TTShowRoomStar.m
//  TTShow
//
//  Created by twb on 13-6-20.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import "TTShowRoomStar.h"

@implementation TTShowRoomStar

- (id)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    /*
     @property (nonatomic, assign) NSUInteger _id;
     @property (nonatomic, strong) NSString *nick_name;
     
     @property (nonatomic, assign) NSUInteger day_rank;
     @property (nonatomic, strong) NSArray *gift_week;
     @property (nonatomic, assign) NSUInteger room_id;
     
     @property (nonatomic, assign) NSUInteger bean_count_total;
     @property (nonatomic, assign) NSUInteger coin_spend_total;
     
     @property (nonatomic, strong) NSString *pic;
     @property (nonatomic, strong) NSDictionary *tag;
     
     @property (nonatomic, strong) NSString *live_id;
     @property (nonatomic, strong) NSString *message;
     @property (nonatomic, strong) NSString *greetings;
     @property (nonatomic, strong) NSString *pic_url;
     */
    
    
    NSDictionary *userDictionary = [attributes valueForKey:@"user"];
    NSDictionary *roomDictionary = [attributes valueForKey:@"room"];
    
    if (userDictionary != nil)
    {
        self._id = [[userDictionary valueForKey:@"_id"] unsignedIntegerValue];
        self.nick_name = [[userDictionary valueForKey:@"nick_name"] stringByUnescapingFromHTML];
        
        self.day_rank = [[[userDictionary valueForKey:@"star"] valueForKey:@"day_rank"] unsignedIntegerValue];
        self.gift_week = [[userDictionary valueForKey:@"star"] valueForKey:@"gift_week"];
        self.room_id = [[[userDictionary valueForKey:@"star"] valueForKey:@"room_id"] unsignedIntegerValue];
        
        self.bean_count_total = [[[userDictionary valueForKey:@"finance"] valueForKey:@"bean_count_total"] longLongValue];
        self.coin_spend_total = [[[userDictionary valueForKey:@"finance"] valueForKey:@"coin_spend_total"] longLongValue];
        self.feather_receive_total = [[[userDictionary valueForKey:@"finance"] valueForKey:@"feather_receive_total"] unsignedIntegerValue];
        
        self.pic = [userDictionary valueForKey:@"pic"];
        self.tag = [userDictionary valueForKey:@"tag"];
        self.vip = [[userDictionary valueForKey:@"vip"] integerValue];
    }
    
    if (roomDictionary != nil)
    {
        self.isLive = [roomDictionary valueForKey:@"live"];
        self.live_id = [roomDictionary valueForKey:@"live_id"];
        self.message = [roomDictionary valueForKey:@"message"];
        self.pic_url = [roomDictionary valueForKey:@"pic_url"];
        self.greetings = [[roomDictionary valueForKey:@"greetings"] stringByUnescapingFromHTML];
        if (!self.greetings) {
            self.greetings = @"欢迎来到我的直播间，喜欢我的朋友可以点右上角关注我哦！";
        }
        
        // filter url.
        NSRange range = [self.greetings rangeOfString:@"redirect"];
        if (range.location != NSNotFound)
        {
            self.greetings = [self.greetings substringToIndex:range.location];
        }
    }
    
    return self;
}


@end
