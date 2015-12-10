//
//  TTShowScrollSegment.h
//  TTShow
//
//  Created by twb on 13-8-5.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ScrollSegmentDelegate <NSObject>
- (void)selectItem:(NSInteger)index;
@end

@interface TTShowScrollSegment : UIView <UIScrollViewDelegate>
{
    NSMutableArray *itemButtons;
}

// UI
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *bg;
//@property (weak, nonatomic) IBOutlet UIImageView *left;
//@property (weak, nonatomic) IBOutlet UIImageView *right;

// Data.
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, assign) NSInteger selectedIndex;

@property (nonatomic, strong) NSString *normalBgStr;
@property (nonatomic, strong) NSString *selectedBgStr;

@property (nonatomic, assign) UIEdgeInsets normalImagesInset;
@property (nonatomic, assign) UIEdgeInsets selectedImagesInset;

@property (nonatomic, weak) id<ScrollSegmentDelegate> delegate;

@end
