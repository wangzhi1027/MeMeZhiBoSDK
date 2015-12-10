//
//  SearchBar.m
//  memezhibo
//
//  Created by Xingai on 15/6/1.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "SearchBar.h"
#import "NSBundle+SDK.h"

@implementation SearchBar

-(id)init
{
    self = [[[NSBundle SDKResourcesBundle]loadNibNamed:@"SearchBar" owner:self options:nil] lastObject];
    
    
    
    self.backgroundColor = kNavigationMainColor;
    
    self.image.image = [kImageNamed(@"搜索框背景") stretchableImageWithLeftCapWidth:14.f topCapHeight:14.f];
    
    
    self.field.placeholder = @"输入主播昵称关键字或房间号";
    [self.field setValue:[UIColor colorWithRed:255.0f green:255.0f blue:255.0f alpha:0.6] forKeyPath:@"_placeholderLabel.textColor"];
    [self.field setValue:[UIFont boldSystemFontOfSize:12] forKeyPath:@"_placeholderLabel.font"];
    self.field.returnKeyType = UIReturnKeySearch;
    
    self.cancelBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    
    
    self.clearBtn.hidden = YES;
    
    return self;
}

-(IBAction)cancell:(id)sender
{
    [self.delegate cancelView];
}

-(IBAction)cancellButton:(id)sender
{
    [self.delegate cancelButton];
}


@end
