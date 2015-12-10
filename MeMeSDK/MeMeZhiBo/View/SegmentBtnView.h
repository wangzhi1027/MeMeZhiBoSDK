//
//  SegmentBtnView.h
//  memezhibo
//
//  Created by Xingai on 15/6/3.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol segmentBtnClickDelegate <NSObject>

-(void)segmentBtnClick:(NSInteger)flag;

@end

@interface SegmentBtnView : UIView

@property (nonatomic, weak) IBOutlet UILabel *segmentLabel;
@property (nonatomic, weak) IBOutlet UIImageView *image;
@property (nonatomic, weak) id<segmentBtnClickDelegate>delegete;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *widht;

@end
