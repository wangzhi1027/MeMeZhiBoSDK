//
//  UIGlobalKit.h
//  TTShow
//
//  Created by twb on 13-11-15.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import "GlobalKit.h"
#import <UIKit/UIKit.h>

typedef void (^CompletionBlock)();

@interface UIGlobalKit : GlobalKit

@property (nonatomic, strong) AVAudioPlayer *avAudioPlayer;
@property (nonatomic, assign, readonly) BOOL isTabBarShow;

// Singleton for global shared functions.
+ (instancetype)sharedInstance;

- (void)showMessage:(NSString *)msg in:(UIViewController *)v disappearAfter:(CGFloat)delay;

- (UIView *)setNoLiveVideoTip:(UIView *)parent;
- (void)removeNoLiveVideoTip:(UIView *)parent;
//- (UIView *)setLoadLiveVideoTip:(UIView *)parent;

// Navigation Title
- (void)setNavLeftItem:(UIViewController *)v title:(NSString *)t action:(SEL)action;
- (void)setNavRightItem:(UIViewController *)v title:(NSString *)t action:(SEL)action;

- (void)setNavLeftBackItem:(UIViewController *)v action:(SEL)action;
- (void)setNavLeftBackItem:(UIViewController *)v action:(SEL)action isBlack:(BOOL)isBlack;

// iOS7
- (void):(BOOL)isLeft naviItem:(UIViewController *)v image:(NSString *)image selImage:(NSString *)selImage action:(SEL)action;
- (void)setNavLeft:(BOOL)isLeft controller:(UIViewController *)controller image:(NSArray *)ns highlighted:(NSArray *)hs action:(NSArray *)action;

- (void)setLiveNavBackItem:(UIViewController *)v action:(SEL)action;
- (void)setLiveFavor:(BOOL)favor navItem:(UIViewController *)v action:(SEL)action;
- (void)setLeft:(BOOL)isLeft naviItem:(UIViewController *)v image:(NSString *)image selImage:(NSString *)selImage action:(SEL)action;

- (void)setNavCustomNormalBg:(UIViewController *)v;
- (void)setNavCustomNormalBg:(UIViewController *)v hasBottomLine:(BOOL)hasBottomLine;
- (void)setNavCustomTransBg:(UIViewController *)v;
- (void)setNavCustomUCBg:(UIViewController *)v;
- (void)setToolBarCustomUCBG:(UIToolbar *)toolBar;

- (void)setNavigationController:(UIViewController *)v title:(NSString *)s output:(UILabel **)l;
- (void)setNavigationController:(UIViewController *)v title:(NSString *)s output:(UILabel **)l isBlack:(BOOL)isBlack;
- (void)setNavigationController:(UIViewController *)v title:(NSString *)s;
- (void)setNavigationController:(UIViewController *)v title:(NSString *)s isBlack:(BOOL)isBlack;
- (void)setNavController:(UIViewController *)v title:(NSString *)s output:(UIButton**)button;

// UITalbeView scroll to top.
- (void)scrollToTop:(UITableView *)tableView Offset:(CGPoint)offset animated:(BOOL)animated;
- (void)scrollToTop:(UITableView *)tableView;
// For Collection View Scrolling to top.
//- (void)scrollToTopForCollection:(PSUICollectionView *)view Offset:(CGPoint)offset animated:(BOOL)animated;
//- (void)scrollToTopForCollection:(PSUICollectionView *)view;

- (void)setTextFieldBg:(UITextField *)textField;

// Set Custom Button Skin.
- (void)setCustomButton:(UIButton *)button;
- (void)setCustomButton:(UIButton *)button isPureBG:(BOOL)isPureBG;
- (void)setCustomButton:(UIButton *)button font:(CGFloat)size;
- (void)setCustomButton:(UIButton *)button font:(CGFloat)size isPureBG:(BOOL)isPureBG;

// Cell Image Loading Effectively.
- (void)setImageAnimationLoading:(UIImageView *)img WithSource:(NSString *)urlString;
- (void)setLoadingImage:(UIImageView *)iv urlString:(NSString *)urlString size:(CGSize)size cache:(BOOL)cache;
- (void)setImageAnimationLoading:(UIImageView *)img WithSource:(NSString *)urlString cache:(BOOL)cache;

// Table Group Cell BG.
- (void)set4CornerBGCell:(UITableViewCell *)cell;
- (void)setTopBGCell:(UITableViewCell *)cell;
- (void)setCenterBGCell:(UITableViewCell *)cell;
- (void)setBottomBGCell:(UITableViewCell *)cell;

- (void)adaptFooter:(UIView *)v indentation:(CGFloat)indentation;
- (void)adaptFooter:(UIView *)v;
- (void)adaptCellElementForWidth:(UIView *)v indentation:(CGFloat)indentation;
- (void)adaptCellElememtForWidth:(UIView *)v;
- (void)adaptCellElement:(UIView *)v indentation:(CGFloat)indentation;
- (void)adaptCellElememt:(UIView *)v;
- (CGRect)groupCellSuitFrame:(CGRect)frame;

// Cell Separator Line
- (void)drawCellBottomLine:(CGFloat)height;

// Status Bar Tips
- (void)postErrorMessage:(NSString *)strTips;
- (void)postFinishMessage:(NSString *)strTips;

// Tab Bar controller show or hide.
- (void)showTabBar:(UITabBarController *)tabbarcontroller completion:(CompletionBlock)completion;
- (void)hideTabBar:(UITabBarController *)tabbarcontroller completion:(CompletionBlock)completion;
- (void)hideTabBarDirectly:(UITabBarController *)tabBarController;
- (void)showTabBarDirectly:(UITabBarController *)tabBarController;

// Chat Expression Core Logic.
- (NSArray *)cutOffContent:(NSString *)content;
- (NSArray *)splitContent:(NSString *)content;
- (NSArray *)splitContent:(NSString *)content color:(ChatRoomFontColorMode)color size:(CGFloat)size;

// show auth code.
- (void)showAuthCode:(id)target controller:(UIViewController *)c mission:(NSString *)_id;

- (void)playPuzzleStartSound;
- (void)playPuzzleWinSound;
- (void)playPuzzleCompleteSound;
- (void)playPuzzleFailSound;

- (void)setupLightStatusBarWithAnimated:(BOOL)animated;
- (void)setupLightStatusBar;
- (void)setupDarkStatusBarWithAnimated:(BOOL)animated;
- (void)setupDarkStatusBar;

@end
