//
//  TTShowStarPhoto.m
//  TTShow
//
//  Created by twb on 13-10-12.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import "TTShowStarPhoto.h"



@implementation TTShowStarPhoto

- (id)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    /*
     @property (nonatomic, strong) NSString *_id;
     @property (nonatomic, assign) NSInteger praise;
     @property (nonatomic, assign) long long int timestamp;
     @property (nonatomic, strong) NSString *title;
     @property (nonatomic, assign) StarPhotoType type;
     @property (nonatomic, assign) NSInteger user_id;
     */
    self._id = [kPhotoBaseURL stringByAppendingString:[attributes valueForKey:@"_id"]];
    self.praise = [[attributes valueForKey:@"praise"] integerValue];
    self.timestamp = [[attributes valueForKey:@"timestamp"] longLongValue];
    self.title = [attributes valueForKey:@"title"];
    self.type = [[attributes valueForKey:@"type"] integerValue];
    self.user_id = [[attributes valueForKey:@"user_id"] integerValue];
    
    return self;
}

@end
