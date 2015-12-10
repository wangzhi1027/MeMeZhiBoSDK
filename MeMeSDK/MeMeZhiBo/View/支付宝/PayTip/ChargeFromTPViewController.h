//
//  ChargeFromTPViewController.h
//  TTShow
//
//  Created by twb on 13-11-21.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import <UIKit/UIKit.h>

// pre declaration.
@class ChargeRemainView;

@interface ChargeFromTPViewController : UIViewController

@property (nonatomic, assign) BOOL enterFromPush;

@property (nonatomic, weak) ChargeRemainView *remainHeader;
@property (nonatomic, strong) UITableView *chargeView;

@end
