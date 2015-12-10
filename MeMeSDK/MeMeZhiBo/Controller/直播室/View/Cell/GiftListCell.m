//
//  GiftListCell.m
//  memezhibo
//
//  Created by Xingai on 15/6/10.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "GiftListCell.h"

@implementation GiftListCell

- (void)awakeFromNib {
    
    self.bg.hidden = YES;
    self.hotImage.hidden = YES;
    
    
    self.selectedBackgroundView = [[UIImageView alloc] initWithImage:kImageNamed(@"Rectangle 2428")];
    
    self.selectedBackgroundView.frame = CGRectMake(-3, -1, 86, 85);
    
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        
        self.GiftImageView = [[UIImageView alloc] initWithFrame:kCGRectMake(25, 10, 30, 30)];
        [self addSubview:self.GiftImageView];
        
    }
    
    return self;
}

#pragma mark - set part.

- (void)setGiftImage:(NSString *)urlString
{
    [[UIGlobalKit sharedInstance] setImageAnimationLoading:self.GiftImageView WithSource:urlString cache:NO];
}

- (void)setTitleText:(NSString *)text
{
    self.nameLabel.text = text;
}

- (void)setCoinPriceText:(NSUInteger)count
{
    self.coinPriceLabel.text = [NSString stringWithFormat:@"%lu柠檬", (unsigned long)count];
}

@end
