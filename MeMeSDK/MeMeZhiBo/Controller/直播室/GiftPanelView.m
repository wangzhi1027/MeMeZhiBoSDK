//
//  GiftPanelView.m
//  TTShow
//
//  Created by twb on 14-3-21.
//  Copyright (c) 2014年 twb. All rights reserved.
//

#import "GiftPanelView.h"

@interface GiftPanelView ()

@property (weak, nonatomic) IBOutlet UIButton *sendFeatherButton;
@property (weak, nonatomic) IBOutlet UILabel *featherCount;
@property (weak, nonatomic) IBOutlet UILabel *giftCount;


@end

@implementation GiftPanelView

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
    [super awakeFromNib];
    self.backgroundColor = kClearColor;
    
#if 0
    [self setBadge];
#endif
    
}

- (IBAction)sendFeatherAction:(id)sender
{
    [self.delegate sendFeathers];
}

- (IBAction)sendGiftAction:(id)sender
{
    [self.delegate sendGifts];
}

#if 0

- (void)setBadge
{
    // Feather Badge
    JSBadgeView *badgeView = [[JSBadgeView alloc] initWithParentView:self.sendFeatherButton alignment:JSBadgeViewAlignmentBottomRight];
    self.featherBadge = badgeView;
    self.featherBadge.userInteractionEnabled = NO;
    self.featherBadge.badgeText = @"0";
}

#endif

- (void)setFeatherBadgeCount:(NSInteger)count
{
//    self.featherBadge.badgeText = [NSString stringWithFormat:@"%ld", (long)count];
    self.featherCount.text = [NSString stringWithFormat:@"x%ld", count];
}

- (void)setGiftBadgeCount:(NSInteger)count
{
    self.giftCount.text = [NSString stringWithFormat:@"x%ld", count];
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
