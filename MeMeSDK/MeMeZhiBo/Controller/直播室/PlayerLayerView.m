//
//  PlayerLayerView.m
//  HLSPlayer
//
//  Created by twb on 13-5-28.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import "PlayerLayerView.h"
//#import <AVFoundation/AVFoundation.h>

/* ---------------------------------------------------------
 **  To play the visual component of an asset, you need a view
 **  containing an AVPlayerLayer layer to which the output of an
 **  AVPlayer object can be directed. You can create a simple
 **  subclass of UIView to accommodate this. Use the view’s Core
 **  Animation layer (see the 'layer' property) for rendering.
 **  This class is a subclass of UIView that is used for this
 **  purpose.
 ** ------------------------------------------------------- */

@implementation PlayerLayerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
//        self.backgroundColor = kRGBA(0.0f, 0.0f, 0.0f, 0.8f);//kDarkGrayColor;
        self.layer.masksToBounds = YES;
        
        [self setupLayerBG];
        
    }
    return self;
}

- (void)setupLayerBG
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, kScreenWidth, 240.0f)];
    imageView.image = kImageNamed(@"img_live_loading_bg.png");
    [self addSubview:imageView];
}

//+ (Class)layerClass
//{
//    return [AVPlayerLayer class];
//}
//
//- (AVPlayerLayer *)playerLayer
//{
//    return (AVPlayerLayer *)self.layer;
//}
//
//- (void)setPlayer:(AVPlayer *)player
//{
//    [(AVPlayerLayer *)[self layer] setPlayer:player];
//}
//
//#pragma mark - Public part.
//
//- (void)setVideoFillMode:(NSString *)fillMode
//{
//    AVPlayerLayer *playerLayer = (AVPlayerLayer *)self.layer;
//    playerLayer.videoGravity = fillMode;
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
