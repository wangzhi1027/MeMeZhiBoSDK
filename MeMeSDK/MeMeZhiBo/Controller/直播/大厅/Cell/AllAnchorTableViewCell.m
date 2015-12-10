//
//  AllAnchorTableViewCell.m
//  memezhibo
//
//  Created by Xingai on 15/5/22.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "AllAnchorTableViewCell.h"
#import "NSBundle+SDK.h"

#define  kAllAnchorMainCellViewOnoX          (8.0f)

#define  kAllAnchorMainCellViewTwoX          (16.0f+kAllAnchorMainCellViewWidth)

#define  kAllAnchorMainCellViewY             4.0

#define  kAllAnchorMainCellViewWidth         (kScreenWidth-24)/2



@implementation AllAnchorTableViewCell

- (void)awakeFromNib {
    
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        
        
        [self initWithMainCell:self.RecommendedAnchorView1 hintView:self.hintView1 originX:kAllAnchorMainCellViewOnoX originY:kAllAnchorMainCellViewY width:kAllAnchorMainCellViewWidth height:kAllAnchorMainCellViewWidth imageTag:kAllAnchorMainCellImage1];
        
        [self initWithMainCell:self.RecommendedAnchorView2 hintView:self.hintView2 originX:kAllAnchorMainCellViewTwoX originY:kAllAnchorMainCellViewY width:kAllAnchorMainCellViewWidth height:kAllAnchorMainCellViewWidth imageTag:kAllAnchorMainCellImage2];
        
    }
    
    return self;
}

- (void)setContentWithRoom1:(TTShowRoom *)room1 room2:(TTShowRoom *)room2
{
    MainCell *cell1 = (MainCell*)[self viewWithTag:kAllAnchorMainCellImage1];
    MainCell *cell2 = (MainCell*)[self viewWithTag:kAllAnchorMainCellImage2];
    
    if (room1) {
        cell1.hidden = NO;
        [self setRoomCell:cell1 room:room1];
    }else{
        cell1.hidden = YES;
    }
    if (room2) {
        cell2.hidden = NO;
        [self setRoomCell:cell2 room:room2];
    }else{
        cell2.hidden = YES;
    }
}

-(void)setRoomCell:(MainCell*)view room:(TTShowRoom *)room
{
    [[UIGlobalKit sharedInstance] setImageAnimationLoading:view.starImage WithSource:room.pic_url];
    
    
    view.title.text = [room.nick_name stringByUnescapingFromHTML];
    
    view.audienceImage.image = kImageNamed(room.live ? @"img_audience_live.png" : @"img_audience.png");
    if (room.live)
    {
        view.audiences.text = [NSString stringWithFormat:@"%lli", [DataGlobalKit shamVistorCount:room.visiter_count]];
    }
    else
    {
        view.audiences.text = @"休息中...";
    }
    
    view.weekStar.hidden = NO;//(room1.gift_week == nil);
    
    long long int timeStamp1 = [DataGlobalKit filterTimeStampWithInteger:room.found_time];
    NSDate *pastDate1 = [NSDate dateWithTimeIntervalSince1970:timeStamp1];
    NSTimeInterval diff1 = [[NSDate date] timeIntervalSinceDate:pastDate1];
    if(ABS(diff1) >= kOneWeekSeconds)
    {
        if(room.gift_week != nil){
            [view.weekStar setImage:kImageNamed(@"周星.png")];

        } else {
            view.weekStar.hidden = YES;
        }
    }else
    {
        [view.weekStar setImage:kImageNamed(@"新秀.png")];
    }
}


- (void)initWithMainCell:(MainCell*)RecommendationView hintView:(UIView*)hintView originX:(CGFloat)x originY:(CGFloat)y width:(CGFloat)wd height:(CGFloat)hg imageTag:(NSInteger)tag
{
    RecommendationView = [[MainCell alloc] init];
    
    RecommendationView = [[[NSBundle SDKResourcesBundle] loadNibNamed:@"MainCell" owner:self options:nil] lastObject];
    
    
    RecommendationView.layer.cornerRadius = 5;
    
    RecommendationView.layer.masksToBounds = YES;
    
    RecommendationView.frame = CGRectMake(x, y, wd, hg);
    
    
    RecommendationView.tag = tag;
    
    [self addSubview:RecommendationView];
    
    [RecommendationView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)]];
    
    hintView = [[UIView alloc] init];
    hintView.frame = RecommendationView.frame;
    hintView.backgroundColor = kImageClickColor;
    hintView.alpha = 0;
    
    RecommendationView.starImage.image = [UIImage imageNamed:@"Resources.bundle/pics/主播默认图"];
    
    
    hintView.tag = RecommendationView.tag +kTempTag;
    
    [self addSubview:hintView];
}

- (void)tapImage:(UITapGestureRecognizer *)sender
{
    UIView *hintview = (UIView*)[self viewWithTag:sender.view.tag+kTempTag];
    hintview.alpha = 0.3;
    
    [self.delegate doSelectAllAnchorCell:self tag:sender.view.tag];
}

- (void)deselectCellWithAnimated:(BOOL)animated
{
    UIView *hintView1 = (UIView*)[self viewWithTag:kAllAnchorMainCellImage1+kTempTag];
    UIView *hintView2 = (UIView*)[self viewWithTag:kAllAnchorMainCellImage2+kTempTag];
    
    if (animated)
    {
        [UIView animateWithDuration:0.25f animations:^{
            hintView1.alpha = 0;
            hintView2.alpha = 0;
        }];
    }
    else
    {
        hintView1.alpha = 0;
        hintView2.alpha = 0;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
