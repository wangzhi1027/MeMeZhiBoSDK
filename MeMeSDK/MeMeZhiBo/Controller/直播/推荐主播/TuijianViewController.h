//
//  TuijianViewController.h
//  memezhibo
//
//  Created by Xingai on 15/6/24.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "BaseViewController.h"
#import "LoadMore.h"
#import "AllAnchorTableViewCell.h"

@interface TuijianViewController : BaseViewController<UIGestureRecognizerDelegate>

@property(nonatomic, assign) NSInteger page;
@property(nonatomic, strong) UITableView *tuijianListTable;
@property(nonatomic, strong) NSMutableArray *roomList;
@property(nonatomic, strong) LoadMore *loadMore;
@property(nonatomic, strong) UIRefreshControl *systemRefreshView;
@property(nonatomic, assign) BOOL isNoData;
@property(nonatomic, assign) BOOL isLoading;
@property (nonatomic, weak) AllAnchorTableViewCell *curSelectedCell;
@property(nonatomic, assign) NSInteger flag;

-(void)setupRemote:(BOOL)loadMore;

@end
