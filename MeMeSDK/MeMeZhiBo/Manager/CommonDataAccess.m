//
//  CommonDataAccess.m
//  TTShow
//
//  Created by twb on 13-10-16.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import "CommonDataAccess.h"
#import "TTShowFollowStar.h"
#import "TTShowStarPhoto.h"

/*
 TTShow_Recently_Watch_List:
 @"id TEXT NOT NULL PRIMARY KEY",
 @"roomid TEXT",
 @"live TEXT",
 @"timestamp TEXT",
 @"xy_star_id TEXT",
 @"starid TEXT",
 @"bean_count_total TEXT",
 @"nick_name TEXT",
 @"pic TEXT"

 TTShow_Photo_Praise_Record
 @"id INTEGER PRIMARY KEY AUTOINCREMENT",
 @"title TEXT",
 @"url TEXT"
 */

@implementation CommonDataAccess

- (BOOL)addPraiseRecord:(TTShowStarPhoto *)photo
{
    RecordValue *photoRV = [RecordValue dictionaryWithObjectsAndKeys:
                           photo.title, @"title",
                           photo._id, @"url",
                           nil];
	return [self.db insertTable:@"TTShow_Photo_Praise_Record" withDictionary:photoRV];
}

- (BOOL)existPraiseRecord:(NSString *)_url
{
    MMFMResultSet *r = nil;
    NSInteger count = 0;
    r = [self.db executeQueryWithFormat:@"SELECT COUNT(*) FROM TTShow_Photo_Praise_Record WHERE url=%@", _url];
    
	while(r.next)
    {
        count = [r intForColumnIndex:0];
	}
	return count != 0;
}

- (BOOL)addRecentlyWatchListWithStar:(TTShowFollowRoomStar *)star
{
    RecordValue *starRV = [RecordValue dictionaryWithObjectsAndKeys:
                            @(star.roomID), @"roomid",
                            @(star.live), @"live",
                            @(star.timestamp), @"timestamp",
                            @(star.xy_star_id), @"xy_star_id",
                            @(star.starID), @"starid",
                            @(star.bean_count_total), @"bean_count_total",
                            star.nick_name, @"nick_name",
                            star.pic, @"pic",
                            nil];
    return [self addRecentlyWatchListWithInfo:starRV];
}

- (BOOL)addRecentlyWatchListWithInfo:(RecordValue *)starRV
{
	assert(starRV);

	return [self.db insertTable:@"TTShow_Recently_Watch_List" withDictionary:starRV];
}

- (NSArray *)listOfRecentlyWithTop:(NSInteger)topCount;
{
    MMFMResultSet *r = nil;
    
    r = [self.db executeQueryWithFormat:@"SELECT * FROM TTShow_Recently_Watch_List ORDER BY id DESC LIMIT 0, %d", topCount];
    
	NSMutableArray *list = [NSMutableArray arrayWithCapacity:20];
	while(r.next)
    {
        TTShowFollowRoomStar *roomStar = [[TTShowFollowRoomStar alloc] init];
        roomStar.roomID = [[r stringForColumn:@"roomid"] integerValue];
        roomStar.live = [[r stringForColumn:@"live"] boolValue];
        roomStar.timestamp = [[r stringForColumn:@"timestamp"] longLongValue];
        roomStar.xy_star_id = [[r stringForColumn:@"xy_star_id"] integerValue];
        roomStar.starID = [[r stringForColumn:@"starid"] integerValue];
        roomStar.bean_count_total = [[r stringForColumn:@"bean_count_total"] longLongValue];
        roomStar.nick_name = [r stringForColumn:@"nick_name"];
        roomStar.pic = [r stringForColumn:@"pic"];
        [list addObject:roomStar];
	}
	return list;
}

- (BOOL)existRecentWatchWithStar:(NSInteger)_starID
{
    MMFMResultSet *r = nil;
    NSInteger count = 0;
    r = [self.db executeQueryWithFormat:@"SELECT COUNT(*) FROM TTShow_Recently_Watch_List WHERE starid=%d", _starID];
    
	while(r.next)
    {
        count = [r intForColumnIndex:0];
	}
	return count != 0;
}

- (BOOL)delRecentWatchWithStar:(NSInteger)_starID
{
    return [self.db executeUpdateWithFormat:@"DELETE FROM TTShow_Recently_Watch_List Where starid=%d", _starID];
}

#pragma mark friend

- (BOOL)addFriendMessage:(FriendMessage *)message
{
    NSDictionary* dict = [message toDictionary];
    assert(dict);
    NSMutableDictionary *dbDict = [[NSMutableDictionary alloc] initWithDictionary:dict];
    [dbDict removeObjectForKey:@"id"];
    BOOL succ = [self.db insertTable:@"friend_message" withDictionary:dbDict];
    
    return succ;
}

