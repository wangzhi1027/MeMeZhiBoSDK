//
//  AnchorHederView.h
//  memezhibo
//
//  Created by XIN on 15/10/22.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol AnchorHeaderViewDelegate;

@interface AnchorHederView : UIView

@property (weak, nonatomic) IBOutlet UIButton *photoWallBtn;
@property (weak, nonatomic) IBOutlet UIButton *profileBtn;
@property (weak, nonatomic) id<AnchorHeaderViewDelegate> delegate;

@end

@protocol AnchorHeaderViewDelegate <NSObject>

@required
- (void)photoWallBtnTapped:(UIButton *)btn ahchorHeaderView:(AnchorHederView *)headerView;
- (void)profileBtnTapped:(UIButton *)btn anchorHeaderView:(AnchorHederView *)headerView;

@end