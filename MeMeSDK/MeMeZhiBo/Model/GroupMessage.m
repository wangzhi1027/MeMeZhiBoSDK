//
//  GroupMessage.m
//  TTShow
//
//  Created by xh on 15/3/12.
//  Copyright (c) 2015年 twb. All rights reserved.
//

#import "GroupMessage.h"

@implementation GroupMessage

- (NSMutableDictionary*)parse2Dict
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dict setValue:@(self.uid) forKey:@"uid"];
    [dict setValue:@(self.gid) forKey:@"gid"];
    [dict setValue:@(self.fromID) forKey:@"fid"];
    [dict setValue:@(self.type) forKey:@"type"];
    [dict setValue:self.groupName forKey:@"group_name"];
    [dict setValue:self.fromName forKey:@"from_name"];
    [dict setValue:self.fromPic forKey:@"from_pic"];
    [dict setValue:@(self.spendCoins) forKey:@"spend_coins"];
    [dict setValue:self.location forKey:@"location"];
    [dict setValue:self.msg forKey:@"msg"];
    [dict setValue:self.pic forKey:@"pic"];
    [dict setValue:self.audioUrl forKey:@"audio_url"];
    [dict setValue:@(self.seconds) forKey:@"seconds"];
    [dict setValue:@(self.sendStatus) forKey:@"send_status"];
    [dict setValue:@(self.audioReadStatus) forKey:@"read_status"];
    [dict setValue:@(self.bgColor) forKey:@"bg_color"];
    [dict setValue:@(self.timestamp) forKey:@"timestamp"];
    return dict;
}

- (id)initWithAttributes:(NSInteger)gid withUid:(NSInteger)uid withMsgType:(NSInteger)type withGroupName:(NSString *)groupName withFromID:(NSInteger)fid withFromName:(NSString *)fromName withFromPic:(NSString *)fromPic withSpendCoins:(NSInteger)spendCoins withMsg:(NSString *)msg withPic:(NSString *)pic withLocation:(NSString *)location withAudioUrl:(NSString *)audioUrl withSeconds:(NSInteger)seconds withTimestamp:(long long int)timestamp withAudioReadStatus:(NSInteger)audioReadStatus withSendStatus:(NSInteger)sendStatus withBackgroundColor:(NSInteger)bgColor coins:(NSInteger)coins
{
    self = [super init];
    if (!self) {
        return nil;
    }
    self.gid = gid;
    self.uid = uid;
    self.type = type;
    self.groupName = groupName;
    self.fromID = fid;
    self.fromName = fromName;
    self.fromPic = fromPic;
    self.spendCoins = spendCoins;
    self.msg = msg;
    self.pic = pic;
    self.location = location;
    self.audioUrl = audioUrl;
    self.seconds = seconds;
    self.timestamp = timestamp;
    self.audioReadStatus = audioReadStatus;
    self.sendStatus = sendStatus;
    self.bgColor = bgColor;
    self.coins = coins;
    return self;
}
@end
