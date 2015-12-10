//
//  LoadMore.m
//  TTShow
//
//  Created by twb on 13-10-28.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import "LoadMore.h"

@implementation LoadMore

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    // This control must be added by coding, can't be created by nib.
     UIActivityIndicatorView *loading = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.loadingAnimation = loading;
    [self.loadingAnimation setFrame:CGRectMake(60.0f, 5.0f, 50.0f, 30.0f)];
    [self addSubview:self.loadingAnimation];
}

- (void)setFooterLoading
{
    self.loadingAnimation.hidden = NO;
    [self.loadingLabel setText:@"正在载入..."];
    [self addSubview:self.loadingAnimation];
    if (![self.loadingAnimation isAnimating]) {
        [self.loadingAnimation startAnimating];
    }
}

- (void)setFooterFinish
{
    self.loadingAnimation.hidden = YES;
    [self.loadingAnimation removeFromSuperview];
    [self.loadingLabel setText:@"已无更多数据"];
}

- (void)setFooterPullup
{
    self.loadingLabel.hidden = NO;
    self.loadingAnimation.hidden = YES;
    [self.loadingAnimation removeFromSuperview];
    [self.loadingLabel setText:@"上拉加载更多"];
}

- (void)setFooterRelease
{
    self.loadingAnimation.hidden = YES;
    [self.loadingAnimation removeFromSuperview];
    [self.loadingLabel setText:@"释放加载更多"];
}

#pragma mark - Life cycle.

- (void)dealloc
{
    self.loadingAnimation = nil;
}

@end
