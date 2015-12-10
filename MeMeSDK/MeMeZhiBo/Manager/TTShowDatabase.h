//
//  TTShowDatabase.h
//  TTShow
//
//  Created by twb on 13-10-16.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import "MMFMDatabase.h"
//#import "Pair.h"

/** Extension of FMDB's FMResultSet */
@interface MMFMResultSet (TTShowDatabase)

- (int)singleRowAsInt;
- (NSMutableArray *)singleRowAsArray;
- (NSMutableDictionary *)singleRowAsDictionary;
//- (Pair *)resultPairList;

@end

/** Database Exception including sqlite error code and message */
@interface DBException : NSException

+ (DBException *)dbExceptionWithErrorCode:(int)code andMessage:(NSString *) message;
- (id)initWithErrorCode:(int)code andMessage:(NSString *)message;

@end

@interface MMFMDatabase (TTShowDatabase)

- (BOOL)createTable:(NSString *) name withColumns:(NSArray *) columns;
- (BOOL)insertTable:(NSString *) tableName withDictionary:(NSDictionary *) dict;
- (BOOL)upsertTable:(NSString *) tableName withDictionary:(NSDictionary *) dict idField:(NSString *) idField;
- (BOOL)updateTable:(NSString *) tableName withDictionary:(NSDictionary *) dict whereAndArgs:(NSString *) where, ...;
- (void) endTransaction:(BOOL) succ;

@end

@interface TTShowDatabase : MMFMDatabase

@property (nonatomic, readonly) int version; //DB Version.
@property (nonatomic) BOOL isNewDB; // true if DB file is newly cerated.

- (id)initWithPath:(NSString *)inPath;
- (void)onCreateDatabase:(int)version;

@end

typedef NSMutableDictionary RecordValue;

@interface NSMutableDictionary (RecordValue)

- (id) objectForKey:(id)aKey withNullValue:(id) value;
- (id) objectRemovedForKey:(id) key;
- (NSString *) createTime;
- (NSString *) createUserID;
- (NSString *) modifyTime;
- (NSString *) modifyUserID;
- (void) setCreateTime:(NSString *) date;
- (void) setCreateUserID:(NSString *) userID;
- (void) setModifyTime:(NSString *) date;
- (void) setModifyUserID:(NSString *) userID;

@end
