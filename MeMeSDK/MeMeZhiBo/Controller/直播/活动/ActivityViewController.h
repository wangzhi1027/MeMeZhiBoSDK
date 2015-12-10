//
//  ActivityViewController.h
//  memezhibo
//
//  Created by Xingai on 15/6/24.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "BaseViewController.h"
#import "TTShowMainImageList.h"

@interface ActivityViewController : BaseViewController

@property (nonatomic, weak) IBOutlet UIWebView *webView;

@property (nonatomic, strong) TTShowMainImageList *imageList;

@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;

@end
