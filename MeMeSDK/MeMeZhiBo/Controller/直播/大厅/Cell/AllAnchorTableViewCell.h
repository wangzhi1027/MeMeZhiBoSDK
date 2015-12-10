//
//  AllAnchorTableViewCell.h
//  memezhibo
//
//  Created by Xingai on 15/5/22.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainCell.h"
#import "TTShowRoom.h"

typedef NS_ENUM(NSInteger, AllAnchorMainCellTag)
{
    kAllAnchorMainCellImage1 = 1000,
    kAllAnchorMainCellImage2,
};

@protocol AllAnchorMainCellImageDelegate <NSObject>

- (void)doSelectAllAnchorCell:(UITableViewCell *)cell tag:(NSInteger)tag;



@end

@interface AllAnchorTableViewCell : UITableViewCell

@property (nonatomic,strong)  MainCell *RecommendedAnchorView1;
@property (nonatomic,strong)  MainCell *RecommendedAnchorView2;
@property (nonatomic, weak) id<AllAnchorMainCellImageDelegate> delegate;


@property (nonatomic,strong)  UIView *hintView1;
@property (nonatomic,strong)  UIView *hintView2;

- (void)deselectCellWithAnimated:(BOOL)animated;
- (void)setContentWithRoom1:(TTShowRoom *)room1 room2:(TTShowRoom *)room2;

@end
