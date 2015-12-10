//
//  noDataViewController.h
//  memezhibo
//
//  Created by Xingai on 15/7/2.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "BaseViewController.h"

@protocol noDataDelegate <NSObject>

-(void)checkNetWork;

@end

@interface noDataViewController : UIViewController

@property(nonatomic, weak) IBOutlet UIImageView *noFavoImage;
@property(nonatomic, weak) IBOutlet UIImageView *noNetworkImage;
@property(nonatomic, weak) IBOutlet UIImageView *noMessageImage;
@property(nonatomic, weak) IBOutlet UILabel *noDataLabel;
@property(nonatomic, weak) IBOutlet UILabel *noFavoLabel;
@property(nonatomic, weak) id<noDataDelegate> delegate;

-(void)setupImage:(NSInteger)flag;

@end
