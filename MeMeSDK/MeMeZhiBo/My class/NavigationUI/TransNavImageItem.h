//
//  TransNavImageItem.h
//  TTShow
//
//  Created by twb on 13-8-30.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ChatRoomNavigationItemType)
{
    kBackNavigationItem = 0,
    kFavorNavigationItem,
    kUnfavorNavigationItem,
    kChatRoomNavigationItemMax
};

@interface TransNavImageItem : UIButton

@property (nonatomic, assign) ChatRoomNavigationItemType currentType;

@end