- (NSArray *)getFriendMessageList:(NSInteger)uid withFriendID:(NSInteger)fid withCount:(NSInteger)count withOffset:(NSInteger)offset {
    MMFMResultSet *r = nil;
    r = [self.db executeQueryWithFormat:@"SELECT * FROM friend_message WHERE uid = %d AND fid = %d ORDER BY timestamp DESC LIMIT %d OFFSET %d", uid, fid, count, offset];
    
    NSMutableArray *list = [[NSMutableArray alloc] initWithCapacity:0];
    while (r.next) {
        FriendMessage *message = [[FriendMessage alloc] init];
        message.messageID = [r intForColumn:@"id"];;
        message.uid = [r intForColumn:@"uid"];
        message.fid = [r intForColumn:@"fid"];
        message.msg = [r stringForColumn:@"msg"];
        message.sendStatus = [r intForColumn:@"send_status"];
        message.timestamp = [r longLongIntForColumn:@"timestamp"];
        [list addObject:message];
    }
    return list;
}

- (long long int)getLatestFriendMessageTime:(NSInteger)uid withFriendID:(NSInteger)fid
{
    MMFMResultSet *r = nil;
    r = [self.db executeQueryWithFormat:@"SELECT timestamp FROM friend_message WHERE uid = %d AND fid = %d  ORDER BY timestamp DESC LIMIT 1", uid, fid];
    if (r.next) {
        return [r longLongIntForColumn:@"timestamp"];
    }
    return [[NSDate date] timeIntervalSince1970] * 1000;
}

- (NSInteger)getFriendMessageID:(FriendMessage *)message
{
    MMFMResultSet *r = nil;
    r = [self.db executeQueryWithFormat:@"SELECT id FROM friend_message WHERE uid = %d AND fid = %d AND message = %d AND timestamp = %d"
         , message.uid, message.fid, message.msg, message.timestamp];
    if (r.next) {
        return [r intForColumn:@"id"];
    }
    return -1;
}
- (BOOL)updateMessageStatus:(FriendMessage *)message
{
    return [self.db executeUpdateWithFormat:@"UPDATE friend_message SET send_status = %d, timestamp = %d WHERE id = %d"
            , message.sendStatus, message.timestamp, message.messageID];
    
}

- (BOOL)delteMessage:(NSInteger)messageID
{
    return [self.db executeUpdateWithFormat:@"DELETE FROM friend_message WHERE id = %d", messageID];
}
- (BOOL)clearFriendMessages:(NSInteger)uid withFriendID:(NSInteger)fid
{
    return [self.db executeUpdateWithFormat:@"DELETE FROM friend_message WHERE uid = %d AND fid = %d", uid, fid];
}

#pragma mark group
- (long long int)getLatestGroupMessageTime:(NSInteger)uid withGroupID:(NSInteger)gid
{
    MMFMResultSet *r = nil;
    r = [self.db executeQueryWithFormat:@"SELECT timestamp FROM group_message WHERE uid = %d AND gid = %d  ORDER BY timestamp DESC LIMIT 1", uid, gid];
    if (r.next) {
        return [r longLongIntForColumn:@"timestamp"];
    }
    return (long long int) [[NSDate date] timeIntervalSince1970] * 1000;
}

- (long long int)getLatestUserGroupsMessageTime:(NSInteger)uid;
{
    MMFMResultSet *r = nil;
    r = [self.db executeQueryWithFormat:@"SELECT timestamp FROM group_message WHERE uid = %d ORDER BY timestamp DESC LIMIT 1", uid];
    if (r.next) {
        return [r longLongIntForColumn:@"timestamp"];
    }
    return 1;
}

- (BOOL)addGroupMessage:(GroupMessage *)message
{
    NSMutableDictionary* dict = [message parse2Dict];
    assert(dict);
    
    return [self.db insertTable:@"group_message" withDictionary:dict];
}

- (BOOL)addGroupMessageList:(NSArray *)messageList
{
    for (GroupMessage* message in messageList) {
        [self addGroupMessage:message];
    }
    return true;
}

- (NSArray *)getGroupmessageList:(NSInteger)uid withGroupID:(NSInteger)gid withCount:(NSInteger)count withOffset:(NSInteger)offset
{
    MMFMResultSet *r = nil;
    r = [self.db executeQueryWithFormat:@"SELECT * FROM group_message WHERE uid = %d AND gid = %d ORDER BY timestamp DESC LIMIT %d OFFSET %d", uid, gid, count, offset];
    
    NSMutableArray *list = [[NSMutableArray alloc] initWithCapacity:0];
    while (r.next) {
        GroupMessage *message = [[GroupMessage alloc] init];
        message.messageID = [r intForColumn:@"id"];
        message.gid = [r intForColumn:@"gid"];
        message.uid = [r intForColumn:@"uid"];
        message.type = [r intForColumn:@"type"];
        message.groupName = [r stringForColumn:@"group_name"];
        message.fromID = [r intForColumn:@"fid"];
        message.fromName = [r stringForColumn:@"from_name"];
        message.fromPic = [r stringForColumn:@"from_pic"];
        message.spendCoins = [r intForColumn:@"spend_coins"];
        message.msg = [r stringForColumn:@"msg"];
        message.pic = [r stringForColumn:@"pic"];
        message.audioUrl = [r stringForColumn:@"audio_url"];
        message.seconds = [r intForColumn:@"seconds"];
        message.timestamp = [r longLongIntForColumn:@"timestamp"];
        message.audioReadStatus = [r intForColumn:@"read_status"];
        message.sendStatus = [r intForColumn:@"send_status"];
        message.bgColor = [r intForColumn:@"bg_color"];
        [list addObject:message];
    }
    return list;
}

