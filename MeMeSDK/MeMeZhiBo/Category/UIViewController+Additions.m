//
//  UIViewController+PPAdditions.m
//  PPTVCommon
//
//  Created by chuckwang on 12/4/12.
//  Copyright (c) 2012 PPTV. All rights reserved.
//

#import "UIViewController+Additions.h"

@implementation UIViewController (Additions)

- (void)addChildContentViewController:(UIViewController *)childController
{
    [self addChildViewController:childController];
    
    [self.view addSubview:childController.view];
    
    [childController didMoveToParentViewController:self];
}

- (void)removeChildContentViewControler:(UIViewController *)childController
{
    [childController willMoveToParentViewController:nil];
    
    [childController.view removeFromSuperview];
    
    [childController removeFromParentViewController];
}

@end
