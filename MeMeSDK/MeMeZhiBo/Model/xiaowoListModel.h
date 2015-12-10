//
//  xiaowoListModel.h
//  memezhibo
//
//  Created by Xingai on 15/8/25.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"


@interface xiaowoListModel : NSObject


@property (nonatomic, assign) NSUInteger _id;
@property (nonatomic, assign) NSUInteger user_id;
@property (nonatomic, assign) NSUInteger m_count;
@property (nonatomic, assign) NSUInteger visitor_count;
@property (nonatomic, assign) NSUInteger followers;
@property (nonatomic, assign) long long int  timestamp;

@property (nonatomic, assign) NSInteger mic_first;
@property (nonatomic, assign) NSInteger mic_sec;

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *notice;
@property (nonatomic, strong) NSString *pic;

//@property (nonatomic, strong) NSDictionary *sec_user_info;
//
//@property (nonatomic, strong) NSDictionary *first_user_info;

//@property (nonatomic, strong) NSArray *admin;

//@property (nonatomic, strong) NSDictionary *creator;

@end
