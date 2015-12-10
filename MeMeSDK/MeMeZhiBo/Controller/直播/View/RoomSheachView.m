//
//  RoomSheachView.m
//  memezhibo
//
//  Created by Xingai on 15/8/28.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "RoomSheachView.h"
#import "NSBundle+SDK.h"

@implementation RoomSheachView

-(id)init
{
    self = [[[NSBundle SDKResourcesBundle]loadNibNamed:@"RoomSheachView" owner:self options:nil] lastObject];
    
    [self.sheach1 setBackgroundImage:kImageNamed(@"") forState:UIControlStateNormal];
    
    return self;
}

@end
