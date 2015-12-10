//
//  UIViewController+ShareInstance.h
//  TTShow
//
//  Created by twb on 13-6-9.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTShowUIManager.h"

@class FilterCondition;

@interface UIViewController (ShareInstance)

- (TTShowUIManager *)uiManager;
- (TTShowDataManager *)dataManager;
- (TTShowUser *)me;
- (FilterCondition *)filter;
- (NSString *)hlsMediaSecretStringByRoomID:(NSInteger)roomid byTimeStamp:(NSString *)timeStamp;
- (NSString *)rtmpMediaSecretStringByRoomID:(NSInteger)roomid byTimeStamp:(NSString *)timeStamp;

- (UIView *)viewFromNib:(NSString *)nib;
- (UIView *)viewFromNib:(NSString *)nib withOrigin:(CGPoint)point;
- (void)showProgressWithLabel:(NSString *)text task:(void (^)(void))task completion:(void (^)(void))completion;
- (void)showProgressWithLabelWithStatus:(NSString *)text task:(int (^)(void))task completion:(void (^)(int))completion;

@end
