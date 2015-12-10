//
//  TTShowMainImageList.m
//  memezhibo
//
//  Created by Xingai on 15/5/27.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "TTShowMainImageList.h"

@implementation TTShowMainImageList

- (id)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    /*
     @property (nonatomic, assign) HeadRankType type;
     @property (nonatomic, strong) NSMutableArray *pics;
     */
    
    
    self.pic_url = [attributes valueForKey:@"pic_url"];
    self.click_url = [attributes valueForKey:@"click_url"];
    self.title = [attributes valueForKey:@"title"];
    
    return self;
}

@end
