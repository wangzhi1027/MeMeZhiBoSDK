//
//  PersonalHomePageViewController.h
//  memezhibo
//
//  Created by Xingai on 15/7/8.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "BaseViewController.h"
#import "VideoTitleView.h"
#import "TTShowRoom.h"
#import "PSTCollectionView.h"
#import "PersonalHomeCell.h"
#import "TTShowStarPhoto.h"
#import "TTShowUserNew.h"
#import "SegmentBtnView.h"
#import "DaImageNavView.h"
#import "DaImageTabView.h"
#import "AnchorHederView.h"
#import "CHTCollectionViewWaterfallLayout.h"
#import "CHTCollectionViewWaterfallFooter.h"
#import "GuanzhuDelegate.h"

@interface PersonalHomePageViewController : BaseViewController<segmentBtnClickDelegate, GuanzhuDelegate>
{
    CGFloat lastScale;
}

@property(nonatomic, weak) id<GuanzhuDelegate>delegate;
//@property (nonatomic, strong) CHTCollectionViewWaterfallHeader *headView;
//@property (nonatomic, strong) CHTCollectionViewWaterfallFooter *footerView;
@property (nonatomic, strong) UIImageView *footerImage;
@property (nonatomic, strong) TTShowRoom *currentRoom;
@property (nonatomic, strong) TTShowUserNew *currentUser;
@property (nonatomic, strong) DaImageNavView *daNav;
@property (nonatomic, strong) DaImageTabView *daTab;

@property (nonatomic, strong) NSMutableArray *imageList;
//@property (nonatomic, strong) UICollectionView *personalCollection;
@property (nonatomic, strong) UICollectionView *photoWallCollectionView;
@property (nonatomic, strong) CHTCollectionViewWaterfallLayout *layout;
@property (nonatomic, strong) VideoTitleView *titleView;
@property (nonatomic, assign) BOOL isFriend;
@property (nonatomic, assign) BOOL isAnchor;
@property (nonatomic, strong) NSMutableArray *sizeArr;
@property (nonatomic, strong) UIView *segmentView;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, assign) BOOL isFollowStar;

@property (nonatomic, assign) NSInteger flag; // 从明星排行进入到直播间后，再次进入个人主页

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIImageView *daImage;
@property (nonatomic, strong) UIScrollView *scroll;
@property (nonatomic, assign) BOOL isNavOn;

@property (nonatomic, strong) AnchorHederView *anchorHeaderView;
@property (nonatomic, strong) UIScrollView *bgScrollView;

@end
