//
//  LoadingViewTo.m
//  memezhibo
//
//  Created by Xingai on 15/6/19.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "LoadingViewTo.h"
#import "NSBundle+SDK.h"

@implementation LoadingViewTo

-(id)init
{
    if (self = [super init])
    {
        self = [[[NSBundle SDKResourcesBundle]loadNibNamed:@"LoadingViewTo" owner:self options:nil] lastObject];
        
        //    self.messageImage.layer.masksToBounds = YES;
        //    self.messageImage.layer.cornerRadius = 5;
        
        self.messageImage.image = kImageNamed(@"信息弹出框");
        
        self.headImage.layer.masksToBounds = YES;
        self.headImage.layer.cornerRadius = 24;
        self.headImage.layer.borderWidth = 3;
        self.headImage.layer.borderColor = kRGB(255, 193, 7).CGColor;
    }
    
    return self;
}

@end
