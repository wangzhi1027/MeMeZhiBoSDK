//
//  TTShowFriend.h
//  TTShow
//
//  Created by wangyifeng on 15-1-27.
//  Copyright (c) 2015年 twb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@interface TTShowFriend : JSONModel
@property (nonatomic) NSInteger _id;
@property (nonatomic, assign) NSInteger priv;
@property (nonatomic, strong) NSString *pic;
@property (nonatomic, strong) NSString *nick;
@property (nonatomic, strong) NSString *pinyin_nick;
@property (nonatomic, strong) NSDictionary *finance;

- (id)initWithAttributes:(NSDictionary *)attributes;
@end

@interface TTShowFriendRequest : NSObject
@property (nonatomic, strong) NSString *_id;
@property (nonatomic) NSInteger uid;
@property (nonatomic) NSInteger fid;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *nick_name;
@property (nonatomic, strong) NSDictionary *finance;
@property (nonatomic, strong) NSString *pic;

@property (nonatomic, assign) NSInteger status;
@property (nonatomic, assign) long long int  timestamp;


- (id)initWithAttributes:(NSDictionary *)attributes;
@end



