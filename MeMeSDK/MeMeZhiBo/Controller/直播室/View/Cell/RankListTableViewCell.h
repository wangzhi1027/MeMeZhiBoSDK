//
//  RankListTableViewCell.h
//  memezhibo
//
//  Created by Xingai on 15/5/26.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RankListTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UIImageView *RankProjectImage;
@property (nonatomic, weak) IBOutlet UILabel *label;
@property (nonatomic, weak) IBOutlet UILabel *numberLabel;
@property (nonatomic, weak) IBOutlet UIImageView *RankingImage;
@property (nonatomic, weak) IBOutlet UIButton *jtBtn;
@property (nonatomic, weak) IBOutlet UILabel *Additional;
@end
