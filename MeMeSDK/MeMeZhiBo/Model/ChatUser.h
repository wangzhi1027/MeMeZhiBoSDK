//
//  From.h
//  TTShow
//
//  Created by xh on 15/3/12.
//  Copyright (c) 2015年 twb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Family.h"
#import "TTShowUser.h"

#pragma mark - chat user
@interface ChatUser : JSONModel
@property (assign, nonatomic) NSInteger _id;
@property (strong, nonatomic) NSString *nick_name;
@property (strong, nonatomic) NSString *pic;
@property (strong, nonatomic) NSString *pinyin_name;
@property (assign, nonatomic) NSInteger mm_no;
@property (assign, nonatomic) NSInteger vip;
@property (assign, nonatomic) NSInteger priv;
@property (strong, nonatomic) Finance *finance;
@property (strong, nonatomic) Family *family;
@property (strong, nonatomic) NSArray *medal_list;
@property (assign, nonatomic) BOOL is_guard;
@property (assign, nonatomic) NSInteger guard_car;

@end

#pragma mark - socket user
@interface SocketUser : JSONModel
@property (assign, nonatomic) NSInteger _id;
@property (strong, nonatomic) NSString *nick_name;
@property (strong, nonatomic) NSString *pic;
@property (assign, nonatomic) NSInteger mm_no;
@property (assign, nonatomic) NSInteger vip;
@property (assign, nonatomic) NSInteger priv;
@property (assign, nonatomic) NSInteger coin_spend;
@property (strong, nonatomic) NSString *client;
@property (assign, nonatomic) BOOL is_guard;
@property (assign, nonatomic) NSInteger guard_car;

- (id)initWithAttributes:(NSInteger)uid withNickName:(NSString *)nickName withPic:(NSString *)pic withCuteNum:(NSInteger)cuteNum withVip:(NSInteger)vip withPriv:(NSInteger)priv withSpendCoins:(NSInteger)coin_spend isGuard:(BOOL)isGuard guardCar:(NSInteger)guardCar;
@end
