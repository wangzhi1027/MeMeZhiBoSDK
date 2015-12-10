//
//  RoomGiftViewController+Datasource.m
//  memezhibo
//
//  Created by Xingai on 15/6/12.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "RoomGiftViewController+Datasource.h"

@implementation RoomGiftViewController (Datasource)

-(NSInteger)numberOfSectionsInCollectionView:(PSUICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(PSUICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.currentSelectedIndex > self.giftCategories.count) {
        return 0;
    } else if (self.currentSelectedIndex == self.giftCategories.count) {
        return [[self.giftsDictionary valueForKey:@"背包"] count];
    }
    NSDictionary *categoryDict = self.giftCategories[self.currentSelectedIndex];
    TTShowGiftCategory *category = [[TTShowGiftCategory alloc] initWithAttributes:categoryDict];
    return [[self.giftsDictionary valueForKey:[NSString stringWithFormat:@"%lu", (unsigned long)category._id]] count];

}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (PSUICollectionViewCell *)collectionView:(PSUICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GiftListCell *giftsCell = (GiftListCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"GiftlistCellID" forIndexPath:indexPath];
    
    TTShowGift *gift = [self currentGift:indexPath];
    
    
    if (gift != nil)
    {
        BOOL isBagGift = giftsCell.countLabel.hidden = self.currentSelectedIndex >= self.giftCategories.count;
        
        
        [giftsCell setTitleText:gift.name];
        giftsCell.coinPriceLabel.text = isBagGift ? [NSString stringWithFormat:@"免费(%lu柠檬)", (unsigned long)gift.coin_price] : [NSString stringWithFormat:@"%lu柠檬", (unsigned long)gift.coin_price];
        [giftsCell setGiftImage:gift.pic_url];
        
        giftsCell.countLabel.hidden = !isBagGift;

        
        
        giftsCell.countLabel.text = [NSString stringWithFormat:@"*%d", (int)gift.count];
        
//        if (gift.isHot) {
//            giftsCell.hotImage.hidden = NO;
//            giftsCell.hotImage.image = kImageNamed(@"hot");
//        }
//        else if (gift.isNew)
//        {
//            giftsCell.hotImage.hidden = NO;
//            giftsCell.hotImage.image = kImageNamed(@"new");
//        }
//        else
//        {
//            giftsCell.hotImage.hidden = YES;
//        }
        
    }
    
    return giftsCell;

}

@end
