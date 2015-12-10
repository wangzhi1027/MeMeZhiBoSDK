//
//  From.m
//  TTShow
//
//  Created by xh on 15/3/12.
//  Copyright (c) 2015年 twb. All rights reserved.
//

#import "ChatUser.h"

@implementation ChatUser

@end

@implementation SocketUser

- (id)initWithAttributes:(NSInteger)uid withNickName:(NSString *)nickName withPic:(NSString *)pic withCuteNum:(NSInteger)cuteNum withVip:(NSInteger)vip withPriv:(NSInteger)priv withSpendCoins:(NSInteger)coin_spend isGuard:(BOOL)isGuard guardCar:(NSInteger)guardCar
{
    self = [super init];
    if (!self) {
        return nil;
    }
    self._id = uid;
    self.nick_name = nickName;
    self.pic = pic;
    self.mm_no = cuteNum;
    self.vip = vip;
    self.priv = priv;
    self.coin_spend = coin_spend;
    self.is_guard = isGuard;
    self.guard_car = guardCar;
    return self;
}
@end
