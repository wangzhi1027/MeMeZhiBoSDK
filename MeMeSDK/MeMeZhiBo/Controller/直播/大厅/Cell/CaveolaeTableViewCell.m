//
//  CaveolaeTableViewCell.m
//  memezhibo
//
//  Created by Xingai on 15/5/22.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "CaveolaeTableViewCell.h"
#import "NSBundle+SDK.h"

#define  kMainCellViewOnoX          8
#define  kMainCellViewTwoX          16+kMainCellViewWidth


#define  kMainCellViewY             39

#define  kMainCellViewTwoy        47+kMainCellViewWidth

#define  kMainCellViewWidth         (kScreenWidth-24)/2

@implementation CaveolaeTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        
        
        [self initWithMainCell:self.RecommendedAnchorView1 hintView:self.hintView1 originX:kMainCellViewOnoX originY:kMainCellViewY width:kMainCellViewWidth height:kMainCellViewWidth imageTag:kMainCellImage1];
        
        [self initWithMainCell:self.RecommendedAnchorView2 hintView:self.hintView2 originX:kMainCellViewTwoX originY:kMainCellViewY width:kMainCellViewWidth height:kMainCellViewWidth imageTag:kMainCellImage2];
        
        [self initWithMainCell:self.RecommendedAnchorView3 hintView:self.hintView3 originX:kMainCellViewOnoX originY:kMainCellViewTwoy width:kMainCellViewWidth height:kMainCellViewWidth imageTag:kMainCellImage3];
        
        [self initWithMainCell:self.RecommendedAnchorView3 hintView:self.hintView4 originX:kMainCellViewTwoX originY:kMainCellViewTwoy width:kMainCellViewWidth height:kMainCellViewWidth imageTag:kMainCellImage4];
    }
    
    return self;
}

-(IBAction)XiaowoViewControllerPush:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(pushXinren)]) {
        [self.delegate pushXinren];
    }
}

- (void)setContentWithxinrenList1:(TTShowRoom *)xinrenList1 xinrenList2:(TTShowRoom *)xinrenList2 xinrenList3:(TTShowRoom *)xinrenList3 xinrenList4:(TTShowRoom *)xinrenList4
{
    MainCell *cell1 = (MainCell*)[self viewWithTag:kMainCellImage1];
    MainCell *cell2 = (MainCell*)[self viewWithTag:kMainCellImage2];
    MainCell *cell3 = (MainCell*)[self viewWithTag:kMainCellImage3];
    MainCell *cell4 = (MainCell*)[self viewWithTag:kMainCellImage4];
    
    [self setRecommendation:cell1 recommendation:xinrenList1];
    [self setRecommendation:cell2 recommendation:xinrenList2];
    [self setRecommendation:cell3 recommendation:xinrenList3];
    [self setRecommendation:cell4 recommendation:xinrenList4];
}



-(void)setRecommendation:(MainCell*)view recommendation:(TTShowRoom *)room
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
        if(room.gift_week != nil)
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
    hintView.tag = RecommendationView.tag +kTempTag;
    
    RecommendationView.starImage.image = [UIImage imageNamed:@"Resources.bundle/pics/主播默认图.png"];
    
    [self addSubview:hintView];
}

- (void)tapImage:(UITapGestureRecognizer *)sender
{
    UIView *hintview = (UIView*)[self viewWithTag:sender.view.tag+kTempTag];
    hintview.alpha = 0.3;
    
    [self.delegate doSelectCaveoCell:self tag:sender.view.tag];
}

- (void)deselectCellWithAnimated:(BOOL)animated
{
    UIView *hintView1 = (UIView*)[self viewWithTag:kMainCellImage1+kTempTag];
    UIView *hintView2 = (UIView*)[self viewWithTag:kMainCellImage2+kTempTag];
    UIView *hintView3 = (UIView*)[self viewWithTag:kMainCellImage3+kTempTag];
    UIView *hintView4 = (UIView*)[self viewWithTag:kMainCellImage4+kTempTag];
    
    if (animated)
    {
        [UIView animateWithDuration:0.25f animations:^{
            hintView1.alpha = 0;
            hintView2.alpha = 0;
            hintView3.alpha = 0;
            hintView4.alpha = 0;
        }];
    }
    else
    {
        hintView1.alpha = 0;
        hintView2.alpha = 0;
        hintView3.alpha = 0;
        hintView4.alpha = 0;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
