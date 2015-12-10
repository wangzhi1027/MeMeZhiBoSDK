//
//  qudaoModel.h
//  memezhibo
//
//  Created by Xingai on 15/7/9.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface qudaoModel : NSObject
@property (assign, nonatomic) BOOL isJailBreak;
@property (assign, nonatomic) BOOL guanfangqudao;

- (id)initWithAttributes:(NSDictionary *)attributes;
@end
