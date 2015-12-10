//
//  BaseViewController.h
//  TTShow
//
//  Created by twb on 13-9-16.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "noDataViewController.h"

@interface BaseViewController : UIViewController<UIGestureRecognizerDelegate>

@property(nonatomic, strong) UIView *nav;
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UIButton *backBtn;
@property(nonatomic, strong) UIButton *backLabel;
@property(nonatomic, strong) UIButton *rightBtn;
@property(nonatomic, strong) noDataViewController *noDataView;
@property (nonatomic, strong) NSString *navTitle;


- (void)viewDidReload;

- (void)showNoContentTip:(NSString *)tip;
- (void)hideNoContentTip;

- (void)showProgress:(NSString *)tip inView:(UIView *)view animated:(BOOL)animated;
- (void)showProgress:(NSString *)tip animated:(BOOL)animated;
- (void)hideProgressInView:(UIView *)view animated:(BOOL)animated;
- (void)hideProgressWithAnimated:(BOOL)animated;
- (void)setupNavView;
- (void)setupLeftBtnAction:(SEL)action;
- (void)setupRightBtnAction:(SEL)action;

- (void)showChargeTip;

@end
