//
//  RankingDetailsCell.h
//  memezhibo
//
//  Created by Xingai on 15/6/2.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RankingDetailsCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UIImageView *firstIcon;
@property (nonatomic, strong) IBOutlet UILabel *rankNumberLabel;
@property (nonatomic, strong) IBOutlet UIImageView *HeadImage;
@property (nonatomic, strong) IBOutlet UIImageView *LevelImage;
@property (nonatomic, strong) IBOutlet UIImageView *AnchorLevelImage;
@property (nonatomic, strong) IBOutlet UILabel *name;
@property (nonatomic, strong) IBOutlet UILabel *giftNumber;

@property (nonatomic, strong) IBOutlet UIImageView *liveImage;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *labelWidth;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *firstTop;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *rankNumberTop;

@property (nonatomic, strong) IBOutlet UILabel *count;
@property (nonatomic, strong) IBOutlet UILabel *label;

- (void)setUserLevelImage:(NSUInteger)count;

- (void)setAnchorUserLevelImage:(NSUInteger)count;

@end
