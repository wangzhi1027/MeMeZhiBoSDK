//
//  AnchorTableViewCell.h
//  memezhibo
//
//  Created by Xingai on 15/5/22.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainCell.h"
#import "TTShowRecommendation.h"

typedef NS_ENUM(NSInteger, MainCellTag)
{
    kMainCellMaxImage = 1000,
    kMainCellMinImageOno,
    kMainCellMinImageTo,
    kMainCellMinImageThree,
    kMainCellMinImageFour,
    kMainCellMinImageFive
};

typedef NS_ENUM(NSInteger, MainCellHintViewTag)
{
    kMainCellHintViewMaxImage = 1000,
    kMainCellHintViewMinImageOno,
    kMainCellHintViewMinImageTo,
    kMainCellHintViewMinImageThree,
    kMainCellHintViewMinImageFour,
    kMainCellHintViewMinImageFive
};

@protocol MainCellImageDelegate <NSObject>

- (void)doSelectRoomCell:(UITableViewCell *)cell tag:(NSInteger)tag;
- (void)tuijianListPush;

@end

@interface AnchorTableViewCell : UITableViewCell

@property (nonatomic,strong)  MainCell *RecommendedAnchorView1;
@property (nonatomic,strong)  MainCell *RecommendedAnchorView2;
@property (nonatomic,strong)  MainCell *RecommendedAnchorView3;
@property (nonatomic,strong)  MainCell *RecommendedAnchorView4;
@property (nonatomic,strong)  MainCell *RecommendedAnchorView5;
@property (nonatomic,strong)  MainCell *RecommendedAnchorView6;

@property (nonatomic,strong)  UIView *hintView1;
@property (nonatomic,strong)  UIView *hintView2;
@property (nonatomic,strong)  UIView *hintView3;
@property (nonatomic,strong)  UIView *hintView4;
@property (nonatomic,strong)  UIView *hintView5;
@property (nonatomic,strong)  UIView *hintView6;

@property (nonatomic,strong)  UIButton *TuijianViewPush;

@property (nonatomic, weak) id<MainCellImageDelegate> delegate;

- (void)setContentWithRecommendation1:(TTShowRecommendation *)recommendation1 recommendation2:(TTShowRecommendation *)recommendation2 recommendation3:(TTShowRecommendation *)recommendation3 recommendation4:(TTShowRecommendation *)recommendation4 recommendation5:(TTShowRecommendation *)recommendation5 recommendation6:(TTShowRecommendation *)recommendation6;
- (void)deselectCellWithAnimated:(BOOL)animated;
@end
