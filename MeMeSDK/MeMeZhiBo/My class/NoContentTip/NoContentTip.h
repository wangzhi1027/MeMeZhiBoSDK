//
//  NoContentTip.h
//  TTShow
//
//  Created by twb on 13-9-25.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoContentTip : UIView

@property (weak, nonatomic) IBOutlet UILabel *tip;

- (void)setTipText:(NSString *)text;

@end
