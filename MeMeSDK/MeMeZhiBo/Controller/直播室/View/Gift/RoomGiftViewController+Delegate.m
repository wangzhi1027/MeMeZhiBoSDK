//
//  RoomGiftViewController+Delegate.m
//  memezhibo
//
//  Created by Xingai on 15/6/12.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "RoomGiftViewController+Delegate.h"

@implementation RoomGiftViewController (Delegate)

//UICollectionView被选中时调用的方法
-(void)collectionView:(PSUICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    self.currentSelectedGift = [self currentGift:indexPath];
    
    self.gifttextView.giftName.text = [self.currentSelectedGift.name stringByUnescapingFromHTML];
    
}

#pragma mark - ScrollSegmentDelegate

- (void)selectItem:(NSInteger)index
{
    self.currentSelectedIndex = index;
    [self.giftsCV reloadData];
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == kAlertViewCancelButtonIndex)
    {
        return;
    }
    
    switch (alertView.tag)
    {
        case kAlertViewCharge:
            [self.uiManager showChargeUI:self];
            break;
            
        default:
            break;
    }
}

@end
