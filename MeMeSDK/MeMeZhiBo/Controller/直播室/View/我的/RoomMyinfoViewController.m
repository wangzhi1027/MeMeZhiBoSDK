//
//  RoomMyinfoViewController.m
//  memezhibo
//
//  Created by zhifeng on 15/6/19.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "RoomMyinfoViewController.h"
#import "NSBundle+SDK.h"
#import "RankListTableViewCell.h"
#import "TTShowRemote+UserInfo.h"

@interface RoomMyinfoViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation RoomMyinfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTable];
    // Do any additional setup after loading the view from its nib.
}

-(void)setupTable
{
    [self setupTitles];
    
    self.view.layer.masksToBounds = YES;
    self.view.layer.cornerRadius = 8;
    
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 260, 333) style:UITableViewStylePlain];
    self.myInfoTable = table;
    self.myInfoTable.dataSource = self;
    self.myInfoTable.delegate = self;
    self.myInfoTable.scrollEnabled = NO;
    self.myInfoTable.backgroundColor = kRGB(43, 41, 43);
    
    [self.view addSubview:self.myInfoTable];
    
    
    self.infohead = [[RoominfoHead alloc] init];
    self.infohead.backgroundColor = kRGB(52, 46, 48);
    self.infohead.frame = CGRectMake(0, 0, 260, 69);
    [[UIGlobalKit sharedInstance] setImageAnimationLoading:self.infohead.headImage WithSource:self.me.pic];
    self.infohead.nameLabel.text = [self.me.nick_name stringByUnescapingFromHTML];
    
    TTShowUser *user = [TTShowUser unarchiveUser];
    Finance *finance = [[Finance alloc] initWithAttributes:user.finance];
    
    NSInteger userLevel= [self.dataManager wealthLevel:finance.coin_spend_total];
    
    [self.infohead setLevelMyImage:userLevel];
//    [self.infohead setMyVipImageType:self.me.vip];
    [self.infohead setVipImageType:self.me.vip];
    self.myInfoTable.tableHeaderView = self.infohead;
}

-(void)setupTitles
{
    self.titles = @[@"充值柠檬",@"修改昵称",@"我的关注",@"退出房间"];
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

    
    if (self.isModify) {
        switch (indexPath.row) {
            case 0:
            {
                cell.label.text = [self.me.nick_name stringByUnescapingFromHTML];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
                break;
            case 1:
            {
                cell.label.text = @"";
                 self.field = [[UITextField alloc] initWithFrame:CGRectMake(64, 8, 100, 30)];
                self.field.placeholder = @"修改昵称";
                [self.field setValue:[UIColor colorWithRed:255.0f green:255.0f blue:255.0f alpha:0.6] forKeyPath:@"_placeholderLabel.textColor"];
                [self.field setValue:[UIFont systemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
                
                self.field.textColor = kRGBA(255, 255, 255 ,0.8);
                [cell.contentView addSubview:self.field];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
                break;
            case 2:
            {
                cell.label.text = @"确认";
                cell.backgroundColor = kRGB(126, 211, 33);
                cell.RankProjectImage.image = kImageNamed(@"确认修改");
                
            }
                break;
            default:
                break;
        }
    }
    
    
    cell.RankingImage.hidden = YES;
    cell.jtBtn.hidden = YES;
    
    return cell;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.myInfoTable deselectRowAtIndexPath:indexPath animated:YES];
    if (self.isModify) {
        if (indexPath.row==2) {
            if ([self.field.text isEqual:@""]) {
                [[UIGlobalKit sharedInstance] showMessage:@"请输入要修改的名字!" in:self disappearAfter:2.0f];
                return;
            }
            [self ModifyName];
        }
        return;
    }
    [self.delegate MyIndoDidSelectRowAtIndexPath:indexPath];
}

//修改昵称
-(void)ModifyName
{
    NSString * nickname = self.field.text;
    NSUInteger textLen = [self getToInt:nickname];
    if(textLen == 0)
    {
        [UIAlertView showInfoMessage:@"昵称不能为空"];
        return;
    }
    if(textLen>16)
    {
        self.field.text = @"";
        [UIAlertView showInfoMessage:@"昵称长度不能大于16个字符"];
        return;
    }
    // Save Temp Nick Name.
    [self.dataManager.defaults setNickNameCache:self.field.text];
    [self.dataManager.defaults setNickNameCacheCopy:[TTShowUser nick_name]];
    
//    NSArray *sensitiveNickNames = [Cache getSensitiveNickNames];
//    if (sensitiveNickNames.count > 0) {
//        for (NSString *sensitive in sensitiveNickNames) {
//            if ([self containsString:nickname other:sensitive]) {
//                [UIAlertView showInfoMessage:@"昵称中含有违禁词"];
//                return;
//            }
//        }
//    }
    
    [self showProgress:@"正在修改…" animated:YES];
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithCapacity:0];
    [userInfo setValue:nickname forKey:@"nick_name"];
    [self.dataManager.remote _uploadUserInformation:userInfo completion:^(BOOL success, NSError *error) {
        [self hideProgressWithAnimated:YES];
        if (success)
        {
            [self.dataManager.remote updateUserInformationWithCompletion:^(TTShowUser *user, NSError *error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [self.dataManager updateUser];
                    
                    [kNotificationCenter postNotificationName:kNotificationUpdateUser object:nil];
                    [kNotificationCenter postNotificationName:kNotificationSocketReconnect object:nil];
                    
                    [self.dataManager.defaults setNickNameCache:self.field.text];
                    [self.dataManager.defaults setNickNameCacheCopy:[TTShowUser nick_name]];
                    
                    [self.delegate ModifyDidSelect];
                });
            }];
        }
        else
        {
            [UIAlertView showErrorMessage:@"保存失败"];
            return ;
        }
    }];
    
}

-(NSUInteger)getToInt:(NSString*)strtemp
{
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSData* da = [strtemp dataUsingEncoding:enc];
    return[da length];
}

- (BOOL)containsString:(NSString *)this other:(NSString *)otherString
{
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_7_1) {
        NSRange range = [this rangeOfString:otherString];
        return range.length != 0;
    } else {
        return [this containsString:otherString];
    }
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
