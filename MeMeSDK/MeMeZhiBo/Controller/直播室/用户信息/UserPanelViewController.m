//
//  UserPanelViewController.m
//  memezhibo
//
//  Created by Xingai on 15/6/23.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "UserPanelViewController.h"
#import "RankListTableViewCell.h"
#import "NSBundle+SDK.h"


@interface UserPanelViewController ()

@end

@implementation UserPanelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTitles];
    [self setupTable];
    self.view.layer.masksToBounds = YES;
    self.view.layer.cornerRadius = 8;
    self.view.alpha = 0.9;
}

-(void)setupTitles
{
    if (self.flag==1) {
        self.titles = @[@"送礼给他",@"设为嘉宾",@"抱下麦序",@"踢出小窝",@"个人主页"];
    }else if(self.flag==2){
        self.titles = @[@"送礼给他",@"抱下麦序",@"踢出小窝",@"个人主页"];
    }else if(self.flag==3){
        self.titles = @[@"送礼给他",@"个人主页"];
    }else{
        self.titles = @[@"与他聊天",@"悄悄@他",@"送礼给他",@"禁言",@"恢复禁言"];
    }
}

-(void)setupTable
{
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 260, 289) style:UITableViewStylePlain];
    self.userPanelTable = table;
    self.userPanelTable.dataSource = self;
    self.userPanelTable.delegate = self;
    self.userPanelTable.scrollEnabled = NO;
    self.userPanelTable.backgroundColor = kRGB(43, 41, 43);
    self.userPanelTable.tableFooterView = [[UIView alloc] init];
    
    [self.view addSubview:self.userPanelTable];
    
    [self setupHeadView];
}

-(void)setupHeadView
{
    self.headView = [[RoomUserPanelHeadView alloc] init];
    self.headView.frame = CGRectMake(0, 0, 260, 69);
    self.userPanelTable.tableHeaderView = self.headView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titles.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RankListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RankListTableViewCellID"];
    if (cell == nil)
    {
        cell = [[[NSBundle SDKResourcesBundle] loadNibNamed:@"RankListTableViewCell" owner:self options:nil] lastObject];
    }
    cell.RankProjectImage.image = kImageNamed(self.titles[indexPath.row]);
    
    cell.label.text = self.titles[indexPath.row];
    
    cell.label.textColor = kRGBA(255, 255, 255, 0.8);
    
    cell.backgroundColor = kRGB(43, 41, 43);
    
    cell.RankingImage.hidden = YES;
    cell.jtBtn.hidden = YES;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.userPanelTable deselectRowAtIndexPath:indexPath animated:YES];
    [self.delegate userpaneldidSelectRowAtIndexPath:indexPath user:self.currentUser];
}

- (void)retrieveUserInfo
{
    if (self.userID == 0)
    {
        return;
    }
    
    [self.dataManager.remote retrieveUserInfo:self.userID completion:^(TTShowUser *user, NSError *error) {
        if (error == nil)
        {
            self.currentUser = user;
            self.headView.name.text = [user.nick_name stringByUnescapingFromHTML];
            
            //用户等级
            Finance *finance = [[Finance alloc] initWithAttributes:user.finance];
            
            NSInteger userLevel= [self.dataManager wealthLevel:finance.coin_spend_total];
            
            NSString *weatherLevlString = [[DataGlobalKit sharedInstance] wealthImageString:userLevel];
            self.headView.lavelImage.image = [UIImage sd_animatedGIFNamed:weatherLevlString];
                        
            //用户头像
            [[UIGlobalKit sharedInstance] setImageAnimationLoading:self.headView.headImage WithSource:user.pic];
        }
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
