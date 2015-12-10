//
//  RoomMyinfoViewController.h
//  memezhibo
//
//  Created by zhifeng on 15/6/19.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "BaseViewController.h"
#import "RoominfoHead.h"

@protocol MyInfoDelegate <NSObject>

-(void)MyIndoDidSelectRowAtIndexPath:(NSIndexPath *)indexPath;
-(void)ModifyDidSelect;

@end


@interface RoomMyinfoViewController : BaseViewController

@property (nonatomic, strong) UITableView *myInfoTable;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, weak) id<MyInfoDelegate>delegate;
@property (nonatomic, assign) BOOL isModify;
@property (nonatomic, strong) UITextField *field;
@property (nonatomic, strong) RoominfoHead *infohead;

@end
