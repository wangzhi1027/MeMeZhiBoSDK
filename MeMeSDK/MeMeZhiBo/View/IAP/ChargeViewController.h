//
//  ChargeViewController.h
//  TTShow
//
//  Created by twb on 13-7-18.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IAPHelper.h"
#import "ChargeProductCell.h"
#import "ChargeRemainCell.h"
#import "ProductModel.h"


typedef NS_ENUM(NSInteger, ChargeSectionType)
{
    kChargeSectionRemain = 0,
    kChargeSectionRemote,
    kChargeSectionMax
};

@interface ChargeViewController : BaseViewController

@property (nonatomic, strong) UITableView *chargeTableView;
@property (nonatomic, strong) NSMutableArray *products;
@property (nonatomic, strong) NSMutableArray *productList;
@property (nonatomic, strong) IAPHelper *iapHelp;
@property (nonatomic, assign) BOOL enterFromPush;
@property (nonatomic, assign) BOOL isWindowClosed;
@property (nonatomic, strong) NSString *currencyTypeName;
@property (nonatomic, strong) NSString *curTransactionIdentifier;

//- (BOOL)isDeviceJail;

@end
