//
//  PersonalPaimingView.h
//  memezhibo
//
//  Created by Xingai on 15/7/14.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonalPaimingView : UIView

@property(nonatomic, weak) IBOutlet UIImageView *leveImage;

@property(nonatomic, weak) IBOutlet UIImageView *anchorImage;

@property(nonatomic, weak) IBOutlet UIImageView *hengxianImage;

@property(nonatomic, weak) IBOutlet UILabel *leveNumbel;

@property(nonatomic, weak) IBOutlet UILabel *anchorNumbel;

@property(nonatomic, weak) IBOutlet UILabel *familyName;

@property(nonatomic, weak) IBOutlet UILabel *familyNumbel;

@property(nonatomic, weak) IBOutlet UIImageView *familyImage;

@property(nonatomic, weak) IBOutlet NSLayoutConstraint *widht;

@end
