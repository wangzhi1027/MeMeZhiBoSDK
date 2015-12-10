//
//  SearchBar.h
//  memezhibo
//
//  Created by Xingai on 15/6/1.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol seachDelegate <NSObject>

-(void)cancelView;

-(void)cancelButton;

@end

@interface SearchBar : UIView

@property(nonatomic, weak) id<seachDelegate>delegate;
@property(nonatomic, assign) IBOutlet UITextField *field;
@property(nonatomic, assign) IBOutlet UIImageView *image;
@property(nonatomic, assign) IBOutlet UIButton *cancelBtn;
@property(nonatomic, assign) IBOutlet UILabel *ResultLabel;
@property(nonatomic, assign) IBOutlet UIButton *clearBtn;

@end
