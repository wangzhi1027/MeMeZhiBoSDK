//
//  TTShowXiaowoList.h
//  memezhibo
//
//  Created by Xingai on 15/5/25.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTShowXiaowoList : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *pic;
@property (nonatomic, assign) NSInteger m_count;

- (id)initWithAttributes:(NSDictionary *)attributes;

@end
