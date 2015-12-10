//
//  GiftPanelView.h
//  TTShow
//
//  Created by twb on 14-3-21.
//  Copyright (c) 2014年 twb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSBadgeView.h"

#define kGiftPanelViewWidth    (50.0f)
#define kGiftPanelViewHeight   (105.0f)
#define kGiftPanelViewPaddingY (5.0f)

@protocol GiftPanelDelegate <NSObject>

@required
- (void)sendFeathers;
- (void)sendGifts;

@end

@interface GiftPanelView : UIView

@property (nonatomic, strong) JSBadgeView *featherBadge;
@property (nonatomic, weak) id<GiftPanelDelegate> delegate;

- (void)setFeatherBadgeCount:(NSInteger)count;
- (void)setGiftBadgeCount:(NSInteger)count;

@end
