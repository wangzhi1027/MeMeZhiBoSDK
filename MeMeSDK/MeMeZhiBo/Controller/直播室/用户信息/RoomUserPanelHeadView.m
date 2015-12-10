//
//  RoomUserPanelHeadView.m
//  memezhibo
//
//  Created by Xingai on 15/6/23.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "RoomUserPanelHeadView.h"
#import "NSBundle+SDK.h"

@implementation RoomUserPanelHeadView

-(id)init
{
    if (self = [super init])
    {
        self = [[[NSBundle SDKResourcesBundle]loadNibNamed:@"RoomUserPanelHeadView" owner:self options:nil] lastObject];
        self.headImage.layer.masksToBounds = YES;
        self.headImage.layer.cornerRadius = 24;
        
        self.backgroundColor = kRGB(43, 41, 43);
    }
    return self;
}


@end
