//
//  PersonalHomeHeadView.m
//  memezhibo
//
//  Created by Xingai on 15/7/8.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "PersonalHomeHeadView.h"
#import "UIColor+Hex.h"
#import "NSBundle+SDK.h"

@implementation PersonalHomeHeadView

#pragma mark - Initilization

- (void)awakeFromNib
{
    self.headImage.layer.masksToBounds = YES;
    self.headImage.layer.cornerRadius = 24;
    self.headImage.layer.borderWidth = 0.5;
    self.headImage.layer.borderColor = kRGBA(202.0f, 202.0f, 202.0f, 0.8).CGColor;
    
    self.cancelWatchAnchorBtn.layer.borderColor = [UIColor colorWithHexString:@"#FFFFFF" alpha:.8f].CGColor;
    self.addFriendsBtn.layer.borderColor = [UIColor colorWithHexString:@"#FFFFFF" alpha:.8f].CGColor;
}

-(id)init{
    if (self = [super init])
    {
        self = [[[NSBundle SDKResourcesBundle]loadNibNamed:@"PersonalHomeHeadView" owner:self options:nil] lastObject];
        
//        self.bgView.backgroundColor = kRGBA(0, 0, 0, 0);
        self.headImage.layer.masksToBounds = YES;
        self.headImage.layer.borderWidth = 0.5;
        self.headImage.layer.borderColor = kRGBA(202.0f, 202.0f, 202.0f, 0.8).CGColor;
        self.headImage.layer.cornerRadius = 24;
    }
    return self;
}

#pragma mark - Event Response

- (IBAction)cancelWatchBtnTapped:(UIButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(cancelWatchBtnTapped:headerView:)]) {
        [self.delegate cancelWatchBtnTapped:sender headerView:self];
    }
}

- (IBAction)addFriendsBtnTapped:(UIButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(addFriendsBtnTapped:headerView:)]) {
        [self.delegate addFriendsBtnTapped:sender headerView:self];
    }
}

@end