//
//  VideoTitleView.m
//  memezhibo
//
//  Created by Xingai on 15/6/8.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "VideoTitleView.h"
#import "NSBundle+SDK.h"

@implementation VideoTitleView

-(id)init
{
    if (self = [super init])
    {
        self = [[[NSBundle SDKResourcesBundle]loadNibNamed:@"VideoTitleView" owner:self options:nil] lastObject];
        self.nameLabel.font = [UIFont boldSystemFontOfSize:15.0f];
        self.backgroundColor = kRGBA(0, 0, 0, 0);
    }
    
    return self;
}

@end
