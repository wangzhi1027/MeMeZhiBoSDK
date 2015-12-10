//
//  RoominfoHead.m
//  memezhibo
//
//  Created by zhifeng on 15/6/19.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "RoominfoHead.h"
#import "NSBundle+SDK.h"

@implementation RoominfoHead

-(id)init
{
    if (self = [super init])
    {
        self = [[[NSBundle SDKResourcesBundle]loadNibNamed:@"RoominfoHead" owner:self options:nil] lastObject];
        self.headImage.layer.masksToBounds = YES;
        self.headImage.layer.cornerRadius = 24;
    }
    
    return self;
}

- (void)setLevelMyImage:(NSUInteger)levelCount
{
    // clear zero.
    self.sum = 0.0f;
    
    NSString *weatherLevlString = [[DataGlobalKit sharedInstance] wealthImageString:levelCount];
    self.levelImage.image = [UIImage sd_animatedGIFNamed:weatherLevlString];
    
    self.sum += (self.levelImage.frame.size.width + 5.0);
}

//- (void)setMyVipImageType:(MemberType)memberType
//{
//    self.vipImage.hidden = (memberType == kVIPNone);
//    
//    CGRect vipFrame = self.vipImage.frame;
//    self.vipImage.frame = CGRectMake(58.0f + self.sum,
//                                     vipFrame.origin.y,
//                                     vipFrame.size.width,
//                                     vipFrame.size.height);
//    
//    if (memberType != kVIPNone)
//    {
//        self.sum += (self.vipImage.frame.size.width + 5.0);
//    }
//    self.vipImage.image = kImageNamed([[DataGlobalKit sharedInstance] vipImageString:memberType]);
//}

- (void)setVipImageType:(MemberType)memberType
{
    self.vipImage.hidden = (memberType == kVIPNone);
    
    
    self.vipImage.image = kImageNamed([[DataGlobalKit sharedInstance] vipImageString:memberType]);
}

@end
