//
//  GiftTextView.m
//  memezhibo
//
//  Created by Xingai on 15/6/15.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "GiftTextView.h"
#import "NSBundle+SDK.h"

@implementation GiftTextView

-(id)init
{
    if (self = [super init])
    {
        self = [[[NSBundle SDKResourcesBundle]loadNibNamed:@"GiftTextView" owner:self options:nil] lastObject];
        
        self.GiveBtn.layer.masksToBounds = YES;
        self.GiveBtn.layer.cornerRadius = 3;
        self.giftNumberFild.keyboardType = UIKeyboardTypeNumberPad;
        
        self.giftNumberFild.textColor = kWhiteColor;
        
        self.giftNumberFild.keyboardAppearance = UIKeyboardAppearanceAlert;
        
        [self.giftNumberFild setValue:kWhiteColor forKeyPath:@"_placeholderLabel.textColor"];
    }
    
    return self;
}

-(IBAction)giftClick:(id)sender
{
    [self.delegate giftClick:sender];
}

@end
