//
//  DaImageTabView.h
//  memezhibo
//
//  Created by Xingai on 15/7/20.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DaImageTabView : UIView

@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *timeLabel;
@property (nonatomic, weak) IBOutlet UIImageView *djImage;
@property (nonatomic, weak) IBOutlet UIView *djView;
@property (nonatomic, weak) IBOutlet UILabel *numLabel;

@end
