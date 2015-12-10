//
//  UIViewController+ShareInstance.m
//  TTShow
//
//  Created by twb on 13-6-9.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import "UIViewController+ShareInstance.h"
#import "MMMBProgressHUD.h"
#import "NSBundle+SDK.h"

@implementation UIViewController (ShareInstance)



- (TTShowUIManager *)uiManager;
{
	return [Manager sharedInstance].uiManager;
}

- (TTShowDataManager *)dataManager
{
    return [Manager sharedInstance].dataManager;
}

- (TTShowUser *)me
{
    return [Manager sharedInstance].dataManager.me;
}

- (FilterCondition *)filter
{
    return [Manager sharedInstance].dataManager.filter;
}

- (NSString *)hlsSecretCodeByRoomID:(NSInteger)roomid byTimeStamp:(NSString *)timeStamp
{
    NSString *secretCode = [[NSString stringWithFormat:@"%@/ttshow/%ld_000/playlist.m3u8%@",
                             self.filter.videoPrivateKey,
                             (long)roomid,
                             timeStamp] MD5String];
    return secretCode;
}

- (NSString *)hlsMediaSecretStringByRoomID:(NSInteger)roomid byTimeStamp:(NSString *)timeStamp
{
    return [NSString stringWithFormat:@"%@%ld_000/playlist.m3u8?k=%@&t=%@",
            self.filter.baseRTMPMediaURL,
            (long)roomid,
            [self rtmpSecretCodeByRoomID:roomid byTimeStamp:timeStamp],
            timeStamp];
}

- (NSString *)rtmpSecretCodeByRoomID:(NSInteger)roomid byTimeStamp:(NSString *)timeStamp
{
    NSString *secretCode = [[NSString stringWithFormat:@"%@/ttshow/%ld%@",
                             self.filter.videoPrivateKey,
                             (long)roomid,
                             timeStamp] MD5String];
    return secretCode;
}

- (NSString *)rtmpMediaSecretStringByRoomID:(NSInteger)roomid byTimeStamp:(NSString *)timeStamp
{
    return [NSString stringWithFormat:@"%@%ld?k=%@&t=%@",
                           self.filter.baseRTMPMediaURL,
                           (long)roomid,
                           [self rtmpSecretCodeByRoomID:roomid byTimeStamp:timeStamp],
                           timeStamp];
}

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

- (void)showProgressWithLabel:(NSString *)text task:(void (^)(void))task completion:(void (^)(void))completion
{
	assert(task);
	MMMBProgressHUD *hud = [MMMBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
	hud.labelText = text;
	dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
		task();
		dispatch_async(dispatch_get_main_queue(), ^{
			[MMMBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
			if(completion)
            {
                completion();
            }
		});
	});
}

- (void)showProgressWithLabelWithStatus:(NSString *)text task:(int (^)(void))task completion:(void (^)(int))completion
{
	assert(task);
	MMMBProgressHUD *hud = [MMMBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
	hud.labelText = text;
	dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
		int result = task();
		dispatch_async(dispatch_get_main_queue(), ^{
			[MMMBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
			if(completion)
            {
                completion(result);
            }
		});
	});
}

@end
