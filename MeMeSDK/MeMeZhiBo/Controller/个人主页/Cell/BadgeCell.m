//
//  BadgeCell.m
//  memezhibo
//
//  Created by XIN on 15/10/27.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "BadgeCell.h"
#import "TTShowBadge.h"

@interface BadgeCell ()

//@property (weak, nonatomic) IBOutlet UILabel *noBadgeTip;
//@property (weak, nonatomic) IBOutlet UIImageView *arrow;

@property (weak, nonatomic) IBOutlet UIImageView *badge1;
@property (weak, nonatomic) IBOutlet UIImageView *badge2;
@property (weak, nonatomic) IBOutlet UIImageView *badge3;
@property (weak, nonatomic) IBOutlet UIImageView *badge4;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *honorLeadingConstraint;

@end

@implementation BadgeCell

- (void)awakeFromNib {
    // Initialization code
//    if (IS_IPHONE_6P) {
//        self.honorLeadingConstraint.constant = 20.f;
//    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - Public Methods

- (void)setBadges:(NSArray *)badges
{
    if (badges.count == 0)
    {
        return;
    }
    
    switch (badges.count)
    {
        case 1:
        {
            self.badge1.hidden = NO;
            self.badge2.hidden = YES;
            self.badge3.hidden = YES;
            self.badge4.hidden = YES;
            
            TTShowBadge *badge = badges[0];
            [[UIGlobalKit sharedInstance] setImageAnimationLoading:self.badge1 WithSource:badge.award ? badge.pic_url : badge.grey_pic];
        }
            break;
        case 2:
        {
            self.badge1.hidden = NO;
            self.badge2.hidden = NO;
            self.badge3.hidden = YES;
            self.badge4.hidden = YES;
            
            TTShowBadge *userBadge1 = badges[0];
            [[UIGlobalKit sharedInstance] setImageAnimationLoading:self.badge1 WithSource:userBadge1.award ? userBadge1.pic_url : userBadge1.grey_pic];
            
            TTShowBadge *userBadge2 = badges[1];
            [[UIGlobalKit sharedInstance] setImageAnimationLoading:self.badge2 WithSource:userBadge2.award ? userBadge2.pic_url : userBadge2.grey_pic];
        }
            break;
        case 3:
        {
            self.badge1.hidden = NO;
            self.badge2.hidden = NO;
            self.badge3.hidden = NO;
            self.badge4.hidden = YES;
            
            TTShowBadge *userBadge1 = badges[0];
            [[UIGlobalKit sharedInstance] setImageAnimationLoading:self.badge1 WithSource:userBadge1.award ? userBadge1.pic_url : userBadge1.grey_pic];
            
            TTShowBadge *userBadge2 = badges[1];
            [[UIGlobalKit sharedInstance] setImageAnimationLoading:self.badge2 WithSource:userBadge2.award ? userBadge2.pic_url : userBadge2.grey_pic];
            
            TTShowBadge *userBadge3 = badges[2];
            [[UIGlobalKit sharedInstance] setImageAnimationLoading:self.badge3 WithSource:userBadge3.award ? userBadge3.pic_url : userBadge3.grey_pic];
        }
            break;
        case 4:
        {
            self.badge1.hidden = NO;
            self.badge2.hidden = NO;
            self.badge3.hidden = NO;
            self.badge4.hidden = NO;
            
            TTShowBadge *userBadge1 = badges[0];
            [[UIGlobalKit sharedInstance] setImageAnimationLoading:self.badge1 WithSource:userBadge1.award ? userBadge1.pic_url : userBadge1.grey_pic];
            
            TTShowBadge *userBadge2 = badges[1];
            [[UIGlobalKit sharedInstance] setImageAnimationLoading:self.badge2 WithSource:userBadge2.award ? userBadge2.pic_url : userBadge2.grey_pic];
            
            TTShowBadge *userBadge3 = badges[2];
            [[UIGlobalKit sharedInstance] setImageAnimationLoading:self.badge3 WithSource:userBadge3.award ? userBadge3.pic_url : userBadge3.grey_pic];
            
            TTShowBadge *userBadge4 = badges[3];
            [[UIGlobalKit sharedInstance] setImageAnimationLoading:self.badge4 WithSource:userBadge4.award ? userBadge4.pic_url : userBadge4.grey_pic];
        }
            break;
        default:
        {
            self.badge1.hidden = NO;
            self.badge2.hidden = NO;
            self.badge3.hidden = NO;
            self.badge4.hidden = NO;
            
            TTShowBadge *userBadge1 = badges[0];
            [[UIGlobalKit sharedInstance] setImageAnimationLoading:self.badge1 WithSource:userBadge1.award ? userBadge1.pic_url : userBadge1.grey_pic];
            
            TTShowBadge *userBadge2 = badges[1];
            [[UIGlobalKit sharedInstance] setImageAnimationLoading:self.badge2 WithSource:userBadge2.award ? userBadge2.pic_url : userBadge2.grey_pic];
            
            TTShowBadge *userBadge3 = badges[2];
            [[UIGlobalKit sharedInstance] setImageAnimationLoading:self.badge3 WithSource:userBadge3.award ? userBadge3.pic_url : userBadge3.grey_pic];
            
            TTShowBadge *userBadge4 = badges[3];
            [[UIGlobalKit sharedInstance] setImageAnimationLoading:self.badge4 WithSource:userBadge4.award ? userBadge4.pic_url : userBadge4.grey_pic];
            
//            TTShowBadge *userBadge5 = badges[4];
//            [[UIGlobalKit sharedInstance] setImageAnimationLoading:self.badge5 WithSource:userBadge5.award ? userBadge5.pic_url : userBadge5.grey_pic];
        }
            break;
    }
}

@end
