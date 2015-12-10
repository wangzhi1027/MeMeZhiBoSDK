//
//  ReportAlertview.m
//  memezhibo
//
//  Created by Xingai on 15/6/16.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "ReportAlertview.h"
#import "NSBundle+SDK.h"

@implementation ReportAlertview

-(id)init
{
    if (self = [super init])
    {
        self = [[[NSBundle SDKResourcesBundle]loadNibNamed:@"ReportAlertview" owner:self options:nil] lastObject];
        
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 8;
        
        
        self.CrossImage.image = [kImageNamed(@"礼物_横线") stretchableImageWithLeftCapWidth:1 topCapHeight:1];
        
        self.VerticalImage.image = [kImageNamed(@"礼物_竖线") stretchableImageWithLeftCapWidth:1 topCapHeight:1];
    }
    
    return self;
}

-(IBAction)cancel:(id)sender
{
    [self.delegate cancel];
}

-(IBAction)Dial:(id)sender
{
    [self.delegate Dial];
}

@end
