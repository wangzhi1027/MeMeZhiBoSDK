//
//  BaseDataAccess.h
//  TTShow
//
//  Created by twb on 13-10-16.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTShowDatabase.h"

@interface BaseDataAccess : NSObject

@property (atomic, assign) MMFMDatabase *db;

@end
