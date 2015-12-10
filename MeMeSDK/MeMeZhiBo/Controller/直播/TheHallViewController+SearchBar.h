//
//  TheHallViewController+SearchBar.h
//  memezhibo
//
//  Created by Xingai on 15/6/1.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "TheHallViewController.h"


@interface TheHallViewController (SearchBar)<UITextFieldDelegate,seachDelegate>

-(void)setSearchBarView;

-(void)reloadTable;

@end
