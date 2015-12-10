//
//  UIView+ShareInstance.h
//  TTShow
//
//  Created by twb on 13-8-2.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ShareInstance)

- (UIView *)viewFromNib:(NSString *)nib;
- (UIView *)viewFromNib:(NSString *)nib withOrigin:(CGPoint)point;

- (void)viewMoveDownward:(CGFloat)dy;
- (void)viewMoveToSuitStatusBar;

- (void)viewOriginY:(CGFloat)y;
- (void)viewOriginYMinus:(CGFloat)dy;
- (void)viewOriginYPlus:(CGFloat)dy;

- (void)viewSizeHeight:(CGFloat)height;
- (void)viewSizeMinusHeight:(CGFloat)dHeight;
- (void)viewSizePlusHeight:(CGFloat)dHeight;

@end
