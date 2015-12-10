//
//  ThirdPayViewController.m
//  TTShow
//
//  Created by twb on 13-11-21.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import "ThirdPayViewController.h"
#import "ThirdPayViewController+AlixPay.h"
#import "ChargeInfoCell.h"
#import "ChargeValueCell.h"
#import "PayMethodCell.h"
#import "PayConfirmFooter.h"
#import "TTShowProduct.h"

static NSString *kChargeRatioCellReuseID = @"ChargeRatioCellReuseID";
static NSString *kChargeValueCellReuseID = @"ChargeValueCellReuseID";
static NSString *kPayMethodCellRuseID = @"PayMethodCellReuseID";

#define kUpdateBalanceDuration (2.5f)

typedef NS_ENUM(NSInteger, SubmitChargeTPSection)
{
    kSubmitChargeTPSectionOrderInfo = 0,
    kSubmitChargeTPSectionPayMethod,
    kSubmitChargeTPSectionMax
};

typedef NS_ENUM(NSInteger, SubmitChargeTPRow)
{
    kSubmitChargeRowOrderRatio = 0,
    kSubmitChargeRowOrderMoney,
    kSubmitChargeRowOrderCoin,
    kSubmitChargeRowOrderMax,
    
    kSubmitChargeRowPayAlix = 0,
    kSubmitChargeRowPayAlixWap,
    kSubmitChargeRowPayTenWap,
    kSubmitChargeRowPayMax
};

typedef NS_ENUM(NSInteger, SubmitPayMethod)
{
    kSubmitPayMethodAlix = 0,
    kSubmitPayMethodAlixWap,
    kSubmitPayMethodTenWap,
    kSubmitPayMethodUnknown
};

#define kPayFromMoneyToCoinConvertBase (100)

@interface ThirdPayViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *orderTitles;
@property (nonatomic, strong) NSArray *payMethods;
@property (nonatomic, strong) NSArray *payMethodDetails;
@property (nonatomic, strong) NSArray *sectionTitles;

@property (nonatomic, assign) SubmitPayMethod payMothod;

@end

@implementation ThirdPayViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.payMothod = kSubmitPayMethodAlixWap;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupDataContainer];
    
    [self setupNavigation];
    [self setupOrderTable];
    
    [self registerNotification];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - setup part.

- (void)setupNavigation
{
    self.view.backgroundColor = kCommonBgColor;
    
    // Navigation Bar Bg
    [self.uiManager.global setNavCustomNormalBg:self];
    
    // Title
    [self.uiManager.global setNavigationController:self title:@"确认订单"];
    
    // left
    [self.uiManager.global setNavLeftBackItem:self action:@selector(goBack:)];
}

- (void)setupOrderTable
{
    UITableView *tv = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
    self.orderTable = tv;
    self.orderTable.dataSource = self;
    self.orderTable.delegate = self;
//    self.orderTable.separatorColor = kClearColor;
    if ([self.orderTable respondsToSelector:@selector(setSeparatorInset:)])
    {
        self.orderTable.separatorInset = UIEdgeInsetsMake(0.0f, 10.0f, 0.0f, 0.0f);
    }
    self.orderTable.backgroundView = nil;
    self.orderTable.backgroundColor = kCommonBgColor;
    [self.orderTable registerNib:[UINib nibWithNibName:@"ChargeInfoCell" bundle:nil] forCellReuseIdentifier:kChargeRatioCellReuseID];
    [self.orderTable registerNib:[UINib nibWithNibName:@"ChargeValueCell" bundle:nil] forCellReuseIdentifier:kChargeValueCellReuseID];
    [self.orderTable registerNib:[UINib nibWithNibName:@"PayMethodCell" bundle:nil] forCellReuseIdentifier:kPayMethodCellRuseID];
    
    PayConfirmFooter *payFooter = (PayConfirmFooter *)[self viewFromNib:@"PayConfirmFooter"];
    [payFooter.pay addTarget:self action:@selector(submitPay:) forControlEvents:UIControlEventTouchUpInside];
    self.orderTable.tableFooterView = payFooter;
    
    [self.view addSubview:self.orderTable];
    
    // Select default pay.
    NSIndexPath *defaultPayIndexPath = [NSIndexPath indexPathForRow:self.payMothod inSection:kSubmitChargeTPSectionPayMethod];
    [self.orderTable selectRowAtIndexPath:defaultPayIndexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
}

- (void)setupDataContainer
{
    self.orderTitles = @[@"", @"充值金额:", @"到账柠檬:"];
    self.payMethods = @[@"支付宝客户端支付", @"支付宝网页支付", @"财付通网页支付"];
    self.payMethodDetails = @[@"推荐已安装支付宝客户端的用户使用",
                              @"推荐有支付宝帐号的用户使用",
                              @"推荐有财付通帐号的用户使用"];
    self.sectionTitles = @[@"订单信息", @"选择支付方式"];
}

#pragma mark - Notification

- (void)registerNotification
{
    [kNotificationCenter addObserver:self selector:@selector(paySuccess:) name:kNotificationThirdPartyPaySuccess object:nil];
}

- (void)unregisterNotification
{
    [kNotificationCenter removeObserver:self name:kNotificationThirdPartyPaySuccess object:nil];
}

#pragma mark - Event part.

- (void)paySuccess:(NSNotification *)notification
{
    // the process may be delay, I don't know what happen between my server and alipay server.
    [self showProgress:@"正在载入..." animated:YES];
    double delayInSeconds = kUpdateBalanceDuration;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self.dataManager.remote updateUserInformationWithCompletion:^(TTShowUser *user, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                // update user in data manager.
                [self.dataManager updateUser];
                
                // Update user information
                [kNotificationCenter postNotificationName:kNotificationUpdateUser object:nil];
                [self hideProgressWithAnimated:YES];
                // back to previous page in order to check balance.
                [self goBack:nil];
                
            });
        }];
    });
}

