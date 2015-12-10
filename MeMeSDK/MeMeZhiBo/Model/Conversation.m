//
//  Conversation.m
//  TTShow
//
//  Created by xh on 15/3/12.
//  Copyright (c) 2015年 twb. All rights reserved.
//

#import "Conversation.h"

@implementation Conversation

- (NSMutableDictionary *)parse2Dict
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dict setValue:@(self.cid) forKey:@"cid"];
    [dict setValue:@(self.uid) forKey:@"uid"];
    [dict setValue:@(self.fid) forKey:@"fid"];
    [dict setValue:@(self.type) forKey:@"type"];
    [dict setValue:self.groupName forKey:@"group_name"];
    [dict setValue:self.fromName forKey:@"from_name"];
    [dict setValue:self.msg forKey:@"msg"];
    [dict setValue:self.pic forKey:@"pic"];
    [dict setValue:self.audioUrl forKey:@"audio_url"];
    [dict setValue:@(self.seconds) forKey:@"seconds"];
    [dict setValue:@(self.timestamp) forKey:@"timestamp"];
    [dict setValue:@(self.unReadCount) forKey:@"un_read_count"];
    return dict;
}

- (id)initWithAttributes:(NSInteger)cid userID:(NSInteger)uid friendID:(NSInteger)fid msgType:(NSInteger)msgType groupName:(NSString *)groupName
                fromName:(NSString *)fromName msg:(NSString *)msg pic:(NSString *)pic audioUrl:(NSString *)audioUrl duration:(NSInteger)seconds timestamp:(long long int)timestamp unReadCount:(NSInteger)unReadCount
{
    self = [super init];
    if (!self) {
        return nil;
    }
    self.cid = cid;
    self.uid = uid;
    self.fid = fid;
    self.type = msgType;
    self.groupName = groupName;
    self.fromName = fromName;
    self.msg = msg;
    self.pic = pic;
    self.audioUrl = audioUrl;
    self.seconds = seconds;
    self.timestamp = timestamp;
    self.unReadCount = unReadCount;
    return self;
}

@end
