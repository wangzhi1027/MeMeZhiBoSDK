//
//  AnchorTableViewCell.m
//  memezhibo
//
//  Created by Xingai on 15/5/22.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "AnchorTableViewCell.h"
#import "UIGlobalKit.h"
#import "NSBundle+SDK.h"

#define  kMainCellViewOnoX          8.0f
#define  kMainCellViewTwoX          (16.0f+kMainCellViewMaxWidth)
#define  kMainCellViewThreeX        (16.0f+kMainCellViewMaxWidth)
#define  kMainCellViewFourX         (16.0f+kMainCellViewMaxWidth)
#define  kMainCellViewFiveX         (16.0f+kMainCellViewMinWidth)
#define  kMainCellViewSixX          8.0f

#define  kMainCellViewOnoY          40.0f
#define  kMainCellViewTwoY          40.0f
#define  kMainCellViewThreeY        49.0+kMainCellViewMinWidth
#define  kMainCellViewFourY         (49.0+kMainCellViewMaxWidth)
#define  kMainCellViewFiveY         (49.0+kMainCellViewMaxWidth)
#define  kMainCellViewSixY          (49.0+kMainCellViewMaxWidth)


#define  kMainCellViewMaxWidth      (2*kMainCellViewMinWidth+8)
#define  kMainCellViewMinWidth      (kScreenWidth-32)/3



@implementation AnchorTableViewCell

- (void)awakeFromNib {
    
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        
        
        [self initWithMainCell:self.RecommendedAnchorView1 hintView:self.hintView1 originX:kMainCellViewOnoX originY:kMainCellViewOnoY width:kMainCellViewMaxWidth height:kMainCellViewMaxWidth imageTag:kMainCellMaxImage];
    
        
        [self initWithMainCell:self.RecommendedAnchorView2 hintView:self.hintView2 originX:kMainCellViewTwoX originY:kMainCellViewTwoY width:kMainCellViewMinWidth height:kMainCellViewMinWidth imageTag:kMainCellMinImageOno];
        
        
        [self initWithMainCell:self.RecommendedAnchorView3 hintView:self.hintView3 originX:kMainCellViewThreeX originY:kMainCellViewThreeY width:kMainCellViewMinWidth height:kMainCellViewMinWidth imageTag:kMainCellMinImageTo];
        
        [self initWithMainCell:self.RecommendedAnchorView4 hintView:self.hintView4 originX:kMainCellViewFourX originY:kMainCellViewFourY width:kMainCellViewMinWidth height:kMainCellViewMinWidth imageTag:kMainCellMinImageThree];
        
        [self initWithMainCell:self.RecommendedAnchorView5 hintView:self.hintView5 originX:kMainCellViewFiveX originY:kMainCellViewFiveY width:kMainCellViewMinWidth height:kMainCellViewMinWidth imageTag:kMainCellMinImageFour];
        
        
        [self initWithMainCell:self.RecommendedAnchorView6 hintView:self.hintView6 originX:kMainCellViewSixX originY:kMainCellViewSixY width:kMainCellViewMinWidth height:kMainCellViewMinWidth imageTag:kMainCellMinImageFive];
    }
    
    return self;
}

-(IBAction)TuijianViewControllerPush:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(tuijianListPush)]) {
        [self.delegate tuijianListPush];
    }
}

