//
//  ChargeProductCell.h
//  TTShow
//
//  Created by twb on 13-7-19.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChargeProductCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *chargeBtn;
@property (weak, nonatomic) IBOutlet UILabel *chargeLabel;
@property (weak, nonatomic) IBOutlet UILabel *productName;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widht;

- (void)setProductNameText:(NSString *)text;
- (void)setProductPriceText:(NSString *)text;

@end
