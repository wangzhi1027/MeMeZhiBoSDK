//
//  UIView+ShareInstance.m
//  TTShow
//
//  Created by twb on 13-8-2.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import "UIView+ShareInstance.h"
#import "NSBundle+SDK.h"

@implementation UIView (ShareInstance)

- (UIView *)viewFromNib:(NSString *)nib
{
	assert(nib);
	NSArray *subviewArray = [[NSBundle SDKResourcesBundle] loadNibNamed:nib owner:self options:nil];
	UIView *v = (UIView *) [subviewArray objectAtIndex:0];
	return v;
}

- (UIView *)viewFromNib:(NSString *)nib withOrigin:(CGPoint)point
{
	UIView *v = [self viewFromNib:nib];
	CGRect f = v.frame;
	f.origin = point;
	v.frame = f;
	return v;
}

- (void)viewMoveDownward:(CGFloat)dy
{
    CGRect f = self.frame;
    f.origin = CGPointMake(f.origin.x, f.origin.y + dy);
    f.size = CGSizeMake(f.size.width, f.size.height);
    self.frame = f;
}

- (void)viewMoveToSuitStatusBar
{
//    if (kSystemVersionGreaterOrEqualThan(7.0))
//    {
        [self viewMoveDownward:kScreenStatusBarHeight];
//    }
}

- (void)viewOriginY:(CGFloat)y
{
    CGRect f = self.frame;
    f.origin.y = y;
    self.frame = f;
}

- (void)viewOriginYMinus:(CGFloat)dy
{
    CGRect f = self.frame;
    f.origin.y -= dy;
    self.frame = f;
}

- (void)viewOriginYPlus:(CGFloat)dy
{
    CGRect f = self.frame;
    f.origin.y += dy;
    self.frame = f;
}

- (void)viewSizeHeight:(CGFloat)height
{
    CGRect f = self.frame;
    f.size.height = height;
    self.frame = f;
}

- (void)viewSizeMinusHeight:(CGFloat)dHeight
{
    CGRect f = self.frame;
    f.size.height -= dHeight;
    self.frame = f;
}

- (void)viewSizePlusHeight:(CGFloat)dHeight
{
    CGRect f = self.frame;
    f.size.height += dHeight;
    self.frame = f;
}

@end
