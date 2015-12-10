//
//  BaseViewController.m
//  TTShow
//
//  Created by twb on 13-9-16.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import "BaseViewController.h"
#import "NoContentTip.h"
#import "MMMBProgressHUD.h"


@interface BaseViewController () <UIAlertViewDelegate>

@property (nonatomic, strong) NoContentTip *noContentTip;
@property (nonatomic, strong) MMMBProgressHUD *hud;

@end

@implementation BaseViewController

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
//    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)setupNavView
{
    self.view.backgroundColor = kCommonBgColor;
    self.navigationController.navigationBarHidden = YES;
    
    self.nav = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kNavigationBarHeight)];
    [self.view addSubview:self.nav];
    self.nav.backgroundColor = kNavigationMainColor;
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/2-85, (kNavigationBarHeight)/2, 170, 21)];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = kWhiteColor;
    [self.nav addSubview:self.titleLabel];
}

-(void)setupLeftBtnAction:(SEL)action
{
//    UIImageView *backImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, <#CGFloat width#>, <#CGFloat height#>)]
    
    self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backBtn.frame = CGRectMake(5, (kNavigationBarHeight)/2, 80.0f, 21.0f);
    [self.backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [self.backBtn setImage:kImageNamed(@"back") forState:UIControlStateNormal];
    [self.backBtn setImage:kImageNamed(@"bac_按下") forState:UIControlStateHighlighted];
    [self.backBtn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    
    self.backBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    
    self.backBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -25, 0, 0);
    
//    [self.backBtn setTitle:@"返回" forState:UIControlStateNormal];
    
    self.backBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -30, 0, 0);
    
    [self.backBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [self.backBtn setTitleColor:kRGB(239, 239, 239) forState:UIControlStateHighlighted];
    
    [self.nav addSubview:self.backBtn];
    
//    self.backLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, (kNavigationBarHeight)/2, 40, 21)];
}

-(void)setupRightBtnAction:(SEL)action
{
    self.rightBtn.frame = CGRectMake(kScreenWidth-44, (kNavigationBarHeight)/2, 24.0f, 24.0f);
    [self.rightBtn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [self.nav addSubview:self.rightBtn];
}


#pragma mark - 

- (void)showNoContentTip:(NSString *)tip
{
    if (self.noContentTip == nil)
    {
        self.noContentTip = (NoContentTip *)[self viewFromNib:@"NoContentTip" withOrigin:CGPointMake(0.0f, 80.0f)];
        [self.noContentTip addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewDidReload)]];
        [self.view addSubview:self.noContentTip];
    }
    [self.noContentTip setTipText:tip];
}

- (void)hideNoContentTip
{
    if (self.noContentTip)
    {
        [self.noContentTip removeFromSuperview];
        self.noContentTip = nil;
    }
}

- (void)showProgress:(NSString *)tip inView:(UIView *)view animated:(BOOL)animated
{
    if (self.hud)
    {
        [self.hud hide:YES];
        self.hud = nil;
    }
    self.hud = [MMMBProgressHUD showHUDAddedTo:view animated:animated];
    self.hud.labelText = tip;
}

- (void)showProgress:(NSString *)tip animated:(BOOL)animated
{
    [self showProgress:tip inView:self.view animated:animated];
}

- (void)hideProgressInView:(UIView *)view animated:(BOOL)animated
{
    [MMMBProgressHUD hideHUDForView:view animated:animated];
}

- (void)hideProgressWithAnimated:(BOOL)animated
{
    [self hideProgressInView:self.view animated:YES];
}

- (void)showChargeTip
{
    UIAlertView *chargeAlertView = [UIAlertView showChargeMessageWithdelegate:self];
    chargeAlertView.tag = kAlertViewCharge;
    [chargeAlertView show];
}

#pragma mark - Override Part.

- (void)viewDidReload
{
    // do common things.
    // this thing is done by extremely carefully.
}

@end
