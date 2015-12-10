//
//  MeMeZhiBo.h
//  MeMeZhiBo
//
//  Created by XIN on 15/11/20.
//  Copyright (c) 2015年 XIN. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AuthorizedFinishedDelegate;

@interface MeMeZhiBo : NSObject

@property (nonatomic, weak) id<AuthorizedFinishedDelegate> delegate;

+ (instancetype)sharedInstance;

/**
 *  验证进入大厅
 */
- (void)authorizedWithToken:(NSString *)token openUdid:(NSString*)udid;

/**
 *  进入某个具体房间
 */
- (void)authorizedWithToken:(NSString *)token userName:(NSString *)userName roomID:(NSInteger)roomID;

@end

@protocol AuthorizedFinishedDelegate <NSObject>

@optional
- (void)authorizedSuccessWithHallViewController:(UIViewController *)hallViewController;
- (void)authorizedSuccessWithRoomVideoViewController:(UINavigationController *)roomVideoNavController;
- (void)authorizedFailed:(NSError *)error;

@end