- (BOOL)updateGroupMessageStatus:(GroupMessage *)message
{
    return [self.db executeUpdateWithFormat:@"UPDATE group_message SET send_status = %d, read_status = %d, timestamp = %d WHERE id = %d"
               , message.sendStatus, message.audioReadStatus, message.timestamp, message.messageID];
}

- (BOOL)clearGroupMessages:(NSInteger)uid withGroupID:(NSInteger)gid
{
    return [self.db executeUpdateWithFormat:@"DELETE FROM group_message WHERE uid = %d AND gid = %d", uid, gid];
}

- (BOOL)deleteGroupMessageNotInGroupIds:(NSInteger)uid withGroupIDs:(NSString *)gids
{
    return [self.db executeUpdateWithFormat:@"DELETE FROM group_message WHERE uid = %d AND gid NOT IN (%@)", uid, gids];
}

- (BOOL)updateGroupName:(NSInteger)uid withGroupID:(NSInteger)gid withGroupName:(NSString *)groupName
{
    return [self.db executeUpdateWithFormat:@"UPDATE group_message SET group_name = %@ WHERE uid = %d AND gid = %d"
                      , groupName, uid, gid];
}

#pragma mark conversation

- (BOOL)addConversation:(Conversation*)conversation
{
    NSMutableDictionary* dict = [conversation parse2Dict];
    assert(dict);
    
    return [self.db insertTable:@"conversation" withDictionary:dict];
}

- (NSMutableArray *)getConversationList:(NSInteger)uid withCount:(NSInteger)count withOffset:(NSInteger)offset
{
    MMFMResultSet *r = nil;
    r = [self.db executeQueryWithFormat:@"SELECT * FROM conversation WHERE uid = %d ORDER BY timestamp DESC LIMIT %d OFFSET %d", uid, count, offset];
    
    NSMutableArray *list = [[NSMutableArray alloc] initWithCapacity:0];
    while (r.next) {
        Conversation *conversation = [[Conversation alloc] init];
        conversation.cid = [r intForColumn:@"cid"];
        conversation.uid = [r intForColumn:@"uid"];
        conversation.fid = [r intForColumn:@"fid"];
        conversation.type = [r intForColumn:@"type"];
        conversation.groupName = [r stringForColumn:@"group_name"];
        conversation.fromName = [r stringForColumn:@"from_name"];
        conversation.msg = [r stringForColumn:@"msg"];
        conversation.pic = [r stringForColumn:@"pic"];
        conversation.audioUrl = [r stringForColumn:@"audio_url"];
        conversation.seconds = [r intForColumn:@"seconds"];
        conversation.timestamp = [r longLongIntForColumn:@"timestamp"];
        conversation.unReadCount = [r intForColumn:@"un_read_count"];
        [list addObject:conversation];
    }
    return list;
}

- (BOOL)clearConversationUnreadCount:(NSInteger)uid withConversationID:(NSInteger)cid
{
    return [self.db executeUpdateWithFormat:@"UPDATE conversation SET un_read_count = 0 WHERE uid = %d AND cid = %d", uid, cid];
}

- (BOOL)clearAllConversationUnreadCount:(NSInteger)uid
{
    return [self.db executeUpdateWithFormat:@"UPDATE conversation SET un_read_count = 0 WHERE uid = %d", uid];
}

- (NSInteger)getConversationUnReadCount:(NSInteger)uid withConversationID:(NSInteger)cid
{
    MMFMResultSet *r = nil;
    r = [self.db executeQueryWithFormat:@"SELECT un_read_count FROM conversation WHERE uid = %d AND cid = %d", uid, cid];
    if (r.next) {
        return [r intForColumn:@"un_read_count"];
    }
    return 0;
}

- (NSInteger)getUserConversationsUnReadCount:(NSInteger)uid
{
    MMFMResultSet *r = nil;
    r = [self.db executeQueryWithFormat:@"SELECT sum(un_read_count) total_un_read_count FROM conversation WHERE uid = %d", uid];
    if (r.next) {
        return [r intForColumn:@"total_un_read_count"];
    }
    return 0;
}

- (BOOL)clearConversationLatestMessage:(NSInteger)uid withConversationID:(NSInteger)cid
{
    return [self.db executeUpdateWithFormat:@"UPDATE conversation SET msg = '' WHERE uid = %d AND cid = %d", uid, cid];
}

- (BOOL)deleteConversation:(NSInteger)uid withConversationID:(NSInteger)cid
{
    return [self.db executeUpdateWithFormat:@"DELETE FROM conversation WHERE uid = %d AND cid = %d", uid, cid];
}

- (BOOL)deleteConversationNotInConversationIDs:(NSInteger)uid withConversationIDs:(NSString *)cids
{
  return [self.db executeUpdateWithFormat:@"DELETE FROM conversation WHERE uid = %d AND cid NOT IN (%@)", uid, cids];
}

@end
