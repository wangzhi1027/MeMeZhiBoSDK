//
//  LoadingView.m
//  memezhibo
//
//  Created by Xingai on 15/6/15.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "LoadingView.h"
#import "NSBundle+SDK.h"

@implementation LoadingView

-(id)init
{
    if (self = [super init])
    {
        self = [[[NSBundle SDKResourcesBundle]loadNibNamed:@"LoadingView" owner:self options:nil] lastObject];
        
        self.picImage.layer.masksToBounds = YES;
        self.picImage.layer.borderWidth = 0.25;
        self.picImage.layer.borderColor = kRGB(197, 197, 197).CGColor;
        self.picImage.layer.cornerRadius = 36;
        
        
        [self setLoadingAnimation];
    }
    
    return self;
}

-(void)setLoadingAnimation
{
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0f ];
    rotationAnimation.duration = 1.0f;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = 100.0f;
    
    [self.loadingImage.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

@end
