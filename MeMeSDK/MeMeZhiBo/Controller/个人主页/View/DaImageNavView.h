//
//  DaImageNavView.h
//  memezhibo
//
//  Created by Xingai on 15/7/20.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol daNavDelegate <NSObject>

-(void)daImageBack;

@end


@interface DaImageNavView : UIView

@property (nonatomic, weak) IBOutlet UIButton *backBtn;

@property (nonatomic, weak) id<daNavDelegate>delegate;

@end
