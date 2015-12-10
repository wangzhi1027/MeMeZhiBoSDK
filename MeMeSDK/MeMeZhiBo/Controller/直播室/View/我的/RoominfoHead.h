//
//  RoominfoHead.h
//  memezhibo
//
//  Created by zhifeng on 15/6/19.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RoominfoHead : UIView

@property (nonatomic, weak) IBOutlet UIImageView *headImage;
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UIImageView *levelImage;
@property (nonatomic, weak) IBOutlet UIImageView *vipImage;
@property (nonatomic, weak) IBOutlet UIImageView *lNumberImage;
@property (nonatomic, assign) NSInteger sum;

- (void)setLevelMyImage:(NSUInteger)levelCount;

//- (void)setMyVipImageType:(MemberType)memberType;

- (void)setVipImageType:(MemberType)memberType;

@end
