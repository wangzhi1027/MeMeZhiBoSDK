//
//  ChatLabel.m
//  TTShow
//
//  Created by twb on 13-10-9.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import "ChatLabel.h"

@implementation ChatLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    [super drawRect:rect];
    
    if (self.hasUnderLine)
    {
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        CGSize fontSize =[self.text sizeWithFont:self.font forWidth:self.frame.size.width lineBreakMode:NSLineBreakByTruncatingTail];
        
        // set as the text's color
        CGContextSetStrokeColorWithColor(ctx, self.textColor.CGColor);
        CGContextSetLineWidth(ctx, 1.0f);
        CGPoint leftPoint = CGPointMake(0, self.frame.size.height);
        CGPoint rightPoint = CGPointMake(fontSize.width, self.frame.size.height);
        CGContextMoveToPoint(ctx, leftPoint.x, leftPoint.y);
        CGContextAddLineToPoint(ctx, rightPoint.x, rightPoint.y);
        CGContextStrokePath(ctx);
    }
}

- (void)setHasUnderLine:(BOOL)hasUnderLine
{
    _hasUnderLine = hasUnderLine;
    
    [self setNeedsDisplay];
}

@end
