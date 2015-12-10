//
//  UIColor+iOS7Colors.h
//  TTShow
//
//  Created by twb on 13-12-30.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (iOS7Colors)

// Plain Colors
+ (instancetype)iOS7redColor;
+ (instancetype)iOS7orangeColor;
+ (instancetype)iOS7yellowColor;
+ (instancetype)iOS7greenColor;
+ (instancetype)iOS7lightBlueColor;
+ (instancetype)iOS7darkBlueColor;
+ (instancetype)iOS7purpleColor;
+ (instancetype)iOS7pinkColor;
+ (instancetype)iOS7darkGrayColor;
+ (instancetype)iOS7lightGrayColor;

// Gradient Colors
+ (instancetype)iOS7redGradientStartColor;
+ (instancetype)iOS7redGradientEndColor;

+ (instancetype)iOS7orangeGradientStartColor;
+ (instancetype)iOS7orangeGradientEndColor;

+ (instancetype)iOS7yellowGradientStartColor;
+ (instancetype)iOS7yellowGradientEndColor;

+ (instancetype)iOS7greenGradientStartColor;
+ (instancetype)iOS7greenGradientEndColor;

+ (instancetype)iOS7tealGradientStartColor;
+ (instancetype)iOS7tealGradientEndColor;

+ (instancetype)iOS7blueGradientStartColor;
+ (instancetype)iOS7blueGradientEndColor;

+ (instancetype)iOS7violetGradientStartColor;
+ (instancetype)iOS7violetGradientEndColor;

+ (instancetype)iOS7magentaGradientStartColor;
+ (instancetype)iOS7magentaGradientEndColor;

+ (instancetype)iOS7blackGradientStartColor;
+ (instancetype)iOS7blackGradientEndColor;

+ (instancetype)iOS7silverGradientStartColor;
+ (instancetype)iOS7silverGradientEndColor;

+ (instancetype)colorWithRGBValue:(NSInteger)rgbValue;
+ (NSInteger)valueOfColor:(UIColor *)color;
+ (instancetype)randomColor;
+ (NSInteger)randomRGBValue;
@end
