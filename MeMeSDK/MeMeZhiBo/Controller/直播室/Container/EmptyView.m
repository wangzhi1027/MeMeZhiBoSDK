//
//  EmptyView.m
//  memezhibo
//
//  Created by Xingai on 15/6/8.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "EmptyView.h"
#import "NSBundle+SDK.h"

@implementation EmptyView

-(id)init
{
    if (self = [super init])
    {
        self = [[[NSBundle SDKResourcesBundle]loadNibNamed:@"EmptyView" owner:self options:nil] lastObject];
    }
    
    return self;
}

@end
