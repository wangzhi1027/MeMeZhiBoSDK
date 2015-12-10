//
//  MainCell.m
//  TTShow
//
//  Created by twb on 13-8-19.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import "MainCell.h"
#import "TTShowRecommendation.h"

@interface MainCell ()



@end

@implementation MainCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];

    self.layer.borderWidth = 0.3;
    self.layer.borderColor = kRGBA(202.0f, 202.0f, 202.0f, 0.8).CGColor;
    self.layer.cornerRadius = 5;
    
    self.starImage.layer.masksToBounds = YES;
    self.starImage.layer.cornerRadius = 4.0f;
    
    self.title.font = [UIFont boldSystemFontOfSize:14];
//    self.starImage.clipsToBounds = YES;
//    self.starImage.frame = CGRectMake(0.0f, 0.0f, 151.0f, 114.0f);
//    
//    self.title.textColor = kRGB(50.0f, 50.0f, 50.0f);
//    
//    self.audiences.textColor = kRGB(130.0f, 130.0f, 130.0f);
//    self.follows.textColor = kRGB(130.0f, 130.0f, 130.0f);
}

- (void)setSelected:(BOOL)selected
{
    [self setHintedImage:selected];
    [super setSelected:selected];
}

- (void)setHighlighted:(BOOL)highlighted
{
    [self setHintedImage:highlighted];
    [super setHighlighted:highlighted];
}

- (void)setHintedImage:(BOOL)selected
{
    if (selected)
    {
        self.hintView.alpha = 0.3f;
    }
    else
    {
        self.hintView.alpha = 0.0f;
    }
}

- (void)setStarImageString:(NSString *)text
{
    [[UIGlobalKit sharedInstance] setLoadingImage:self.starImage urlString:text size:CGSizeMake(kMainCellImageWith, kMainCellImageHeight) cache:YES];
}

- (void)setTitleText:(NSString *)text
{
    self.title.text = [text stringByUnescapingFromHTML];
}

- (void)setAudiencesCount:(long long int)count
{
    self.audiences.text = [NSString stringWithFormat:@"%lli", count];
}

- (void)setAudienceImageOn:(BOOL)on
{
    self.audienceImage.image = kImageNamed(on ? @"img_audience_live.png" : @"img_audience.png");
}

- (void)setFollowsCount:(long long int)count
{
    self.follows.text = [NSString stringWithFormat:@"%lli", count];
}

- (void)setFollowImageOn:(BOOL)on
{
    self.followImage.image = kImageNamed(on ? @"img_follow_yes.png" : @"img_follow_no.png");
}

- (void)setWeekStarHidden:(BOOL)hidden
{
    self.weekStar.hidden = hidden;
    
    if(!hidden)
        [self.weekStar setImage:kImageNamed(@"img_star_week.png")];
}

- (void)setNewStarHidden:(BOOL)hidden
{
    if (!self.weekStar.hidden)
    {
        [self.weekStar setImage:kImageNamed(@"img_star_week.png")];
    }
    else
    {
        if (!hidden) {
            [self.weekStar setImage:kImageNamed(@"img_star_new.png")];
        }
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
