//
//  TTShowDatabase.m
//  TTShow
//
//  Created by twb on 13-10-16.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import "TTShowDatabase.h"

@implementation DBException

+ (DBException *)dbExceptionWithErrorCode:(int) code andMessage:(NSString *) message
{
	return [[DBException alloc] initWithErrorCode:(int) code
										andMessage:(NSString *) message];
}

- (id)initWithErrorCode:(int)code
			  andMessage:(NSString *)message
{
	self = [super initWithName:@"DBException"
						reason:[NSString stringWithFormat:@"Database Error: code = %d, message = %@",
								code,
								message]
					  userInfo:nil];
	return self;
}

@end

@implementation MMFMResultSet (TTShowDatabase)

- (int)singleRowAsInt;
{
	assert(self.next);
	assert(self.columnCount > 0);
	return [self intForColumnIndex:0];
}

- (NSMutableArray *)singleRowAsArray
{
	NSMutableArray *arr = nil;
	if(self.next)
    {
		int n = self.columnCount;
		arr = [NSMutableArray arrayWithCapacity:n];
		for(int i = 0; i < n; ++i)
        {
            [arr addObject:[self objectForColumnIndex:i]];
        }
	}
	return arr;
}

- (NSMutableDictionary *)singleRowAsDictionary
{
	return self.next ? (NSMutableDictionary *) self.resultDictionary : nil;
}

//- (Pair *)resultPairList
//{
//	Pair *p = [Pair listWithSize:self.columnCount];
//	for(int i = 0; i < self.columnCount; ++i)
//    {
//		[p set:i value:[self objectForColumnIndex:i]];
//	}
//	return p;
//}

@end

@implementation MMFMDatabase (TTShowDatabase)

#pragma mark - SQLite Operations

- (BOOL)createTable:(NSString *) name withColumns:(NSArray *) columns
{
	BOOL succ = [self executeUpdate:[NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (%@)",
									 name, [columns componentsJoinedByString:@","]]];
	if(!succ)
    {
	}
	return succ;
}

- (int)getSqliteVerion
{
	return [[self executeQuery:@"PRAGMA user_version"] singleRowAsInt];
}

- (void)saveSqliteVersion:(int) ver
{
	[self executeUpdate:[NSString stringWithFormat:@"PRAGMA user_version = %d", ver]];
}

- (BOOL)insertTable:(NSString *) tableName withDictionary:(NSDictionary *) dict
{
	assert(tableName);
	if(dict.count == 0)
    {
        return NO;
    }
    
	NSArray *fields = dict.allKeys;
	NSMutableArray *values = [NSMutableArray arrayWithCapacity:fields.count];
	NSMutableArray *qms = [NSMutableArray arrayWithCapacity:fields.count];
	for(NSString *s in fields)
    {
		[values addObject:[dict objectForKey:s]];
		[qms addObject:@"?"];
	}
    
	NSString *sql = [NSString stringWithFormat:@"INSERT OR REPLACE INTO %@(%@) VALUES(%@)",
					 tableName,
					 [fields componentsJoinedByString:@","],
					 [qms componentsJoinedByString:@","]];
	return [self executeUpdate:sql withArgumentsInArray:values];
}

- (BOOL)upsertTable:(NSString *) tableName
     withDictionary:(NSDictionary *) dict
            idField:(NSString *) idField
{
	BOOL succ = [self insertTable:tableName withDictionary:dict];
	if(!succ)
    {
		NSString *idValue = [dict objectForKey:idField];
		succ = [self updateTable:tableName withDictionary:dict whereAndArgs:[NSString stringWithFormat:@"%@ = ?", idField], idValue, nil];
	}
	return succ;
}

- (BOOL)updateTable:(NSString *) tableName
     withDictionary:(NSDictionary *) dict
       whereAndArgs:(NSString *) where, ...
{
	assert(tableName);
	if(dict.count == 0)
		return false;
	NSArray *fields = dict.allKeys;
	NSMutableArray *updates = [NSMutableArray arrayWithCapacity:fields.count];
	NSMutableArray *values = [NSMutableArray arrayWithCapacity:fields.count];
	for(NSString *s in fields)
    {
		[updates addObject:[NSString stringWithFormat:@"%@ = ?", s]];
		[values addObject:[dict objectForKey:s]];
	}
    
	NSMutableString *sql = [NSMutableString stringWithFormat:@"UPDATE %@ SET %@",
							tableName,
							[updates componentsJoinedByString:@","]];
	if(where)
    {
		[sql appendFormat:@" WHERE %@", where];
		va_list args;
		va_start(args, where);
		id arg = va_arg(args, id);
		while (arg)
        {
			[values addObject:arg];
			arg = va_arg(args, id);
		}
		va_end(args);
	}
	return [self executeUpdate:sql withArgumentsInArray:values];
}

- (void)endTransaction:(BOOL)succ
{
	if(succ)
		[self commit];
	else
		[self rollback];
}

