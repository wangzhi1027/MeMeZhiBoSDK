//
//  ChargeFromTPViewController.m
//  TTShow
//
//  Created by twb on 13-11-21.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import "ChargeFromTPViewController.h"
#import "ChargeInfoCell.h"
#import "ChargeChooseCell.h"
#import "ChargeValueCell.h"
#import "ChargeRemainView.h"
#import "ChargeTPFooter.h"
#import "ChargeScrollTipView.h"
#import "TTShowUser.h"

static NSString *kChargeInfoCellReuseID = @"ChargeInfoCellReuseID";
static NSString *kChargeChooseCellReuseID = @"ChargeChooseCellReuseID";
static NSString *kChargeValueCellReuseID = @"ChargeValueCellReuseID";

#define kChargeTPDefaultMoney (1)

typedef NS_ENUM(NSInteger, ChargeTPRow)
{
    kTPInfoRow = 0,
    kTPChooseRow,
    kTPQuantityRow,
    kTPRowMax
};

@interface ChargeFromTPViewController () <UITableViewDataSource, UITableViewDelegate, TTStepDelegate>
{
    NSInteger chargeMoney;
}
@end

@implementation ChargeFromTPViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupNavigation];
    [self setupChargeScrollTipView];
    [self setupChargeView];

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
    [self.uiManager.global setNavigationController:self title:@"充值"];
    
    // left
    [self.uiManager.global setNavLeftBackItem:self action:@selector(goBack:)];
}

- (void)setupChargeScrollTipView
{
    ChargeScrollTipView *cst = (ChargeScrollTipView *)[self viewFromNib:@"ChargeScrollTipView" withOrigin:CGPointMake(0.0f, (kNavigationBarHeight + kScreenStatusBarHeight))];
    [self.view addSubview:cst];
}

- (void)setupChargeView
{
    UITableView *cv = [[UITableView alloc] initWithFrame:CGRectMake(0.0f,
                                                                    (kNavigationBarHeight + kScreenStatusBarHeight + kChargeScrollTipViewHeight),
                                                                    kScreenWidth,
                                                                    kScreenHeight - kChargeScrollTipViewHeight) style:UITableViewStyleGrouped];
    self.chargeView = cv;
    self.chargeView.dataSource = self;
    self.chargeView.delegate = self;
//    self.chargeView.separatorColor = kClearColor;
    if ([self.chargeView respondsToSelector:@selector(setSeparatorInset:)])
    {
        self.chargeView.separatorInset = UIEdgeInsetsMake(0.0f, 10.0f, 0.0f, 0.0f);
    }
    self.chargeView.backgroundView = nil;
    self.chargeView.backgroundColor = kCommonBgColor;
    _remainHeader = (ChargeRemainView *)[self viewFromNib:@"ChargeRemainView"];
    self.chargeView.tableHeaderView = _remainHeader;
    ChargeTPFooter *chargeTPFooter = (ChargeTPFooter *)[self viewFromNib:@"ChargeTPFooter"];
    [chargeTPFooter.submit addTarget:self action:@selector(submitCharge:) forControlEvents:UIControlEventTouchUpInside];
    self.chargeView.tableFooterView = chargeTPFooter;
    
    [self.chargeView registerNib:[UINib nibWithNibName:@"ChargeInfoCell" bundle:nil] forCellReuseIdentifier:kChargeInfoCellReuseID];
    [self.chargeView registerNib:[UINib nibWithNibName:@"ChargeChooseCell" bundle:nil] forCellReuseIdentifier:kChargeChooseCellReuseID];
    [self.chargeView registerNib:[UINib nibWithNibName:@"ChargeValueCell" bundle:nil] forCellReuseIdentifier:kChargeValueCellReuseID];
    [self.view addSubview:self.chargeView];
}

#pragma mark - Notification

- (void)registerNotification
{
    [kNotificationCenter addObserver:self selector:@selector(updateUserInformation:) name:kNotificationUpdateUser object:nil];
}

- (void)unregisterNotification
{
    [kNotificationCenter removeObserver:self name:kNotificationUpdateUser object:nil];
}

#pragma mark - Life cycle.

- (void)dealloc
{
    [self unregisterNotification];
    
    _remainHeader = nil;
    _chargeView = nil;
}

#pragma mark - Event part.

- (void)updateUserInformation:(NSNotification *)notification
{
    TTShowUser *user = [TTShowUser unarchiveUser];
    
    // get balance.
    long long int coin_count = 0;
    Finance *finance = [[Finance alloc] initWithAttributes:user.finance];
    coin_count = finance.coin_count;
    
    // update balance.
    [_remainHeader setRemainCount:coin_count];
}

- (void)goBack:(id)sender
{
    if (self.enterFromPush)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [self.dataManager.remote updateUserInformationWithCompletion:^(TTShowUser *user, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                // update user in data manager.
                [self.dataManager updateUser];
                
                [kNotificationCenter postNotificationName:kNotificationUpdateUser object:nil];
            });
        }];

        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return kTPRowMax;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row)
    {
        case kTPInfoRow:
        {
            ChargeInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:kChargeInfoCellReuseID];
            if (!cell)
            {
                cell = [[ChargeInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kChargeInfoCellReuseID];
            }
            
            [self.uiManager.global setTopBGCell:cell];
            
            return cell;
        }
            break;
        case kTPChooseRow:
        {
            ChargeChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:kChargeChooseCellReuseID];
            if (!cell)
            {
                cell = [[ChargeChooseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kChargeChooseCellReuseID];
            }
            cell.stepView.delegate = self;
            [self.uiManager.global setCenterBGCell:cell];
            
            return cell;
        }
            break;
        case kTPQuantityRow:
        {
            ChargeValueCell *cell = [tableView dequeueReusableCellWithIdentifier:kChargeValueCellReuseID];
            if (!cell)
            {
                cell = [[ChargeValueCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kChargeValueCellReuseID];
            }
            
            [self.uiManager.global setBottomBGCell:cell];
            
            return cell;
        }
            break;
        default:
            break;
    }
    
    return nil;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0f;
}

// Hide keyboard.
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    ChargeChooseCell *cell = (ChargeChooseCell *)[self.chargeView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:kTPChooseRow inSection:0]];
    if (cell)
    {
        [cell.stepView hideKeyboard];
    }
}

/*
 *
 *  This Part is providing data for next step.
 *  submitCharge:
 *
 */

#pragma mark - TTStepDelegate

- (void)stepChanged:(NSInteger)count
{    
    ChargeValueCell *cell = (ChargeValueCell *)[self.chargeView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:kTPQuantityRow inSection:0]];
    [cell setMoneyCount:count];
    chargeMoney = count;
}

- (void)submitCharge:(id)sender
{
    if (chargeMoney == 0)
    {
        chargeMoney = kChargeTPDefaultMoney;
    }
    [self.uiManager showThirdPay:self chargeMoney:chargeMoney];
}

@end
