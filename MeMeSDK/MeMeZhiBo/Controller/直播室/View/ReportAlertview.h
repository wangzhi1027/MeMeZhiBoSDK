//
//  ReportAlertview.h
//  memezhibo
//
//  Created by Xingai on 15/6/16.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ReportAlertviewDelegate <NSObject>

-(void)cancel;
-(void)Dial;

@end


@interface ReportAlertview : UIView

@property(nonatomic, weak) IBOutlet UIImageView *CrossImage;
@property(nonatomic, weak) IBOutlet UIImageView *VerticalImage;

@property(nonatomic, weak) id<ReportAlertviewDelegate>delegate;

@end
