//
//  GiftListCell.h
//  memezhibo
//
//  Created by Xingai on 15/6/10.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GiftListCell : UICollectionViewCell

@property (nonatomic, weak) IBOutlet UIImageView *hotImage;

@property (nonatomic, strong) UIImageView *GiftImageView;

@property (nonatomic, weak) IBOutlet UILabel *nameLabel;

@property (nonatomic, weak) IBOutlet UILabel *coinPriceLabel;

//@property (strong, nonatomic)  UILabel *countLabel;

@property (weak, nonatomic) IBOutlet UIImageView *bg;

@property (weak, nonatomic) IBOutlet UIImageView *rightlineImage;

@property (weak, nonatomic) IBOutlet UIImageView *bottomLineImage;

@property (weak, nonatomic) IBOutlet UILabel *countLabel;

- (void)setTitleText:(NSString *)text;
- (void)setCoinPriceText:(NSUInteger)count;
- (void)setGiftImage:(NSString *)urlString;
@end
