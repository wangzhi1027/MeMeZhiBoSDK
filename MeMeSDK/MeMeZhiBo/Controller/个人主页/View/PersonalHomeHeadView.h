//
//  PersonalHomeHeadView.h
//  memezhibo
//
//  Created by Xingai on 15/7/8.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PersonalHomeHeaderViewDelegate;

@interface PersonalHomeHeadView : UIView

@property(nonatomic, weak) IBOutlet UIImageView *headImage;
//@property(nonatomic, weak) IBOutlet UILabel *AddressLabel;
//@property(nonatomic, weak) IBOutlet UILabel *ConstellationLabel;
//@property(nonatomic, weak) IBOutlet UIView *bgView;
//@property(nonatomic, weak) IBOutlet UIImageView *sexImage;
//@property(nonatomic, weak) IBOutlet NSLayoutConstraint *widht;
@property (weak, nonatomic) IBOutlet UIImageView *starLevelmage;
@property (weak, nonatomic) IBOutlet UIImageView *userLevelImage;
@property (weak, nonatomic) IBOutlet UILabel *starLevelLabel;
@property (weak, nonatomic) IBOutlet UIButton *cancelWatchAnchorBtn;
@property (weak, nonatomic) IBOutlet UIButton *addFriendsBtn;
@property (weak, nonatomic) IBOutlet UIView *watchAndAddFriendsBtnBgView;

@property (nonatomic, weak) id<PersonalHomeHeaderViewDelegate> delegate;

@end

@protocol PersonalHomeHeaderViewDelegate <NSObject>

- (void)cancelWatchBtnTapped:(UIButton *)sender  headerView:(PersonalHomeHeadView *)headerView;
- (void)addFriendsBtnTapped:(UIButton *)sender headerView:(PersonalHomeHeadView *)headerView;

@end