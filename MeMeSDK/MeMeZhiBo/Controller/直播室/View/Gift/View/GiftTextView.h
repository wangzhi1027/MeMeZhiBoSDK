//
//  GiftTextView.h
//  memezhibo
//
//  Created by Xingai on 15/6/15.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol giftDelegate <NSObject>

-(void)giftClick:(id)sender;

@end

@interface GiftTextView : UIView

@property (weak, nonatomic) IBOutlet UIButton *GiveBtn;
@property (weak, nonatomic) IBOutlet UILabel *giftName;
@property (weak, nonatomic) IBOutlet UITextField *giftNumberFild;
@property (nonatomic, weak) id<giftDelegate>delegate;

@end
