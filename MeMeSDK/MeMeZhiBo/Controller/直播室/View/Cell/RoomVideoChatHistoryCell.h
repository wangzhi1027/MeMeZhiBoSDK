//
//  RoomVideoChatHistoryCell.h
//  TTShow
//
//  Created by twb on 13-6-6.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TTMultiLineView;

@interface RoomVideoChatHistoryCell : TableViewCell

- (void)addChatContent:(TTMultiLineView *)contentView;

@end
