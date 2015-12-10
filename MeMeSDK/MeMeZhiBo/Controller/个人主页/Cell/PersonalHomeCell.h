//
//  PersonalHomeCell.h
//  memezhibo
//
//  Created by Xingai on 15/7/8.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol personalImageDelegate <NSObject>

-(void)imageClickWithCell:(UICollectionViewCell*)cell;

@end

@interface PersonalHomeCell : UICollectionViewCell

@property(nonatomic,weak) IBOutlet UIImageView *imageView;
@property(nonatomic,weak) IBOutlet UIImageView *djImage;
@property(nonatomic,weak) IBOutlet UILabel *djLabel;
//@property(nonatomic,weak) IBOutlet UILabel *messageLabel; // V2.4.0 取消文字信息显示

@property(nonatomic,weak) IBOutlet UIView *djView;

@property(nonatomic,weak) id<personalImageDelegate>delegate;

@end
