//
//  PayMethodCell.h
//  TTShow
//
//  Created by twb on 13-11-25.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PayMethodCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *subTitle;

- (void)setTitleText:(NSString *)text;
- (void)setSubTitleText:(NSString *)text;

@end
