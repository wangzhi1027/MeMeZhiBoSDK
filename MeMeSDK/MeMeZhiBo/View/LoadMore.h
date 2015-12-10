//
//  LoadMore.h
//  TTShow
//
//  Created by twb on 13-10-28.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadMore : UIView

@property (strong, nonatomic) UIActivityIndicatorView *loadingAnimation;
@property (weak, nonatomic) IBOutlet UILabel *loadingLabel;

- (void)setFooterLoading;
- (void)setFooterFinish;
- (void)setFooterPullup;
- (void)setFooterRelease;

@end
