//
//  Conversation.h
//  TTShow
//
//  Created by xh on 15/3/12.
//  Copyright (c) 2015年 twb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Conversation : NSObject

@property (assign, nonatomic) NSInteger cid;
@property (assign, nonatomic) NSInteger uid;
@property (assign, nonatomic) NSInteger fid;
@property (assign, nonatomic) NSInteger type;
@property (strong, nonatomic) NSString* groupName;
@property (strong, nonatomic) NSString* fromName;
@property (strong, nonatomic) NSString* msg;
@property (strong, nonatomic) NSString* pic;
@property (strong, nonatomic) NSString* audioUrl;
@property (assign, nonatomic) NSInteger seconds;
@property (assign, nonatomic) long long int timestamp;
@property (assign, nonatomic) NSInteger unReadCount;

- (NSMutableDictionary*)parse2Dict;
- (id)initWithAttributes:(NSInteger)cid userID:(NSInteger)uid friendID:(NSInteger)fid msgType:(NSInteger)msgType groupName:(NSString *)groupName
                fromName:(NSString *)fromName msg:(NSString *)msg pic:(NSString *)pic audioUrl:(NSString *)audioUrl duration:(NSInteger)seconds timestamp:(long long int)timestamp unReadCount:(NSInteger)unReadCount;
@end
