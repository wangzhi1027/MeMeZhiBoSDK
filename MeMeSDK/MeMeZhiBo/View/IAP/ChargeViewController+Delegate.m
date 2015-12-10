//
//  ChargeViewController+Delegate.m
//  TTShow
//
//  Created by twb on 13-7-19.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import "ChargeViewController+Delegate.h"

@implementation ChargeViewController (Delegate)

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section)
    {
        case kChargeSectionRemain:
            // do nothing.
            break;
        case kChargeSectionRemote:
        {
            if (!self.iapHelp)
            {
                return;
            }
            
            if (self.iapHelp.purchasing)
            {
                return;
            }
            
            if (indexPath.row < self.productList.count)
            {
                [self showProgress:@"购买中,请稍候..." animated:YES];
                
                // Buying.
                SKProduct *skProduct = self.productList[indexPath.row];
                [self.iapHelp buyProduct:skProduct];
            }
            else
            {
                [[UIGlobalKit sharedInstance] showMessage:@"连接App Store失败，请稍后再试" in:self disappearAfter:2.0f];
            }
        }
            break;
        default:
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == kChargeSectionRemain)
    {
        return 44.0f;
    }
    else if (indexPath.section == kChargeSectionRemote)
    {
        return 50.0f;
    }
    return 0.0f;
}

@end
