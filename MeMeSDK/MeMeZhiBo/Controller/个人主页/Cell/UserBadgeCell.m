//
//  UserBadgeCell.m
//  TTShow
//
//  Created by twb on 14-5-14.
//  Copyright (c) 2014年 twb. All rights reserved.
//

#import "UserBadgeCell.h"

@interface UserBadgeCell ()

@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *detail;
@property (weak, nonatomic) IBOutlet UILabel *expired;

@end

@implementation UserBadgeCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setBadgeImage:(NSString *)string
{
    [[UIGlobalKit sharedInstance] setImageAnimationLoading:self.image WithSource:string];
}

- (void)setTitleText:(NSString *)text
{
    self.title.text = text;
}

- (void)setRemainTimeText:(NSString *)text
{
    [self setExpiredText:text];
}

- (void)setExpiredText:(NSString *)text
{
    CGFloat titleLength = [[DataGlobalKit sharedInstance] getLabelLength:self.title.text fontSize:15.0f];
    CGRect expireFrame = self.expired.frame;
    expireFrame.origin.x = self.title.frame.origin.x + titleLength + 5.0f;
    self.expired.frame = expireFrame;
    
    self.expired.text = text;
}

- (void)setDetailText:(NSString *)text
{
    self.detail.text = text;
}

@end
