//
//  ActivityViewController.m
//  memezhibo
//
//  Created by Xingai on 15/6/24.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "ActivityViewController.h"

@interface ActivityViewController ()<UIWebViewDelegate>

@end

@implementation ActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavView];
    self.titleLabel.text = self.imageList.title;
    [self setupLeftBtnAction:@selector(goback:)];
    [self.backBtn setTitle:@"大厅" forState:UIControlStateNormal];
    [self setupWebView];
    [self setupActyvity];
    self.view.backgroundColor = kCommonBgColor;
}

-(void)setupNavgation
{
    [self.uiManager.global setNavigationController:self title:self.imageList.title];
    
    // Navigation Bar Bg
    [self.uiManager.global setNavCustomNormalBg:self hasBottomLine:YES];
    
    // left
    [self.uiManager.global setNavLeftBackItem:self action:@selector(goback:)];
}

-(void)goback:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(void)setupActyvity
{
    self.activityIndicatorView = [[UIActivityIndicatorView alloc]
                             initWithFrame : CGRectMake(kScreenWidth/2-16, (kScreenHeight-kNavigationBarHeight)/2-16, 32.0f, 32.0f)] ;
    [self.activityIndicatorView setActivityIndicatorViewStyle: UIActivityIndicatorViewStyleGray] ;
    [self.view addSubview:self.activityIndicatorView] ;
}

-(void)setupWebView
{
    self.webView.delegate = self;
    
    NSURL *url =[NSURL URLWithString:self.imageList.click_url];

    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.activityIndicatorView startAnimating] ;
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.activityIndicatorView stopAnimating];
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
