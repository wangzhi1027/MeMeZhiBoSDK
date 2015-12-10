//
//  TheHallViewController+Table.h
//  memezhibo
//
//  Created by Xingai on 15/5/22.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "TheHallViewController.h"
#import "AnchorTableViewCell.h"
#import "CaveolaeTableViewCell.h"
#import "AllAnchorTableViewCell.h"



@interface TheHallViewController (Table)<UITableViewDelegate,UITableViewDataSource,MainCellImageDelegate,CaveoMainCellImageDelegate,AllAnchorMainCellImageDelegate>

-(void)setupTheHallTable;

-(void)setupHitTable;

-(void)setupXiaowoTable;

@end
