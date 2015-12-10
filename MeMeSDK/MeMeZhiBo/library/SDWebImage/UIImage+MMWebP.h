//
//  UIImage+WebP.h
//  SDWebImage
//
//  Created by Olivier Poitrey on 07/06/13.
//  Copyright (c) 2013 Dailymotion. All rights reserved.
//

#ifdef SD_WEBP

#import <UIKit/UIKit.h>

// Fix for issue #416 Undefined symbols for architecture armv7 since WebP introduction when deploying to device
void MMWebPInitPremultiplyNEON(void);

void MMWebPInitUpsamplersNEON(void);

void MMVP8DspInitNEON(void);

@interface UIImage (MMWebP)

+ (UIImage *)sd_imageWithWebPData:(NSData *)data;

@end

#endif
