//
//  TTShowStarPhoto.h
//  TTShow
//
//  Created by twb on 13-10-12.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 "_id" = "/1251728/0914/f652c97dc9c395174731290f7e0da41a.jpg";
 praise = 35;
 timestamp = 1379131583884;
 title = "psb (1)";
 type = 0;
 "user_id" = 1251728;
 */

#define kPhotoBaseURL @"http://img-album.b0.upaiyun.com"

@interface TTShowStarPhoto : NSObject

@property (nonatomic, strong) NSString *_id;
@property (nonatomic, assign) NSInteger praise;
@property (nonatomic, assign) long long int timestamp;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) StarPhotoType type;
@property (nonatomic, assign) NSInteger user_id;

- (id)initWithAttributes:(NSDictionary *)attributes;

@end
