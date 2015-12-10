//
//  PersonalHomeCell.m
//  memezhibo
//
//  Created by Xingai on 15/7/8.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "PersonalHomeCell.h"

@implementation PersonalHomeCell

- (void)awakeFromNib {
    // Initialization code
    self.djView.layer.masksToBounds = YES;
    self.djView.layer.cornerRadius = 3.0f;
    
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 2.0f;
    self.layer.borderWidth = 0.2;
    self.layer.borderColor = kRGB(175, 175, 175).CGColor;
    self.backgroundColor = kWhiteColor;
    
    
    self.imageView.userInteractionEnabled = YES;

    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self.imageView addGestureRecognizer:tapGesture];
}

// Gesture event.
- (void)handleTap:(UITapGestureRecognizer *)sender
{
    [self.delegate imageClickWithCell:self];
}

@end
