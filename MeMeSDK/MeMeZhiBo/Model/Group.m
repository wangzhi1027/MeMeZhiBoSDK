//
//  Group.m
//  TTShow
//
//  Created by xh on 15/3/19.
//  Copyright (c) 2015年 twb. All rights reserved.
//

#import "Group.h"

#pragma mark - group msg content
@implementation GroupMessageContent

- (id)initWithAttributes:(NSString *)msg withPic:(NSString *)pic withLocation:(NSString *)location withAudioUrl:(NSString *)audioUrl withSeconds:(NSInteger)seconds
{
    self = [super init];
    if (!self) {
        return nil;
    }
    self.msg = msg;
    self.pic = pic;
    self.location = location;
    self.audio_url = audioUrl;
    self.seconds = seconds;
    return self;
}
@end

#pragma mark - group socket msg
@implementation GroupSendMessage

+(JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"data.wo_id" : @"wo_id",
                                                       @"data.wo_name" : @"wo_name",
                                                       @"data.from" : @"from",
                                                       @"data.message" : @"message",
                                                       @"data.msg_type" : @"msg_type",
                                                       @"data.timestamp" : @"timestamp",}];
}

- (id)initWithAttributes:(NSInteger)msgType withContent:(NSString *)content withPic:(NSString *)pic withLocation:(NSString *)location withAudioUrl:(NSString *)audioUrl withSecons:(NSInteger)seconds withTimestamp:(long long int)timestamp
{
    self = [super init];
    if (!self) {
        return nil;
    }
    self.action = @"wo.chat";
    TTShowUser *user = [Manager sharedInstance].dataManager.me;
    Finance *finance = [[Finance alloc] initWithAttributes:user.finance];
    
    self.wo_id = [Manager sharedInstance].dataManager.currentChatGroupID;
    self.wo_name = [Manager sharedInstance].dataManager.currentChatGroupName;
    self.from = [[SocketUser alloc] initWithAttributes:user._id withNickName:user.nick_name withPic:user.pic withCuteNum:0 withVip:user.vip withPriv:user.priv withSpendCoins:finance.coin_spend_total isGuard:NO guardCar:0];
    self.message = [[GroupMessageContent alloc] initWithAttributes:content withPic:pic withLocation:location withAudioUrl:audioUrl withSeconds:seconds];
    self.msg_type = msgType;
    self.timestamp = timestamp;
    return self;
}
@end

@implementation GroupRecvMessage

@end

#pragma mark - group join exit
@implementation GroupJoinExit


@end

#pragma mark - group shut up
@implementation SocketShutUp


@end

#pragma mark - group socket msg
@implementation GiftUser

@end

#pragma mark - group socket msg
@implementation GroupGift

@end
#pragma mark - group socket msg
@implementation GiftMessage


@end

