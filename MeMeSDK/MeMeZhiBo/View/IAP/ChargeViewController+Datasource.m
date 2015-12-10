//
//  ChargeViewController+Datasource.m
//  TTShow
//
//  Created by twb on 13-7-19.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import "ChargeViewController+Datasource.h"


@implementation ChargeViewController (Datasource)

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return kChargeSectionMax;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == kChargeSectionRemain)
    {
        return 1;
    }
    else if (section == kChargeSectionRemote)
    {
        return self.products.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *kChargeProductCellReuseID = @"ChargeProductCellReuseID";
    static NSString *kChargeRemainCellReuseID = @"ChargeRemainCellReuseID";
    
    UITableViewCell *result;
    
    if (indexPath.section == kChargeSectionRemain)
    {
        ChargeRemainCell *cell = [tableView dequeueReusableCellWithIdentifier:kChargeRemainCellReuseID];
        
        if (!cell)
        {
            cell = [[ChargeRemainCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kChargeRemainCellReuseID];
        }
        
        [self.uiManager.global set4CornerBGCell:cell];
        
        result = cell;
    }
    else if (indexPath.section == kChargeSectionRemote)
    {
        ChargeProductCell *cell = [tableView dequeueReusableCellWithIdentifier:kChargeProductCellReuseID];
        
        if (!cell)
        {
            cell = [[ChargeProductCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kChargeProductCellReuseID];
        }
        
        if (indexPath.row == 0)
        {
            [self.uiManager.global setTopBGCell:cell];
        }
        else if (indexPath.row == self.products.count - 1)
        {
            [self.uiManager.global setBottomBGCell:cell];
        }
        else
        {
            [self.uiManager.global setCenterBGCell:cell];
        }
        
        if (indexPath.row < self.products.count)
        {

            ProductModel *skProduct = self.products[indexPath.row];
            
            NSArray *array = [skProduct.desc componentsSeparatedByString:@"柠檬"];
            
            NSDictionary *attributeDic1 = @{NSFontAttributeName:[UIFont systemFontOfSize:15.0f]};
            
            CGRect rect1 = [array[0] boundingRectWithSize:CGSizeMake(200, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine attributes:attributeDic1 context:nil];
            float width = rect1.size.width;
            cell.widht.constant = width;
            [cell.contentView needsUpdateConstraints];
            
            
            cell.productName.text = array[0];
            
            [cell setProductPriceText:[NSString stringWithFormat:@"%ld",skProduct.price]];
            
            
            
//            cell.chargeBtn.packetIndex = indexPath.row;
//            [cell.chargeBtn addTarget:self action:@selector(charge:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        result = cell;
    }
    
    return result;
}

- (void)charge:(PacketButton *)sender
{
    if (sender.packetIndex >= self.products.count)
    {
        return;
    }
    
    if (!self.iapHelp)
    {
        return;
    }

    if (self.iapHelp.purchasing)
    {
        return;
    }
    
    [self showProgress:@"购买中,请稍候..." animated:YES];
    
    // Buy
    SKProduct *skProduct = self.products[sender.packetIndex];
    [self.iapHelp buyProduct:skProduct];
    
}

@end
