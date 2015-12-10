//
//  NavigationController.m
//  TTCX
//
//  Created by twb on 13-5-31.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import "NavigationController.h"

#define kNavigationBarBackImageName @"img_nav_bg_7.png"

@interface NavigationController ()

@end

@implementation NavigationController

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
	// Do any additional setup after loading the view.
    [self setupCustomNavigation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - setup part.

- (void)setupCustomNavigation
{
    self.navigationBar.translucent = NO;//SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7");
    [self.navigationBar setBackgroundImage:kImageNamed(kNavigationBarBackImageName)
                             forBarMetrics:UIBarMetricsDefault];
}

@end
