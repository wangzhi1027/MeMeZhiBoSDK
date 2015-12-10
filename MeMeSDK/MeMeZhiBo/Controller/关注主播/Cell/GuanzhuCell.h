//
//  GuanzhuCell.h
//  memezhibo
//
//  Created by Xingai on 15/6/25.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GuanzhuCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UIImageView *HeadImage;
@property (nonatomic, strong) IBOutlet UIImageView *AnchorLevelImage;
@property (nonatomic, strong) IBOutlet UILabel *name;
@property (nonatomic, strong) IBOutlet UIImageView *liveImage;

- (void)setAnchorUserLevelImage:(NSUInteger)count;

@end
