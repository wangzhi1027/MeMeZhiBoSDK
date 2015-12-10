//
//  Group.h
//  TTShow
//
//  Created by xh on 15/3/19.
//  Copyright (c) 2015年 twb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Family.h"
#import "TTShowUser.h"

#pragma mark - group msg content
@interface GroupMessageContent : JSONModel
@property (nonatomic, strong)NSString *msg;
@property (nonatomic, strong)NSString *pic;
@property (nonatomic, strong)NSString *location;
@property (nonatomic, strong)NSString *audio_url;
@property (nonatomic, assign)NSInteger seconds;

- (id)initWithAttributes:(NSString *)msg withPic:(NSString *)pic withLocation:(NSString *)location withAudioUrl:(NSString *)audioUrl withSeconds:(NSInteger)seconds;
@end

#pragma mark - group socket msg
@interface GroupSendMessage : JSONModel
@property (nonatomic, strong)NSString *action;
@property (nonatomic, assign)NSInteger wo_id;
@property (nonatomic, strong)NSString *wo_name;
@property (nonatomic, strong)SocketUser *from;
@property (nonatomic, strong)GroupMessageContent *message;
@property (nonatomic, assign)NSInteger msg_type;
@property (nonatomic, assign)long long int timestamp;

- (id)initWithAttributes:(NSInteger)msgType withContent:(NSString *)content withPic:(NSString *)pic withLocation:(NSString *)location withAudioUrl:(NSString *)audioUrl withSecons:(NSInteger)seconds withTimestamp:(long long int)timestamp;
@end

@interface GroupRecvMessage : JSONModel
@property (nonatomic, assign)NSInteger wo_id;
@property (nonatomic, strong)NSString *wo_name;
@property (nonatomic, strong)SocketUser *from;
@property (nonatomic, strong)GroupMessageContent *message;
@property (nonatomic, assign)NSInteger msg_type;
@property (nonatomic, assign)long long int timestamp;

@end

#pragma mark - group join exit
@interface GroupJoinExit : JSONModel
@property (nonatomic, assign)NSInteger user_id;
@property (nonatomic, strong)NSString *nick_name;
@property (nonatomic, assign)long long int timestamp;

@end

#pragma mark - group shutup
@interface SocketShutUp : JSONModel
@property (nonatomic, assign)NSInteger f_id;
@property (nonatomic, strong)NSString *f_name;
@property (nonatomic, assign)NSInteger xy_user_id;
@property (nonatomic, strong)NSString *nick_name;
@property (nonatomic, assign)NSInteger minute;
@property (nonatomic, assign)NSInteger nest_id;
@property (nonatomic, assign)long long int timestamp;

@end

#pragma mark - group gift user
@interface GiftUser : JSONModel
@property (nonatomic, assign)NSInteger _id;
@property (nonatomic, strong)NSString *nick_name;
@property (nonatomic, strong)NSString *pinyin_name;
@property (nonatomic, strong)NSString *pic;
@property (nonatomic, assign)NSInteger mm_no;
@property (nonatomic, assign)NSInteger priv;
@property (nonatomic, assign)NSInteger vip;
@property (nonatomic, assign)BOOL is_guard;
@property (strong, nonatomic) Finance *finance;
@property (strong, nonatomic) Family *family;

@property (nonatomic, assign)long long int guard_car;

@end

#pragma mark - group shutup
@interface GroupGift : JSONModel
@property (nonatomic, assign)NSInteger _id;
@property (nonatomic, strong)NSString *name;
@property (nonatomic, assign)NSInteger count;
@property (nonatomic, assign)NSInteger coin_price;
@end

#pragma mark - group shutup
@interface GiftMessage : JSONModel
@property (nonatomic, strong)GiftUser *from;
@property (nonatomic, strong)GiftUser *to;
@property (nonatomic, strong)GroupGift *gift;
@property (nonatomic, assign)NSInteger nest_id;
@property (nonatomic, assign)long long int timestamp;

@end