@end

@implementation TTShowDatabase

- (id)initWithPath:(NSString *)inPath
{
	self = [super initWithPath:inPath];
	if(self) {
		_version = 1;
		_isNewDB = NO;
	}
	return self;
}

- (BOOL)open
{
    
#if 0
    [FileUtils removeFile:_databasePath];
#endif
    
	BOOL opened = [super open];
	if(opened && self.isNewDB)
    {
		[self onCreateDatabase:_version];
		[self saveSqliteVersion:_version];
	}
	return opened;
}

- (void)onCreateDatabase:(int)ver
{
	[self createTables];
}

#pragma mark - TTShow Tables

- (void)createTables
{
	//System tables: T_System_Configuration.
	[self createTable:@"TTShow_Recently_Watch_List" withColumns:@[@"id INTEGER PRIMARY KEY AUTOINCREMENT",
                                                                  @"roomid TEXT",
                                                                  @"live TEXT",
                                                                  @"timestamp TEXT",
                                                                  @"xy_star_id TEXT",
                                                                  @"starid TEXT",
                                                                  @"bean_count_total TEXT",
                                                                  @"nick_name TEXT",
                                                                  @"pic TEXT"]];
    [self createTable:@"TTShow_Photo_Praise_Record" withColumns:@[@"id INTEGER PRIMARY KEY AUTOINCREMENT",
                                                                  @"title TEXT",
                                                                  @"url TEXT"]];
    [self createTable:@"TTShow_Friend_Chat_List" withColumns:@[@"id INTEGER PRIMARY KEY AUTOINCREMENT",
                                                                  @"myid TEXT",
                                                                  @"friendid TEXT",
                                                                  @"words TEXT",
                                                                  @"dir TEXT",
                                                                  @"timestamp TEXT",
                                                                  @"pic TEXT"]];
    
    [self createTable:@"friend_message" withColumns:@[@"id INTEGER PRIMARY KEY AUTOINCREMENT",
                                                               @"uid INTEGER",
                                                               @"fid INTEGER",
                                                               @"msg TEXT",
                                                               @"send_status INTEGER",
                                                               @"timestamp integer"]];
    
    [self createTable:@"group_message" withColumns:@[@"id INTEGER PRIMARY KEY AUTOINCREMENT",
                                                                  @"uid INTEGER",
                                                                  @"gid INTEGER",
                                                                  @"fid INTEGER",
                                                                  @"type INTEGER",
                                                                  @"group_name TEXT",
                                                                  @"from_name TEXT",
                                                                  @"from_pic TEXT",
                                                     @"spend_coins INTEGER",
                                                     @"location TEXT",
                                                     @"msg TEXT",
                                                     @"pic TEXT",
                                                     @"audio_url TEXT",
                                                     @"seconds INTEGER",
                                                     @"send_status INTEGER",
                                                     @"read_status INTEGER",
                                                     @"bg_color INTEGER",
                                                     @"timestamp INTEGER"]];
    
    [self createTable:@"conversation" withColumns:@[@"cid INTEGER",//好友ID或者小窝ID
                                                     @"uid INTEGER",
                                                     @"fid INTEGER",//消息发送者ID
                                                     @"group_name TEXT",
                                                     @"from_name TEXT",
                                                     @"type INTEGER",
                                                     @"msg TEXT",
                                                    @"pic TEXT",
                                                    @"audio_url TEXT",
                                                    @"seconds INTEGER",
                                                    @"timestamp INTEGER",
                                                    @"un_read_count INTEGER",
                                                    @"constraint pk primary key (cid,uid)"]];
    
}

@end

@implementation NSMutableDictionary (RecordValue)

- (id) objectForKey:(id)aKey withNullValue:(id) value
{
	id obj = [self objectForKey:aKey];
	return obj == nil || [obj isKindOfClass:[NSNull class]] ? value : obj;
}

- (id) objectRemovedForKey:(id) key
{
	NSObject *obj = [self objectForKey:key];
	if(obj)
    {
		[self removeObjectForKey:key];
	}
	return obj;
}

- (NSString *) createTime
{
	return [self objectForKey:@"create_time"];
}

- (NSString *) createUserID
{
	return [self objectForKey:@"create_user_id"];
}

- (NSString *) modifyTime
{
	return [self objectForKey:@"modify_time"];
}

- (NSString *) modifyUserID
{
	return [self objectForKey:@"modify_user_id"];
}

- (void) setCreateTime:(NSString *) time
{
	[self setObject:time forKey:@"create_time"];
}

- (void) setCreateUserID:(NSString *) userID
{
	[self setObject:userID forKey:@"create_user_id"];
}

- (void) setModifyTime:(NSString *) time
{
	[self setObject:time forKey:@"modify_time"];
}

- (void) setModifyUserID:(NSString *) userID
{
	[self setObject:userID forKey:@"modify_user_id"];
}

@end
