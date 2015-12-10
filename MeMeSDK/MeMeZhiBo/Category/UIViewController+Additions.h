//
//  UIViewController+PPAdditions.h
//  PPTVCommon
//
//  Created by chuckwang on 12/4/12.
//  Copyright (c) 2012 PPTV. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Additions)

- (void)addChildContentViewController:(UIViewController *)childController;

- (void)removeChildContentViewControler:(UIViewController *)childController;

@end
