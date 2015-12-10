//
//  FileUtils.m
//  TTShow
//
//  Created by twb on 13-10-16.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import "FileUtils.h"
#import "GlobalStatics.h"

@implementation FileUtils

+ (NSString *) pathOfDocumentDir
{
	return [GlobalStatics DOCUMENT_PATH];
}

+ (NSString *) pathForDocumentFiles:(NSString *) path
{
	return [[self pathOfDocumentDir] stringByAppendingPathComponent:path];
}

+ (BOOL) makeDirectoryAtPath:(NSString *) path
{
	return [[NSFileManager defaultManager] createDirectoryAtPath:path
									 withIntermediateDirectories:NO
													  attributes:nil
														   error:nil];
}

+ (BOOL) fileExistsAtPath:(NSString *) path
{
	return [[NSFileManager defaultManager] fileExistsAtPath:path];
}

+ (BOOL) removeFile:(NSString *) file
{
	return [[NSFileManager defaultManager] removeItemAtPath:file error:nil];
}

@end
