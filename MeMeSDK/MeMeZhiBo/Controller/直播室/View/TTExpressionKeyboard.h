//
//  TTExpressionKeyboard.h
//  TTShow
//
//  Created by twb on 13-6-17.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@class TTPageControl;

@protocol TTExpresionDelegate;

@interface TTExpressionKeyboard : UIView <UIScrollViewDelegate>
{
    NSMutableArray *_emojiArray;
    NSArray *_symbolArray;
}

//@property (strong, nonatomic) UIButton *sendMessageButton;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) TTPageControl *pageControl;

@property (nonatomic, assign) NSInteger pageCount;

@property (weak, nonatomic) id<TTExpresionDelegate> delegate;

@property (nonatomic, strong) UIButton *sendBtn;

@end

@protocol TTExpresionDelegate<NSObject>
@optional

- (void)didTouchExpressionView:(TTExpressionKeyboard*)expressionView touchedExpression:(NSString*)string flag:(NSInteger)flag;
- (void)didDeleteExpressionView:(TTExpressionKeyboard*)expressionView;
- (void)sendMessage;

@end


