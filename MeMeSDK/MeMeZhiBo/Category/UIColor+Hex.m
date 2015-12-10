//
//  UIColor+Hex.m
//  memezhibo
//
//  Created by XIN on 15/10/20.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "UIColor+Hex.h"

@implementation UIColor (Hex)

+(UIColor *)colorWithHexString:(NSString *)hex alpha:(CGFloat)alpha
{
    unsigned int hexInt = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hex];
    [scanner setCharactersToBeSkipped:[NSCharacterSet characterSetWithCharactersInString:@"#"]];
    [scanner scanHexInt:&hexInt];
    
    UIColor *color = [UIColor colorWithRed:((hexInt & 0xff0000) >> 16)/255.0
                                     green:((hexInt & 0x00ff00) >> 8)/255.0
                                      blue:(hexInt & 0x0000ff)/255.0
                                     alpha:alpha];
    return color;
}

@end
