//
//  KeyboardView.m
//  memezhibo
//
//  Created by Xingai on 15/6/9.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "KeyboardView.h"
#import "NSBundle+SDK.h"

@implementation KeyboardView

-(id)init
{
    if (self = [super init])
    {
        self = [[[NSBundle SDKResourcesBundle]loadNibNamed:@"KeyboardView" owner:self options:nil] lastObject];
        
        self.textField.backgroundColor = kRGB(246, 246, 246);
        
        self.textField.keyboardAppearance = UIKeyboardAppearanceAlert;
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 12, 16)];
        
        self.textField.leftView = view;
        self.textField.leftViewMode = UITextFieldViewModeAlways;
        self.textField.returnKeyType = UIReturnKeyDone;
        
        self.BottomImage.backgroundColor = kRGB(80, 72, 75);
        
        self.myBtn.layer.cornerRadius = 5;
        [self.myBtn setTitleColor:kRGBA(255, 255, 255 , 0.8) forState:UIControlStateNormal];
        
        self.sendBtn.layer.cornerRadius = 5;
        
        [self.sendBtn setBackgroundImage:kImageNamed(@"赠送按钮未激活") forState:UIControlStateNormal];
        
        
        self.headImage.layer.masksToBounds = YES;
        self.headImage.layer.borderWidth = 0.5;
        self.headImage.layer.borderColor = kRGBA(202.0f, 202.0f, 202.0f, 0.8).CGColor;
        self.headImage.layer.cornerRadius = 16;
        self.headImage.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        [self.headImage addGestureRecognizer:tapGesture];
        
        
        [self.whisperBtn setImage:kImageNamed(@"悄悄话按下") forState:UIControlStateSelected];
    }
    
    
    return self;
}

- (void)handleTap:(UITapGestureRecognizer *)sender
{
    [self.delegate headImageClick:sender];
}

//-(void)headImageClick:(id)sender
//{
//    
//}

-(IBAction)sendBtnClick:(id)sender
{
    [self.delegate sendBtnDelegate:sender];
}

-(IBAction)giftLtstBtnClick:(id)sender
{
    [self.delegate giftLtstBtnClick:sender];
}

-(IBAction)ExpressionListShow:(id)sender
{
    [self.delegate ExpressionListShow:sender];
}

-(IBAction)Whisper:(BOOL)selected
{
    [self.delegate Whisper:self.whisperBtn.selected];
}

-(IBAction)AndWho:(id)sender
{
    [self.delegate AndWho:sender];
}

@end
