//
//  ChargeViewController.m
//  TTShow
//
//  Created by twb on 13-7-18.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import "ChargeViewController.h"
#import "ChargeViewController+Datasource.h"
#import "ChargeViewController+Delegate.h"
#import "TTShowUser.h"
#import "TTShowRemote+Charge.h"
#import "NSBundle+SDK.h"

#define kChargeCurrencySpecialString @"@currency="

@interface ChargeViewController ()

@end

@implementation ChargeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
    [super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self unregisterNotification];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    [self setupNavigation];
    [self setupNavView];
    self.titleLabel.text = @"充值";
    [self setupLeftBtnAction:@selector(goBack:)];
    [self setupChargeTableView];
    
    [self retrieveProducts];
    
    [self registerNotification];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    self.chargeTableView.dataSource = nil;
    self.chargeTableView.delegate = nil;
    self.chargeTableView = nil;
    
    [super viewDidUnload];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Life Cycle Part.

- (void)dealloc
{
    [self unregisterNotification];
    self.iapHelp = nil;
    self.chargeTableView.dataSource = nil;
    self.chargeTableView.delegate = nil;
    self.chargeTableView = nil;
    self.products = nil;
    
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

- (void)setupChargeTableView
{
    UITableView *chargeView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, kNavigationBarHeight, kScreenWidth, kScreenHeight-kNavigationBarHeight) style:UITableViewStyleGrouped];
    self.chargeTableView = chargeView;
    self.chargeTableView.delegate = self;
    self.chargeTableView.dataSource = self;
    self.chargeTableView.backgroundColor = kCommonBgColor;
    self.chargeTableView.backgroundView = nil;
//    self.chargeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.chargeTableView.separatorColor = kClearColor;
    if ([self.chargeTableView respondsToSelector:@selector(setSeparatorInset:)])
    {
        self.chargeTableView.separatorInset = UIEdgeInsetsMake(0.0f, 10.0f, 0.0f, 0.0f);
    }
    [self.chargeTableView registerNib:[UINib nibWithNibName:@"ChargeRemainCell" bundle:[NSBundle SDKResourcesBundle]] forCellReuseIdentifier:@"ChargeRemainCellReuseID"];
    [self.chargeTableView registerNib:[UINib nibWithNibName:@"ChargeProductCell" bundle:[NSBundle SDKResourcesBundle]] forCellReuseIdentifier:@"ChargeProductCellReuseID"];
    [self.view addSubview:self.chargeTableView];
}

#pragma mark - Custom Override Part.

- (void)viewDidReload
{
    [super viewDidReload];
    
    // Reload remote data for product list.
//    [self retrieveProducts];
}

#pragma mark - Notification

- (void)registerNotification
{
    [kNotificationCenter addObserver:self selector:@selector(handleNotification:) name:IAPHelperProductPurchasedNotification object:nil];
    [kNotificationCenter addObserver:self selector:@selector(handleNotification:) name:IAPHelperProductPurchaseFailureNotification object:nil];
    
    [kNotificationCenter addObserver:self selector:@selector(updateUserInformation:) name:kNotificationUpdateUser object:nil];
}

- (void)unregisterNotification
{
    [kNotificationCenter removeObserver:self name:IAPHelperProductPurchasedNotification object:nil];
    [kNotificationCenter removeObserver:self name:IAPHelperProductPurchaseFailureNotification object:nil];
    
    [kNotificationCenter removeObserver:self name:kNotificationUpdateUser object:nil];
}

#pragma mark - Remote part.

- (void)retrieveProducts
{
//    self.iapHelp = [[IAPHelper alloc] init];
    self.products = [NSMutableArray arrayWithCapacity:0];
    [self retrieveProductsFromAppStore];
}

// retrieve product from APP Store.

- (void)getProductListWithIdentifiers:(NSArray *)array
{
    NSSet *productIdentifiers = [NSSet setWithArray:array];
    if (!self.iapHelp)
    {
        self.iapHelp = [[IAPHelper alloc] initWithProductIdentifiers:productIdentifiers];
    }
    if (self.iapHelp == nil)
    {
        return;
    }
    [self.iapHelp requestProductsWithCompletionHandler:^(BOOL success, NSArray *products, NSError *error) {
        if (success && products.count != 0)
        {
            // Data.
            if (self.productList == nil)
            {
                NSMutableArray *productList = [NSMutableArray arrayWithCapacity:0];
                self.productList = productList;
            }
            else
            {
                [self.productList removeAllObjects];
            }
            [self.productList addObjectsFromArray:products];
            
            // get currency type.
            if (products.count > 0)
            {
                [self getCurrencyTypeWithProduct:products[0]];
            }
            
            // UI.
            if (self.productList.count == 0)
            {
                [self showNoContentTip:@"加载商品列表失败"];
            }
            else
            {
                [self hideNoContentTip];
            }
        }
        else
        {
            if (!error)
            {
//                if ([MobClick isJailbroken])
//                {
//                    [self showNoContentTip:@"您的机器已越狱,为了您的账户安全,请选用未越狱版本充值."];
//                }
//                {
//                    [self showNoContentTip:@"您的机器已越狱,为了您的账户安全,请选用未越狱版本充值."];
//                }
            }
            else
            {
                [self showNoContentTip:[error localizedDescription]];
            }
        }
        
        [self hideProgressWithAnimated:YES];
    }];
}

