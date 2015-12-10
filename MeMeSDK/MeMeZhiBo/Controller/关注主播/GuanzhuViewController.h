//
//  GuanzhuViewController.h
//  memezhibo
//
//  Created by Xingai on 15/6/25.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "BaseViewController.h"
#import "GuanzhuDelegate.h"

//@protocol GuanzhuDelegate <NSObject>
//
//-(void)guanzhuVideoBack:(TTShowRoom*)room;
//
//@end

@interface GuanzhuViewController : BaseViewController<UIGestureRecognizerDelegate>

@property(nonatomic, strong) UITableView *GuanzhuListTable;
@property(nonatomic, strong) NSMutableArray *roomList;
@property(nonatomic, strong) UIRefreshControl *systemRefreshView;
@property(nonatomic, assign) NSInteger flag;
@property(nonatomic, weak) id<GuanzhuDelegate>delegate;


@end


