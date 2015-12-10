//
//  TTStepView.h
//  TTShow
//
//  Created by twb on 13-11-22.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, StepperMinusStatus)
{
    kStepperMinusDisable = 0,
    kStepperMinusNormal,
    kStepperMinusMax
};

@protocol TTStepDelegate <NSObject>

- (void)stepChanged:(NSInteger)count;

@end

@interface TTStepView : UIView

@property (weak, nonatomic) IBOutlet UIButton *minus;
@property (weak, nonatomic) IBOutlet UIButton *plus;
@property (weak, nonatomic) IBOutlet UITextField *value;

@property (nonatomic, weak) id<TTStepDelegate> delegate;
@property (nonatomic, assign) NSInteger finalValue;
@property (nonatomic, assign) StepperMinusStatus minusStatus;

- (void)hideKeyboard;

@end
