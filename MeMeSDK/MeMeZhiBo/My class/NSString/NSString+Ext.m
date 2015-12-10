//
//  NSString+Ext.m
//  v2ex
//
//  Created by XIN on 15/7/28.
//  Copyright (c) 2015年 PPTV. All rights reserved.
//

#import "NSString+Ext.h"

@implementation NSString (Ext)

- (CGSize)calculateSize:(CGSize)size font:(UIFont *)font
{
    CGSize expectedLabelSize = CGSizeZero;
    
    if (!font) {
        font = [UIFont systemFontOfSize:17.0];
    }
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
        
        expectedLabelSize = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    } else {
        expectedLabelSize = [self sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
    }
    return CGSizeMake(ceil(expectedLabelSize.width), ceil(expectedLabelSize.height));
}

@end
