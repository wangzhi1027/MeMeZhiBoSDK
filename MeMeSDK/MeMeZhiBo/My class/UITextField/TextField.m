//
//  TextField.m
//  TTShow
//
//  Created by twb on 13-9-10.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import "TextField.h"

#define kTextFieldPaddingWidth  (10.0f)
#define kTextFieldPaddingHeight (10.0f)

@implementation TextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (CGRect)textRectForBounds:(CGRect)bounds
{
    return CGRectInset(bounds,
                       self.dx == 0.0f ? kTextFieldPaddingWidth : self.dx,
                       self.dy == 0.0f ? kTextFieldPaddingHeight : self.dy);
}

- (CGRect)editingRectForBounds:(CGRect)bounds
{
    return CGRectInset(bounds,
                       self.dx == 0.0f ? kTextFieldPaddingWidth : self.dx,
                       self.dy == 0.0f ? kTextFieldPaddingHeight : self.dy);
}

- (void)setDx:(CGFloat)dx
{
    _dx = dx;
    [self setNeedsDisplay];
}

- (void)setDy:(CGFloat)dy
{
    _dy = dy;
    [self setNeedsDisplay];
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
