//
//  GitfRankListCell.h
//  memezhibo
//
//  Created by Xingai on 15/6/10.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GitfRankListCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UIImageView *headImage;
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UIImageView *levelImageView;
@property (nonatomic, weak) IBOutlet UIImageView *vipImage;
@property (nonatomic, weak) IBOutlet UIImageView *AdminiImage;

@property (nonatomic, assign) CGFloat sum;

- (void)setLevelImage:(NSUInteger)levelCount;
- (void)setVipImageType:(MemberType)memberType;


@end
