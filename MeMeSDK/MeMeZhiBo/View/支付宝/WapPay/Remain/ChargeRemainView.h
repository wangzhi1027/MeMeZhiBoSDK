//
//  ChargeRemainView.h
//  TTShow
//
//  Created by twb on 13-11-22.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChargeRemainView : UIView

@property (weak, nonatomic) IBOutlet UILabel *remain;

- (void)setRemainCount:(long long int)count;

@end
