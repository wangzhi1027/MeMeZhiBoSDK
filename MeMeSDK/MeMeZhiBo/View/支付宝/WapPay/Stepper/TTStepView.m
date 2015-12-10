//
//  TTStepView.m
//  TTShow
//
//  Created by twb on 13-11-22.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import "TTStepView.h"

@implementation TTStepView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];

    // customize ui.
    
    self.finalValue = 1;
    
    [self updateValue];;
    
    [self.plus setBackgroundImage:kImageNamed(@"img_step_plus.png") forState:UIControlStateNormal];
    [self.minus setBackgroundImage:kImageNamed(@"img_step_minus_disable.png") forState:UIControlStateNormal];
    
    [self.value setBackground:[kImageNamed(@"img_step_edit.png") resizableImageWithCapInsets:UIEdgeInsetsMake(6.0f, 6.0f, 6.0f, 6.0f)]];
}

- (IBAction)minusAction:(id)sender
{
    self.finalValue--;
    
    if (self.finalValue <= 1)
    {
        self.finalValue = 1;
        [self updateValue];
        
        [self executeDelegate:self.finalValue];
        
        self.minusStatus = kStepperMinusDisable;
        [self updateMinusStatus];
        return;
    }
    
    self.minusStatus = kStepperMinusNormal;
    [self updateMinusStatus];
    
    [self executeDelegate:self.finalValue];
    
    [self updateValue];
}

- (IBAction)plusAction:(id)sender
{
    self.finalValue++;
    
    self.minusStatus = kStepperMinusNormal;
    [self updateMinusStatus];
    
    [self executeDelegate:self.finalValue];
    
    [self updateValue];
}

- (IBAction)stepValueChange:(id)sender
{
    UITextField *tf = (UITextField *)sender;
    self.finalValue = [tf.text integerValue];
    [self executeDelegate:[tf.text integerValue]];
}

- (void)executeDelegate:(NSInteger)count
{
    if (self.delegate)
    {
        [self.delegate stepChanged:count];
    }
}

- (void)updateValue
{
    self.value.text = [@(self.finalValue) stringValue];
}

- (void)updateMinusStatus
{
    switch (self.minusStatus) {
        case kStepperMinusDisable:
            [self.minus setBackgroundImage:kImageNamed(@"img_step_minus_disable.png") forState:UIControlStateNormal];
            break;
        case kStepperMinusNormal:
            [self.minus setBackgroundImage:kImageNamed(@"img_step_minus.png") forState:UIControlStateNormal];
            break;
        default:
            break;
    }
}

- (void)hideKeyboard
{
    if (self.value)
    {
        [self.value resignFirstResponder];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
