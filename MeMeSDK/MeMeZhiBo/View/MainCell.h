//
//  MainCell.h
//  TTShow
//
//  Created by twb on 13-8-19.
//  Copyright (c) 2013年 twb. All rights reserved.
//


#define kMainCellImageWith   (151.0f)
#define kMainCellImageHeight (114.0f)

#define kMainCellWith        (151.0f)
#define kMainCellHeight      (150.0f)

@interface MainCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *starImage;
@property (weak, nonatomic) IBOutlet UIView *descContainer;
@property (weak, nonatomic) IBOutlet UIImageView *weekStar;

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *audiences;
@property (weak, nonatomic) IBOutlet UIImageView *audienceImage;
@property (weak, nonatomic) IBOutlet UILabel *follows;
@property (weak, nonatomic) IBOutlet UIImageView *followImage;
@property (weak, nonatomic) IBOutlet UIView *hintView;

- (void)setStarImageString:(NSString *)text;
- (void)setTitleText:(NSString *)text;

- (void)setAudiencesCount:(long long int)count;
- (void)setAudienceImageOn:(BOOL)on;
- (void)setFollowsCount:(long long int)count;
- (void)setFollowImageOn:(BOOL)on;

- (void)setHintedImage:(BOOL)selected;
- (void)setWeekStarHidden:(BOOL)hidden;
- (void)setNewStarHidden:(BOOL)hidden;

@end
