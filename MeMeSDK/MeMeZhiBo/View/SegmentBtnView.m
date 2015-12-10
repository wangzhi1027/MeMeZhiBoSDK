//
//  SegmentBtnView.m
//  memezhibo
//
//  Created by Xingai on 15/6/3.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "SegmentBtnView.h"
#import "NSBundle+SDK.h"

@implementation SegmentBtnView

-(id)init
{
    self = [[[NSBundle SDKResourcesBundle]loadNibNamed:@"SegmentBtnView" owner:self options:nil] lastObject];
    
    self.backgroundColor = kRGB(80, 72, 75);
    self.segmentLabel.font = [UIFont boldSystemFontOfSize:14];
    self.image.image = [kImageNamed(@"navgation_bg")stretchableImageWithLeftCapWidth:1 topCapHeight:1];
    self.image.hidden = YES;
    
    self.segmentLabel.textColor = kWhiteColor;
    
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(segmentTap:)]];
    
    return self;
}

-(void)segmentTap:(UITapGestureRecognizer *)sender
{
    self.segmentLabel.textColor = kNavigationMainColor;
    [self.delegete segmentBtnClick:sender.view.tag];
}

@end
