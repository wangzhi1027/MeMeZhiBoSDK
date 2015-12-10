//
//  CommonDataAccess.h
//  TTShow
//
//  Created by twb on 13-10-16.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import "BaseDataAccess.h"
#import "TTShowFollowStar.h"
#import "Conversation.h"
#import "FriendMessage.h"
#import "GroupMessage.h"

@class TTShowStarPhoto;
@class TTShowFollowStar;

@interface CommonDataAccess : BaseDataAccess

- (BOOL)addPraiseRecord:(TTShowStarPhoto *)photo;
- (BOOL)existPraiseRecord:(NSString *)_url;

- (BOOL)addRecentlyWatchListWithStar:(TTShowFollowRoomStar *)star;
- (BOOL)addRecentlyWatchListWithInfo:(RecordValue *)starRV;

- (NSArray *)listOfRecentlyWithTop:(NSInteger)topCount;
- (BOOL)existRecentWatchWithStar:(NSInteger)_starID;
- (BOOL)delRecentWatchWithStar:(NSInteger)_starID;

//friend
- (long long int)getLatestFriendMessageTime:(NSInteger)uid withFriendID:(NSInteger)fid;//获取某个好友最近一条消息的时间
- (BOOL)addFriendMessage:(FriendMessage *)message;//插入单条好友消息
- (NSArray *)getFriendMessageList:(NSInteger)uid withFriendID:(NSInteger)fid withCount:(NSInteger)count withOffset:(NSInteger)offset;//获取好友消息列表
- (NSInteger)getFriendMessageID:(FriendMessage *)message;
- (BOOL)updateMessageStatus:(FriendMessage *)message;
- (BOOL)delteMessage:(NSInteger)messageID;
- (BOOL)clearFriendMessages:(NSInteger)uid withFriendID:(NSInteger)fid;//清空某个群组消息

//group
- (long long int)getLatestGroupMessageTime:(NSInteger)uid withGroupID:(NSInteger)gid;//获取某个小窝最近一条消息的时间
- (long long int)getLatestUserGroupsMessageTime:(NSInteger)uid;//获取用户所有小窝的最近一条消息的时间
- (BOOL)addGroupMessage:(GroupMessage *)message;//插入单条小窝消息数据
- (BOOL)addGroupMessageList:(NSArray *)messageList;//批量插入小窝消息列表
- (NSArray *)getGroupmessageList:(NSInteger)uid withGroupID:(NSInteger)gid withCount:(NSInteger)count withOffset:(NSInteger)count;//获取小窝消息列表
- (BOOL)updateGroupMessageStatus:(GroupMessage *)message;
- (BOOL)clearGroupMessages:(NSInteger)uid withGroupID:(NSInteger)gid;//清空某个群组消息
- (BOOL)deleteGroupMessageNotInGroupIds:(NSInteger)uid withGroupIDs:(NSString *)gids;//删除所有已经退出的小窝消息记录
- (BOOL)updateGroupName:(NSInteger)uid withGroupID:(NSInteger)gid withGroupName:(NSString *)groupName;//更新小窝名字

//conversation 对话记录
- (BOOL)addConversation:(Conversation *)conversation;
- (NSMutableArray *)getConversationList:(NSInteger)uid withCount:(NSInteger)count withOffset:(NSInteger)offset;
- (BOOL)clearConversationUnreadCount:(NSInteger)uid withConversationID:(NSInteger)cid;//清除对单个好友或者单个小窝的未读消息数量
- (BOOL)clearAllConversationUnreadCount:(NSInteger)uid;//清除所有未读消息数量
- (NSInteger)getConversationUnReadCount:(NSInteger)uid withConversationID:(NSInteger)cid;//获取某个好友或小窝的未读消息数量
- (NSInteger)getUserConversationsUnReadCount:(NSInteger)uid;//获取全部未读消息数量
- (BOOL)clearConversationLatestMessage:(NSInteger)uid withConversationID:(NSInteger)cid;//清除最后一条消息记录，清空好友消息的时候用到
- (BOOL)deleteConversation:(NSInteger)uid withConversationID:(NSInteger)cid;//删除一条消息记录
- (BOOL)deleteConversationNotInConversationIDs:(NSInteger)uid withConversationIDs:(NSString *)cids;//删除所有已经退出的小窝对话记录

@end
