//
//  DaImageTabView.m
//  memezhibo
//
//  Created by Xingai on 15/7/20.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "DaImageTabView.h"
#import "NSBundle+SDK.h"

@implementation DaImageTabView

-(id)init
{
    if (self = [super init])
    {
        self = [[[NSBundle SDKResourcesBundle]loadNibNamed:@"DaImageTabView" owner:self options:nil] lastObject];
        
        self.backgroundColor = kRGBA(0, 0, 0, 0.3);
        
        //    self.djView.backgroundColor = kRGBA(255, 255, 255, 0.8);
        self.djView.backgroundColor = kRGBA(0, 0, 0, 0.8);
        
        self.djView.layer.masksToBounds = YES;
        self.djView.layer.cornerRadius = 2.0f;
    }
    
    return self;
}

@end