- (void)retrieveProductsFromAppStore
{
    [self showProgress:@"正在载入商品列表..." animated:YES];
    [self hideNoContentTip];
    
    [self.dataManager.remote retrieveProducts:^(NSArray *array, NSError *error) {
        if (!error && array.count > 0) {
            NSSortDescriptor *sortByPrice = [NSSortDescriptor sortDescriptorWithKey:@"price" ascending:YES];
            
            NSArray *results = [array sortedArrayUsingDescriptors:@[sortByPrice]];

            [self.products removeAllObjects];
            [self.products addObjectsFromArray:results];
            
            [self.chargeTableView reloadData];
            
            NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
            for (ProductModel *model in array) {
                [arr addObject:model.key];
            }
            
            [self getProductListWithIdentifiers:arr];
            [GlobalStatics SET_IAP_PRODUCTS:arr];
        }
    }];
}

#pragma mark - event part.

- (void)getCurrencyTypeWithProduct:(SKProduct *)product
{
    NSString *localeString = product.priceLocale.localeIdentifier;
    NSRange range = [localeString rangeOfString:kChargeCurrencySpecialString];
    if (range.location != NSNotFound)
    {
        range.location = range.location + range.length;
        range.length = localeString.length - range.location;
        self.currencyTypeName = [localeString substringWithRange:range];
        return;
    }
    self.currencyTypeName = @"CNY";
}

- (void)updateUserInformation:(NSNotification *)notification
{
    TTShowUser *user = [TTShowUser unarchiveUser];
    // update balance.
    long long int coin_count = 0;
    Finance *finance = [[Finance alloc] initWithAttributes:user.finance];
    coin_count = finance.coin_count;
    
    ChargeRemainCell *cell = (ChargeRemainCell *)[self.chargeTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:kChargeSectionRemain]];
    [cell setRemainCount:coin_count];
}

- (void)goBack:(id)sender
{
    if (self.iapHelp && self.iapHelp.purchasing)
    {
        [UIAlertView showInfoMessage:@"正在处理购买,请稍后..."];
        return;
    }
    
    self.isWindowClosed = YES;
    
    if (self.enterFromPush)
    {
        [self.navigationController popViewControllerAnimated:YES];
        self.navigationController.navigationBarHidden = NO;
    }
    else
    {
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
}

- (void)handleNotification:(NSNotification *)notification
{
    // Purchased.
    SKPaymentTransaction *transaction = [notification object];
    NSString *productID = @"";
    if ([transaction isKindOfClass:[SKPaymentTransaction class]])
    {
        productID = transaction.payment.productIdentifier;
    }
    NSDictionary *userInfo = [notification userInfo];
    if (userInfo != nil)
    {
        // read error information.
        NSString *errStr = userInfo[@"error"];
        NSInteger code = [userInfo[@"code"] integerValue];
        if (code != SKErrorPaymentCancelled)
        {
            [UIAlertView showInfoMessage:errStr];
        }
        [self hideProgressWithAnimated:YES];
        return;
    }
    
    [self hideProgressWithAnimated:YES];
    
    for (SKProduct *skProduct in self.productList)
    {
        if ([skProduct.productIdentifier isEqualToString:productID])
        {
            if (notification.name == IAPHelperProductPurchasedNotification)
            {
                [self recordFirstCharge];
                [self.dataManager.remote updateUserInformationWithCompletion:^(TTShowUser *user, NSError *error) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        // update user in data manager.
                        [self.dataManager updateUser];
                        
                        [kNotificationCenter postNotificationName:kNotificationUpdateUser object:nil];
                        
                        // cpa forbidding crash here.
                        NSString *orderID = @"";
                        if (transaction.transactionIdentifier && ![transaction.transactionIdentifier isEqualToString:@""])
                        {
                            orderID = transaction.transactionIdentifier;
                        }
                        NSString *currency = @"CNY";
                        if (self.currencyTypeName && ![self.currencyTypeName isEqualToString:@""])
                        {
                            currency = self.currencyTypeName;
                        }
//                        [self.dataManager cpaOnPayWithUserID:[NSString stringWithFormat:@"%d", user._id]
//                                                     orderID:orderID
//                                                      amount:([skProduct.price floatValue] * 100)
//                                                    currency:currency];
                        
                        [UIAlertView showInfoMessage:[NSString stringWithFormat:@"购买 %@ 成功", skProduct.localizedTitle]];
                        
                        
                        
                        
                    });
                }];
            }
            else
            {
                [UIAlertView showInfoMessage:[NSString stringWithFormat:@"购买 %@ 失败", skProduct.localizedTitle]];
            }
            
            break;
        }
    }
}

- (void)recordFirstCharge
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self.dataManager.filter setFirstCharge:YES];
    });
}

@end
