//
//  AndWhoListView.h
//  memezhibo
//
//  Created by Xingai on 15/6/16.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AndWhoListViewDelegate <NSObject>

-(void)didSelectRowAtIndexPath:(NSIndexPath*)indexPath;

@end


@interface AndWhoListView : UIView<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong) UITableView *andWhoListTable;
@property(nonatomic, strong) NSMutableArray *andWhoList;
@property(nonatomic, weak) id<AndWhoListViewDelegate>delegate;

-(void)reloadTable;

@end
