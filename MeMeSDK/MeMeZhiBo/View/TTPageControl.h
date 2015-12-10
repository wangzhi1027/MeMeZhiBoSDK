//
//  TTPageControl.h
//  TTShow
//
//  Created by twb on 13-7-25.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTPageControl : UIPageControl
{
    UIImage* activeImage;
    UIImage* inactiveImage;
}

- (void)swapDot;

@end
