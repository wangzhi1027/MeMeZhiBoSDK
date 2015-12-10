//
//  RankListDetailsViewController.h
//  memezhibo
//
//  Created by Xingai on 15/6/2.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "BaseViewController.h"
#import "SegmentBtnView.h"
#import "TTShowUserRank.h"
#import "TTShowAnchorRank.h"


@interface RankListDetailsViewController : BaseViewController<segmentBtnClickDelegate,UIGestureRecognizerDelegate>

@property (nonatomic, strong) NSString *navTitle;

@property (nonatomic, strong) UITableView *rankListTable;

@property (nonatomic, strong) NSMutableArray *rankList;

@property (nonatomic, strong) UIRefreshControl *systemRefreshView;

@property (nonatomic, strong) NSArray *titles;

@property (nonatomic, assign) RichRankType rankType;

@property (nonatomic, strong) TTShowRoom *currentRoom;

@property (nonatomic, assign) UserRankType userRankType;

@property (nonatomic, assign) NSInteger flag;

@property (nonatomic, strong) UIView *segmentView;

@property (nonatomic, assign) NSInteger size;

@end
