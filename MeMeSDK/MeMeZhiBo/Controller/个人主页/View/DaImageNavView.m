//
//  DaImageNavView.m
//  memezhibo
//
//  Created by Xingai on 15/7/20.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "DaImageNavView.h"
#import "NSBundle+SDK.h"

@implementation DaImageNavView

-(id)init
{
    if (self = [super init])
    {
        self = [[[NSBundle SDKResourcesBundle]loadNibNamed:@"DaImageNavView" owner:self options:nil] lastObject];
        
        self.backBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -11, 0, 0);
        self.backgroundColor = kRGBA(0, 0, 0, 0.3);
    }
    
    return self;
}

-(IBAction)back:(id)sender
{
    [self.delegate daImageBack];
}

@end
