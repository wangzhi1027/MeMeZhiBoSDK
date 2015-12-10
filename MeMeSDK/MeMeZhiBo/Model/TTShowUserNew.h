//
//  TTShowUserNew.h
//  TTShow
//
//  Created by twb on 13-6-7.
//  Copyright (c) 2013年 twb. All rights reserved.
//

/*
 From:
 url=/user/info/:access_token?qd=baidu
 {
 code:1,                    //根据状态码判断用户登录情况
 msg:"ok",
 "data": {
 "_id":1213233434,                      //用户id
 "pic":"http://img.ttpod.com/user.jpg", //用户图像
 "location":"上海",                     //所在地
 "constellation":8,                     //星座   1白羊座  2金牛座 3双子座 4巨蟹座 5狮子座 6处女座 7天秤座 8天蝎座 9射手座 10魔蝎座 11水瓶座 12双鱼座
 "stature": 1,                         //体型 1 2 3 4
 "sex":1,                               //性别 0：女 1男
 "priv":1,                              //1：运营人员   2：主播     3：普通用户
 "nick_name" :"name",
 "vip" : 0,                             //大于0的为已经购买了vip
 "vip_expires" : 111111111,             //vip过期时间
 "star":{     //改参数可能为空
 "room_id":12,                    //房间id
 "timestamp":1352115895           //注册时间
 },
 "finance":{
 "bean_count":100,                  //当前拥有维C数
 "bean_count_total":1000,           //历史拥有总维C总数
 "coin_count":100,                  //当前拥有柠檬数
 "coin_spend_total":1000,           //历史消费柠檬总数
 "spend_star_level":1               //最近七天消费星级
 },
 "gift_list": [            //用户最近送出的5个礼物的记录
 {
 "_id": 1,                                                 //礼物id
 "name": "玫瑰",                                          //礼物名
 "pic_url": "http://img.ttod.com/logo/4.jpg",             //礼物图片
 "swf_url":"http://img.ttod.com/logo/3.swf",              //动画地址
 "pic_pre_url":"http://img.ttod.com/logo/4.gif",          //动画预览地址
 "coin_price": 100                                        //礼物所需柠檬数量
 "category_id": 1,                                            //礼物分类id
 "count":100                                              //最新消费该礼物的数量
 },...{}
 ]
 }
 
 }
 */

// Important Notes: Not Making NSUserDefault Data too much complex. Or The Speed Of Reading & Writing is extremely Slow.

#import <Foundation/Foundation.h>
#import "TTShowGift.h"
#import "TTShowUser.h"

// priv 运营 1  主播 2 普通用户 3 客服 4 经纪人 5

#define kUserKeyedArchiverKeyName @"UserKeyedArchiverKeyName"

#pragma mark - Star Class.

@interface FamilyNew : JSONModel

@property (assign, nonatomic) NSInteger family_id;
@property (assign, nonatomic) NSInteger family_priv;
@property (assign, nonatomic) long long int timestamp;
@property (strong, nonatomic) NSString* family_name;
@property (strong, nonatomic) NSString* badge_name;
@property (assign, nonatomic) NSInteger week_support;

- (id)initWithAttributes:(NSDictionary *)attributes;
//- (NSDictionary *)parse2Dict;
@end


@interface TTShowUserNewStar : NSObject <NSCoding>

@property (nonatomic, assign) NSUInteger room_id;
@property (nonatomic, assign) NSUInteger timestamp;

- (id)initWithAttributes:(NSDictionary *)attributes;

@end

#pragma mark - Finance Class.
#pragma mark - User Class.

@interface TTShowUserNew : NSObject <NSCoding>

@property (nonatomic, assign) NSUInteger _id;
@property (nonatomic, strong) NSString *access_token;
@property (nonatomic, assign) NSUInteger expires_at;
@property (nonatomic, assign) NSUInteger expires_in;
@property (nonatomic, strong) NSString *nick_name;
@property (nonatomic, strong) NSString *pic;
@property (nonatomic, assign) NSUInteger sex;
//@property (nonatomic, strong) NSString * tuid;
@property (nonatomic, strong) NSString *user_name;
@property (nonatomic, strong) NSString *via;
@property (nonatomic, assign) NSUInteger weibo_enabled;
@property (nonatomic, assign) NSInteger rank;
@property (nonatomic, assign) NSInteger bean_rank;
//
@property (nonatomic, strong) NSString *location;
@property (nonatomic, assign) NSUInteger constellation;
@property (nonatomic, assign) NSUInteger stature;
@property (nonatomic, assign) NSUInteger priv;
@property (nonatomic, assign) NSUInteger vip;
@property (nonatomic, assign) long long int vip_expires;
@property (nonatomic, strong) NSDictionary *star;
@property (nonatomic, strong) NSDictionary *finance;
@property (nonatomic, strong) NSMutableArray *gift_list;

@property (nonatomic, strong) NSDictionary *car;
@property (nonatomic, assign) BOOL live;
@property (nonatomic, strong) NSDictionary *tag;
@property (nonatomic, assign) long long int week_spend;

@property (nonatomic, assign) NSUInteger momo_num;
@property (strong, nonatomic) NSDictionary *family;



- (id)initWithAttributes:(NSDictionary *)attributes;

+ (TTShowUserNew *)unarchiveUser;
+ (void)archiveUser:(TTShowUserNew *)user;
+ (BOOL)archiveDataValid;
+ (NSString *)access_token;
+ (NSString *)nick_name;
+ (long long int)bean_count;
+ (long long int)coin_spend_total;
+ (void)logout;

@end

