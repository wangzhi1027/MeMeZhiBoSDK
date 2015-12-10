//
//  UserPanelViewController.h
//  memezhibo
//
//  Created by Xingai on 15/6/23.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "BaseViewController.h"
#import "RoomUserPanelHeadView.h"

@protocol UserpanelDelegate <NSObject>

-(void)userpaneldidSelectRowAtIndexPath:(NSIndexPath*)indexPath user:(TTShowUser *)user;

@end

@interface UserPanelViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *userPanelTable;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) TTShowUser *currentUser;
@property (nonatomic, assign) NSInteger userID;
@property (nonatomic, weak) id<UserpanelDelegate>delegate;
@property (nonatomic, strong) RoomUserPanelHeadView *headView;
@property (nonatomic, assign) NSInteger flag;

- (void)retrieveUserInfo;

@end
