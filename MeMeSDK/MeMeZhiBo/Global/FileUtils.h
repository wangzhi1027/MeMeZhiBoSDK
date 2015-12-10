//
//  FileUtils.h
//  TTShow
//
//  Created by twb on 13-10-16.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileUtils : NSObject

+ (NSString *)pathOfDocumentDir;
+ (NSString *)pathForDocumentFiles:(NSString *)path;
+ (BOOL)makeDirectoryAtPath:(NSString *)path;
+ (BOOL)fileExistsAtPath:(NSString *)path;
+ (BOOL)removeFile:(NSString *)file;

@end
