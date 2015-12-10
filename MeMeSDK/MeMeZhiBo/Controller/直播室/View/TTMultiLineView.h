//
//  TTMultiLineView.h
//  TTShow
//
//  Created by twb on 13-7-8.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTLineView.h"

@interface TTMultiLineView : TTLineView


@property(nonatomic,strong) UIView *bgView;
/**
 *  通过外部传递过来的视图字典集，动态生成多行视图。
 *
 *  @param views 视图字典集
 *
 *  @return 视图
 */
- (id)initWithSubViews:(NSMutableArray *)views;
- (id)initWithSubViewsRight:(NSMutableArray *)views;
- (id)initWithSubViewsNest:(NSMutableArray *)views;


@end
