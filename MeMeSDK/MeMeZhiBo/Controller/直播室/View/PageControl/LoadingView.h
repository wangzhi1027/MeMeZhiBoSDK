//
//  LoadingView.h
//  memezhibo
//
//  Created by Xingai on 15/6/15.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadingView : UIView

@property (nonatomic,weak) IBOutlet UIImageView *picImage;
@property (nonatomic,weak) IBOutlet UIImageView *loadingImage;

-(void)setLoadingAnimation;

@end
