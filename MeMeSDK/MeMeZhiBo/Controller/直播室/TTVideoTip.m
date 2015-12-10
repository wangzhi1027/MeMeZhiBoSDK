//
//  TTVideoTip.m
//  TTShow
//
//  Created by twb on 14-1-9.
//  Copyright (c) 2014年 twb. All rights reserved.
//

#import "TTVideoTip.h"

@interface TTVideoTip ()

@property (nonatomic, strong) UIActivityIndicatorView *loading;
@property (weak, nonatomic) IBOutlet UILabel *loadingText;

@end

@implementation TTVideoTip

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    self.loading = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    self.loading.hidesWhenStopped = YES;
    self.loading.frame = CGRectMake(kScreenWidth / 2 - 15.0f, 0.0f, 30.0f, 30.0f);
    [self.loading startAnimating];
    [self addSubview:self.loading];
}

- (void)setTipType:(VideoTipType)tipType
{
    _tipType = tipType;
    switch (tipType)
    {
        case kVideoLoadingTip:
        {
            self.loadingText.text = @"正在载入...";
            [self.loading startAnimating];
        }
            break;
        case kVideoBufferTip:
        {
            self.loadingText.text = @"正在缓冲...";
            [self.loading startAnimating];
        }
            break;
        case kVideoEndTip:
        case kVideoErrorTip:
        case kVideoPlaybackTip:
        {
            self.loadingText.text = @"";
            [self.loading stopAnimating];
        }
            break;
        default:
            break;
    }
}

- (void)setOfflineMessage:(NSString *)message
{
    if (!message) {
        message = @"主播休息去了";
    }
    self.loadingText.text = message;
    [self.loading stopAnimating];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
