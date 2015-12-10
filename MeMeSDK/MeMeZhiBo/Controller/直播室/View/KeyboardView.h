//
//  KeyboardView.h
//  memezhibo
//
//  Created by Xingai on 15/6/9.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol sendDelegate <NSObject>

-(void)sendBtnDelegate:(id)sender;

-(void)giftLtstBtnClick:(id)sender;

-(void)ExpressionListShow:(id)sender;

-(void)Whisper:(BOOL)selected;

-(void)AndWho:(id)sender;

-(void)headImageClick:(id)sender;

@end

@interface KeyboardView : UIView

@property (nonatomic, weak) IBOutlet UITextField *textField;
@property (nonatomic, weak) IBOutlet UIImageView *headImage;
@property (nonatomic, weak) IBOutlet UIImageView *BottomImage;
@property (nonatomic, weak) IBOutlet UIButton *ExpressionBtn;
@property (nonatomic, weak) IBOutlet UIButton *whisperBtn;

@property (nonatomic, weak) IBOutlet UIButton *myBtn;
@property (nonatomic, weak) IBOutlet UIButton *sendBtn;


@property (nonatomic, weak) id<sendDelegate>delegate;

@end
