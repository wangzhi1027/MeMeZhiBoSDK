//
//  AnchorHederView.m
//  memezhibo
//
//  Created by XIN on 15/10/22.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "AnchorHederView.h"

@implementation AnchorHederView

#pragma mark - Event Response

- (IBAction)photoWallBtnTapped:(UIButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(photoWallBtnTapped:ahchorHeaderView:)]) {
        [self.delegate photoWallBtnTapped:sender ahchorHeaderView:self];
    }
}

- (IBAction)profileBtnTapped:(UIButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(profileBtnTapped:anchorHeaderView:)]) {
        [self.delegate profileBtnTapped:sender anchorHeaderView:self];
    }
}

@end
