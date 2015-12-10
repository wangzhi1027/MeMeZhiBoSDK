//
//  UserInfo.h
//  TTShow
//
//  Created by xh on 15/4/7.
//  Copyright (c) 2015年 twb. All rights reserved.
//

#import "JSONModel.h"

@interface UserInfo : JSONModel

@property (nonatomic, assign) NSUInteger _id;
//@property (nonatomic, assign) NSString *tuid;
@property (nonatomic, assign) NSUInteger mm_no;
@property (nonatomic, strong) NSString *user_name;
@property (nonatomic, strong) NSString *nick_name;
@property (nonatomic, strong) NSString *pic;
@property (nonatomic, assign) NSInteger priv;
@property (nonatomic, strong) Finance *finance;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, assign) NSInteger rank;
@property (nonatomic, assign) NSInteger bean_rank;
@property (nonatomic, strong) NSDictionary *coordinate;

@end

@interface UserInfoResult : JSONModel
@property (nonatomic, assign)NSInteger code;
@property (nonatomic, strong)NSString *msg;
@property (nonatomic, assign)NSInteger page;
@property (nonatomic, assign)NSInteger size;
@property (nonatomic, assign)NSInteger count;
@property (nonatomic, strong)UserInfo *data;
@end
