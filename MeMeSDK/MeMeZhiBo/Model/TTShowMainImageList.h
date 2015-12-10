//
//  TTShowMainImageList.h
//  memezhibo
//
//  Created by Xingai on 15/5/27.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTShowMainImageList : NSObject

@property (nonatomic, strong) NSString *pic_url;
@property (nonatomic, strong) NSString *click_url;
@property (nonatomic, strong) NSString *title;

- (id)initWithAttributes:(NSDictionary *)attributes;

@end