- (void)goBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Life cycle

- (void)dealloc
{
    [self unregisterNotification];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return kSubmitChargeTPSectionMax;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section)
    {
        case kSubmitChargeTPSectionOrderInfo:
            return kSubmitChargeRowOrderMax;
            break;
        case kSubmitChargeTPSectionPayMethod:
            return kSubmitChargeRowPayMax;
            break;
        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section)
    {
        case kSubmitChargeTPSectionOrderInfo:
        {
            switch (indexPath.row)
            {
                case kSubmitChargeRowOrderRatio:
                {
                    ChargeInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:kChargeRatioCellReuseID];
                    if (!cell)
                    {
                        cell = [[ChargeInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kChargeRatioCellReuseID];
                    }
                    
                    [self.uiManager.global setTopBGCell:cell];
                    
                    return cell;
                }
                    break;
                case kSubmitChargeRowOrderMoney:
                {
                    ChargeValueCell *cell = [tableView dequeueReusableCellWithIdentifier:kChargeValueCellReuseID];
                    if (!cell)
                    {
                        cell = [[ChargeValueCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kChargeValueCellReuseID];
                    }
                    
                    [cell setTitleText:self.orderTitles[indexPath.row]];
                    [cell setMoneyCount:self.money];
                    
                    [self.uiManager.global setCenterBGCell:cell];
                    
                    return cell;
                }
                    break;
                case kSubmitChargeRowOrderCoin:
                {
                    ChargeValueCell *cell = [tableView dequeueReusableCellWithIdentifier:kChargeValueCellReuseID];
                    if (!cell)
                    {
                        cell = [[ChargeValueCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kChargeValueCellReuseID];
                    }
                    
                    [cell setTitleText:self.orderTitles[indexPath.row]];
                    [cell setCoinCount:self.money * kPayFromMoneyToCoinConvertBase];
                    
                    [self.uiManager.global setBottomBGCell:cell];
                    
                    return cell;
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case kSubmitChargeTPSectionPayMethod:
        {
            PayMethodCell *cell = [tableView dequeueReusableCellWithIdentifier:kPayMethodCellRuseID];
            if (!cell)
            {
                cell = [[PayMethodCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kPayMethodCellRuseID];
            }
            
            [cell setTitleText:self.payMethods[indexPath.row]];
            [cell setSubTitleText:self.payMethodDetails[indexPath.row]];
            
            switch (indexPath.row)
            {
                case kSubmitChargeRowPayAlix:
                    [self.uiManager.global setTopBGCell:cell];
                    cell.accessoryType = UITableViewCellAccessoryNone;
                    break;
                case kSubmitChargeRowPayAlixWap:
                    [self.uiManager.global setCenterBGCell:cell];
                    cell.accessoryType = UITableViewCellAccessoryCheckmark;
                    break;
                case kSubmitChargeRowPayTenWap:
                    [self.uiManager.global setBottomBGCell:cell];
                    cell.accessoryType = UITableViewCellAccessoryNone;
                    break;
                default:
                    break;
            }
            
            return cell;
        }
            break;
        default:
            break;
    }
    return nil;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == kSubmitChargeTPSectionOrderInfo)
    {
        return;
    }
    
    // check mark.
    for (NSUInteger i = 0; i < kSubmitChargeRowPayMax; i++)
    {
        NSIndexPath *ip = [NSIndexPath indexPathForRow:(i) inSection:indexPath.section];
        PayMethodCell *cell = (PayMethodCell *)[tableView cellForRowAtIndexPath:ip];
        if (i == indexPath.row)
        {
            [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
            continue;
        }
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    }
    
    self.payMothod = indexPath.row;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.sectionTitles[section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0f;
}

#pragma mark - Event part.

- (void)submitPay:(id)sender
{
    switch (self.payMothod)
    {
        case kSubmitPayMethodAlix:
        {
            TTShowProduct *product = [[TTShowProduct alloc] init];
            product.price = [@(self.money) stringValue];
            product.coin = self.money * kPayFromMoneyToCoinConvertBase;
            NSString *productInfo = [NSString stringWithFormat:@"充%.2f元得%ld柠檬", [@(self.money) floatValue], (long)self.money * kPayFromMoneyToCoinConvertBase];
            product.title = productInfo;
            product.detail = productInfo;
            
            [self buyProductWithAlixpay:product];
        }
            break;
        case kSubmitPayMethodAlixWap:
        {
            [self.uiManager showWapPay:self payMethod:kAliWapPay amount:self.money];
        }
            break;
        case kSubmitPayMethodTenWap:
        {
            [self.uiManager showWapPay:self payMethod:kTenWapPay amount:self.money];
        }
            break;
        default:
            break;
    }
}

@end
