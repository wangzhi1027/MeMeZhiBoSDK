//
//  PersonalPaimingView.m
//  memezhibo
//
//  Created by Xingai on 15/7/14.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "PersonalPaimingView.h"
#import "NSBundle+SDK.h"

@implementation PersonalPaimingView

-(id)init
{
    if (self = [super init])
    {
        self = [[[NSBundle SDKResourcesBundle]loadNibNamed:@"PersonalPaimingView" owner:self options:nil] lastObject];
        
        self.hengxianImage.image = [kImageNamed(@"礼物_横线")stretchableImageWithLeftCapWidth:0.0f topCapHeight:1];
    }
    
    return self;
}

@end