- (void)setContentWithRecommendation1:(TTShowRecommendation *)recommendation1 recommendation2:(TTShowRecommendation *)recommendation2 recommendation3:(TTShowRecommendation *)recommendation3 recommendation4:(TTShowRecommendation *)recommendation4 recommendation5:(TTShowRecommendation *)recommendation5 recommendation6:(TTShowRecommendation *)recommendation6
{
    MainCell *cell1 = (MainCell*)[self viewWithTag:kMainCellMaxImage];
    MainCell *cell2 = (MainCell*)[self viewWithTag:kMainCellMinImageOno];
    MainCell *cell3 = (MainCell*)[self viewWithTag:kMainCellMinImageTo];
    MainCell *cell4 = (MainCell*)[self viewWithTag:kMainCellMinImageThree];
    MainCell *cell5 = (MainCell*)[self viewWithTag:kMainCellMinImageFour];
    MainCell *cell6 = (MainCell*)[self viewWithTag:kMainCellMinImageFive];

    
    
    [self setRecommendation:cell1 recommendation:recommendation1];
    [self setRecommendation:cell2 recommendation:recommendation2];
    [self setRecommendation:cell3 recommendation:recommendation3];
    [self setRecommendation:cell4 recommendation:recommendation4];
    [self setRecommendation:cell5 recommendation:recommendation5];
    [self setRecommendation:cell6 recommendation:recommendation6];
    
}

-(void)setRecommendation:(MainCell*)view recommendation:(TTShowRecommendation *)recommendation
{
    [[UIGlobalKit sharedInstance] setImageAnimationLoading:view.starImage WithSource:recommendation.pic_url];
    
    
    view.title.text = [recommendation.nick_name stringByUnescapingFromHTML];
    if (view.tag!=kMainCellMaxImage) {
        view.title.font = [UIFont boldSystemFontOfSize:12];
    }
    
    view.audienceImage.image = kImageNamed(recommendation.live ? @"img_audience_live.png" : @"img_audience.png");
    if (recommendation.live)
    {
        view.audiences.text = [NSString stringWithFormat:@"%lli", [DataGlobalKit shamVistorCount:recommendation.visiter_count]];
    }
    else
    {
        view.audiences.text = @"休息中...";
    }
    
    
    view.weekStar.hidden = NO;//(room1.gift_week == nil);
    
    long long int timeStamp1 = [DataGlobalKit filterTimeStampWithInteger:recommendation.found_time];
    NSDate *pastDate1 = [NSDate dateWithTimeIntervalSince1970:timeStamp1];
    NSTimeInterval diff1 = [[NSDate date] timeIntervalSinceDate:pastDate1];
    if(ABS(diff1) >= kOneWeekSeconds)
    {
        if(recommendation.gift_week != nil)
            [view.weekStar setImage:kImageNamed(@"周星.png")];
        else
            view.weekStar.hidden = YES;
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
    hintView.tag = RecommendationView.tag + kTempTag;
    
    RecommendationView.starImage.image = [UIImage imageNamed:@"Resources.bundle/pics/主播默认图.png"];
    
    [self addSubview:hintView];
}

- (void)tapImage:(UITapGestureRecognizer *)sender
{
    UIView *hintview = (UIView*)[self viewWithTag:sender.view.tag+kTempTag];
    hintview.alpha = 0.3;
    
    [self.delegate doSelectRoomCell:self tag:sender.view.tag];
}

- (void)deselectCellWithAnimated:(BOOL)animated
{
    UIView *hintView1 = (UIView*)[self viewWithTag:kMainCellMaxImage+kTempTag];
    UIView *hintView2 = (UIView*)[self viewWithTag:kMainCellMinImageOno+kTempTag];
    UIView *hintView3 = (UIView*)[self viewWithTag:kMainCellMinImageTo+kTempTag];
    UIView *hintView4 = (UIView*)[self viewWithTag:kMainCellMinImageThree+kTempTag];
    UIView *hintView5 = (UIView*)[self viewWithTag:kMainCellMinImageFour+kTempTag];
    UIView *hintView6 = (UIView*)[self viewWithTag:kMainCellMinImageFive+kTempTag];
    
    if (animated)
    {
        [UIView animateWithDuration:0.25f animations:^{
            hintView1.alpha = 0;
            hintView2.alpha = 0;
            hintView3.alpha = 0;
            hintView4.alpha = 0;
            hintView5.alpha = 0;
            hintView6.alpha = 0;
        }];
    }
    else
    {
        hintView1.alpha = 0;
        hintView2.alpha = 0;
        hintView3.alpha = 0;
        hintView4.alpha = 0;
        hintView5.alpha = 0;
        hintView6.alpha = 0;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
