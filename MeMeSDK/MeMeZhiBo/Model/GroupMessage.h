//
//  GroupMessage.h
//  TTShow
//
//  Created by xh on 15/3/12.
//  Copyright (c) 2015年 twb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GroupMessage : NSObject
@property (assign, nonatomic) NSInteger messageID;
@property (assign, nonatomic) NSInteger uid;
@property (assign, nonatomic) NSInteger gid;
@property (assign, nonatomic) NSInteger type;
@property (strong, nonatomic) NSString* groupName;
@property (assign, nonatomic) NSInteger fromID;
@property (strong, nonatomic) NSString* fromName;
@property (strong, nonatomic) NSString* fromPic;
@property (assign, nonatomic) NSInteger spendCoins;
@property (strong, nonatomic) NSString* location;
@property (strong, nonatomic) NSString* msg;
@property (strong, nonatomic) NSString* pic;
@property (strong, nonatomic) NSString* audioUrl;
@property (assign, nonatomic) NSInteger seconds;
@property (assign, nonatomic) NSInteger sendStatus;
@property (assign, nonatomic) NSInteger audioReadStatus;
@property (assign, nonatomic) NSInteger bgColor;
@property (assign, nonatomic) NSInteger coins;
@property (assign, nonatomic) long long int timestamp;

- (id)initWithAttributes:(NSInteger)gid withUid:(NSInteger)uid withMsgType:(NSInteger)type withGroupName:(NSString *)groupName withFromID:(NSInteger)fid withFromName:(NSString *)fromName withFromPic:(NSString *)fromPic withSpendCoins:(NSInteger)spendCoins withMsg:(NSString *)msg withPic:(NSString *)pic  withLocation:(NSString *)location withAudioUrl:(NSString *)audioUrl withSeconds:(NSInteger)seconds withTimestamp:(long long int)timestamp withAudioReadStatus:(NSInteger)audioReadStatus withSendStatus:(NSInteger)sendStatus withBackgroundColor:(NSInteger)bgColor coins:(NSInteger)coins;
- (NSMutableDictionary*)parse2Dict;
@end
