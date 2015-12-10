//
//  Foundation+Log.h
//  Test
//
//  Created by XIN on 15/10/28.
//  Copyright © 2015年 XIN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Log)

- (NSString *)descriptionWithLocale:(id)locale;

@end

@interface NSArray (Log)

- (NSString *)descriptionWithLocale:(id)locale;

@end