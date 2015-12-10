//
//  GlobalKit.m
//  TTCX
//
//  Created by twb on 13-5-31.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import "GlobalKit.h"

@implementation GlobalKit

+ (instancetype)sharedInstance
{
	static id instance;
	
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		instance = [[[self class] alloc] init];
	});
	
	return instance;
}


@end
