//
//  CaveolaeTableViewCell.h
//  memezhibo
//
//  Created by Xingai on 15/5/22.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainCell.h"
#import "TTShowXiaowoList.h"
#import "TTShowRoom.h"

typedef NS_ENUM(NSInteger, XiaowoMainCellTag)
{
    kMainCellImage1 = 1000,
    kMainCellImage2,
    kMainCellImage3,
    kMainCellImage4,
};

@protocol CaveoMainCellImageDelegate <NSObject>

- (void)doSelectCaveoCell:(UITableViewCell *)cell tag:(NSInteger)tag;

-(void)pushXinren;

@end


@interface CaveolaeTableViewCell : UITableViewCell

@property (nonatomic,strong)  MainCell *RecommendedAnchorView1;
@property (nonatomic,strong)  MainCell *RecommendedAnchorView2;
@property (nonatomic,strong)  MainCell *RecommendedAnchorView3;
@property (nonatomic,strong)  MainCell *RecommendedAnchorView4;
@property (nonatomic, weak) id<CaveoMainCellImageDelegate> delegate;


@property (nonatomic,strong)  UIView *hintView1;
@property (nonatomic,strong)  UIView *hintView2;
@property (nonatomic,strong)  UIView *hintView3;
@property (nonatomic,strong)  UIView *hintView4;

@property (nonatomic,strong)  UIButton *XiaowoViewPush;


- (void)deselectCellWithAnimated:(BOOL)animated;

- (void)setContentWithxinrenList1:(TTShowRoom *)xinrenList1 xinrenList2:(TTShowRoom *)xinrenList2 xinrenList3:(TTShowRoom *)xinrenList3 xinrenList4:(TTShowRoom *)xinrenList4;
@end
