//
//  WapPayViewController.m
//  TTShow
//
//  Created by twb on 13-11-29.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import "WapPayViewController.h"
#import "TTShowWapPay.h"
#import "TTShowRemote+UserInfo.h"
#import "TTShowRemote+Charge.h"

@interface WapPayViewController () <UIWebViewDelegate, NSURLConnectionDelegate>
{
    NSURLConnection *_urlConnection;
    NSURLRequest *_request;
    BOOL _authenticated;
}
@end

@implementation WapPayViewController

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
    [self setupWapWebView];
    [self setupIndicatorView];
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
    [self.uiManager.global setNavigationController:self title:@"网页支付"];
    
    // left
    [self.uiManager.global setNavLeftBackItem:self action:@selector(goBack:)];
}

- (void)setupIndicatorView
{
    UIActivityIndicatorView *indictor = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.indictorView = indictor;
    self.indictorView.center = CGPointMake(kScreenWidth/2, (kScreenHeight-64)/2);
    self.indictorView.color = kBlackColor;
    [self.indictorView startAnimating];
    [self.view addSubview:self.indictorView];
}

- (void)setupWapWebView
{
    self.payWebView.delegate = self;
    
    // get pay url.   
    [self.dataManager.remote _getWapPayURLByMethod:self.payMethod amount:self.amount completion:^(TTShowWapPay *wapPay, NSError *error)
    {
        self.wapPay = wapPay;
    
        dispatch_async(dispatch_get_main_queue(), ^{
            // filter url string.
            NSString *urlString = [self.wapPay.requestURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSMutableURLRequest *wapPayRequest = [NSMutableURLRequest GETRequestForURL:urlString];
            [wapPayRequest setHTTPShouldHandleCookies:NO];
            [self.payWebView loadRequest:wapPayRequest];
        });
    }];
}

#pragma mark - Event part.

- (void)goBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    self.indictorView.hidden = NO;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.indictorView.hidden = YES;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    self.indictorView.hidden = YES;
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSURL *url = [request URL];
    if (self.wapPay == nil)
    {
        return YES;
    }
    
    if ([[url absoluteString] hasPrefix:self.wapPay.callbackURL])
    {
        // self request.
        [self.dataManager.remote updateUserInformationWithCompletion:^(TTShowUser *user, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                // update user in data manager.
                [self.dataManager updateUser];
                
                // Update user information
                [kNotificationCenter postNotificationName:kNotificationUpdateUser object:nil];
                
                //                // back to previous page in order to check balance.
                //                [self goBack:nil];
                [self.navigationController popToRootViewControllerAnimated:YES];
                
            });
        }];
        
        return NO;
    }
    
    return YES;
}

@end
