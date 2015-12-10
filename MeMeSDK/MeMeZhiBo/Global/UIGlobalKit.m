//
//  UIGlobalKit.m
//  TTShow
//
//  Created by twb on 13-11-15.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import "UIGlobalKit.h"
//#import "MTStatusBarOverlay.h"
//#import "UIImage+GIF.h"
//#import "NavigationItemButton.h"
//#import "NavigationItemImageButton.h"
//#import "NavigationItemBackButton.h"
//#import "TransNavImageItem.h"
//#import "UIBarImageButton.h"
//#import "AuthCodeView.h"
//#import "UIViewController+KNSemiModal.h"
#import "MMMBProgressHUD.h"

#define kNoLiveVideoTipViewTag (1000)
#define kTabAnimationDuration  (0.25f)

@interface UIGlobalKit ()

@property (nonatomic, assign) BOOL hideTabAnmiating;
@property (nonatomic, assign) BOOL showTabAnmiating;
@property (nonatomic, assign) BOOL isTabShow;

@end

@implementation UIGlobalKit

+ (instancetype)sharedInstance
{
	static id instance;
	
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		instance = [[[self class] alloc] init];
	});

	return instance;
}

- (void)showMessage:(NSString *)msg in:(UIViewController *)v disappearAfter:(CGFloat)delay
{
    MMMBProgressHUD *hud = [MMMBProgressHUD showHUDAddedTo:v.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelFont = kFontOfSize(12.0f);
    hud.labelText = msg;
    [hud hide:YES afterDelay:delay];
}

- (UIView *)setNoLiveVideoTip:(UIView *)parent
{
    UIImageView *iv = [[UIImageView alloc] initWithFrame:parent.bounds];
    iv.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    iv.tag = kNoLiveVideoTipViewTag;
    iv.image = kImageNamed(@"img_video_not_play_bg.png");
    [parent addSubview:iv];
    return iv;
}

- (void)removeNoLiveVideoTip:(UIView *)parent
{
    if (parent == nil)
    {
        return;
    }
    
    UIImageView *iv = (UIImageView *)[parent viewWithTag:kNoLiveVideoTipViewTag];
    if (iv != nil)
    {
        [iv removeFromSuperview];
    }
}

//- (UIView *)setLoadLiveVideoTip:(UIView *)parent
//{
//    UIView *loadingContainer = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, parent.frame.size.width, 50.0f)];
//    loadingContainer.center = parent.center;
//    [parent addSubview:loadingContainer];
//    
//    UIActivityIndicatorView *loading = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
//    loading.frame = CGRectMake(kScreenWidth / 2 - 15.0f, 0.0f, 30.0f, 30.0f);
//    [loading startAnimating];
//    [loadingContainer addSubview:loading];
//    
//    UILabel *loadingText = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 25.0f, parent.frame.size.width, 20.0f)];
//    loadingText.text = @"视频加载中...";
//    loadingText.textColor = kWhiteColor;
//    loadingText.backgroundColor = kClearColor;
//    loadingText.font = kFontOfSize(12.0f);
//    loadingText.textAlignment = NSTextAlignmentCenter;
//    [loadingContainer addSubview:loadingText];
//    
//    return loadingContainer;
//}

#pragma mark - Navigation Bar.

- (void)setNavLeftItem:(UIViewController *)v title:(NSString *)t action:(SEL)action
{
    [self setLeft:YES naviItem:v title:t action:action];
}

- (void)setNavRightItem:(UIViewController *)v title:(NSString *)t action:(SEL)action
{
    [self setLeft:NO naviItem:v title:t action:action];
}

- (void)setLeft:(BOOL)isLeft naviItem:(UIViewController *)v title:(NSString *)t action:(SEL)action
{

        v.navigationController.navigationBar.tintColor = kRGBA(0x0,0x0,0x0,0.4f);
        if (isLeft)
        {
            v.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:t style:UIBarButtonItemStylePlain target:v action:action];
        }
        else
        {
            v.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:t style:UIBarButtonItemStylePlain target:v action:action];
        }
    
}

- (void)setNavLeftBackItem:(UIViewController *)v action:(SEL)action
{
    [self setNavLeftBackItem:v action:action isBlack:YES];
}

- (void)setNavLeftBackItem:(UIViewController *)v action:(SEL)action isBlack:(BOOL)isBlack
{
    [self setLeft:YES naviItem:v image:isBlack ? @"返回" : @"返回" selImage:@"" action:action];
}

//iOS7
- (void)setLeft:(BOOL)isLeft naviItem:(UIViewController *)v image:(NSString *)image selImage:(NSString *)selImage action:(SEL)action
{
    UIBarImageButton *item = [UIBarImageButton buttonWithType:UIButtonTypeCustom];
    if(isLeft)
        item.frame = CGRectMake(0.0f, 0.0f, 50.0f, 21.0f);
    else
        item.frame = CGRectMake(0.0f, 0.0f, 30.0f, 30.0f);
    item.isLeft = isLeft;
    [item setImage:kImageNamed(image) forState:UIControlStateNormal];
    
    [item addTarget:v action:action forControlEvents:UIControlEventTouchUpInside];
    if (isLeft)
    {

        v.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:item];
        

    }
    else
    {
        v.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:item];

    }
}

- (void)setNavLeft:(BOOL)isLeft
        controller:(UIViewController *)controller
             image:(NSArray *)ns
       highlighted:(NSArray *)hs
            action:(NSArray *)action
{

        NSMutableArray *items = [NSMutableArray arrayWithCapacity:0];
        for (NSInteger i = 0; i < ns.count; i++)
        {
            UIBarImageButton *item = [UIBarImageButton buttonWithType:UIButtonTypeCustom];
            item.frame = CGRectMake(0.0f, 0.0f, 40.0f, 30.0f);
            item.isLeft = isLeft;
            if (i < ns.count)
            {
                if ([ns[i] isKindOfClass:[NSString class]])
                {
                    if (ns[i] && ![ns[i] isEqualToString:@""])
                    {
                        [item setImage:kImageNamed(ns[i]) forState:UIControlStateNormal];
                    }
                }
            }
            
            if (i < action.count)
            {
                if ([action[i] isKindOfClass:[NSValue class]])
                {
                    if (action[i])
                    {
                        [item addTarget:controller action:[action[i] pointerValue] forControlEvents:UIControlEventTouchUpInside];
                    }
                }
            }
            [items addObject:[[UIBarButtonItem alloc] initWithCustomView:item]];
        }
        
        if (isLeft)
        {
            controller.navigationItem.leftBarButtonItems = items;
        }
        else
        {
            controller.navigationItem.rightBarButtonItems = items;
        }
    
}


//- (void)setNavLeft:(BOOL)isLeft
//        controller:(UIViewController *)controller
//             image:(NSArray *)ns
//       highlighted:(NSArray *)hs
//            action:(NSArray *)action
//{
//
//        NSMutableArray *items = [NSMutableArray arrayWithCapacity:0];
//        for (NSInteger i = 0; i < ns.count; i++)
//        {
//            UIBarImageButton *item = [UIBarImageButton buttonWithType:UIButtonTypeCustom];
//            item.frame = CGRectMake(0.0f, 0.0f, 40.0f, 30.0f);
//            item.isLeft = isLeft;
//            if (i < ns.count)
//            {
//                if ([ns[i] isKindOfClass:[NSString class]])
//                {
//                    if (ns[i] && ![ns[i] isEqualToString:@""])
//                    {
//                        [item setImage:kImageNamed(ns[i]) forState:UIControlStateNormal];
//                    }
//                }
//            }
//            
//            if (i < action.count)
//            {
//                if ([action[i] isKindOfClass:[NSValue class]])
//                {
//                    if (action[i])
//                    {
//                        [item addTarget:controller action:[action[i] pointerValue] forControlEvents:UIControlEventTouchUpInside];
//                    }
//                }
//            }
//            [items addObject:[[UIBarButtonItem alloc] initWithCustomView:item]];
//        }
//        
//        if (isLeft)
//        {
//            controller.navigationItem.leftBarButtonItems = items;
//        }
//        else
//        {
//            controller.navigationItem.rightBarButtonItems = items;
//        }
//}

- (void)setLiveNavBackItem:(UIViewController *)v action:(SEL)action
{

        [self setNavLeftBackItem:v action:action isBlack:NO];

}

//- (void)setLeft:(BOOL)isLeft naviItem:(UIViewController *)v image:(NSString *)image selImage:(NSString *)selImage action:(SEL)action
//{
//    UIBarImageButton *item = [UIBarImageButton buttonWithType:UIButtonTypeCustom];
//    if(isLeft)
//        item.frame = CGRectMake(0.0f, 0.0f, 28.0f, 21.0f);
//    else
//        item.frame = CGRectMake(0.0f, 0.0f, 30.0f, 30.0f);
//    item.isLeft = isLeft;
//    [item setImage:kImageNamed(image) forState:UIControlStateNormal];
//    [item addTarget:v action:action forControlEvents:UIControlEventTouchUpInside];
//    if (isLeft)
//    {
//        //v.navigationController.navigationBar.tintColor = kWhiteColor;
//        v.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:item];
//        
//        //            v.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:kImageNamed(image) landscapeImagePhone:nil style:UIBarButtonItemStylePlain target:v action:action];
//    }
//    else
//    {
//        v.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:item];
//        //            v.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:kImageNamed(image) landscapeImagePhone:nil style:UIBarButtonItemStylePlain target:v action:action];
//    }
//  }

- (void)setLiveFavor:(BOOL)favor navItem:(UIViewController *)v action:(SEL)action
{

//        UIBarImageButton *item = [UIBarImageButton buttonWithType:UIButtonTypeCustom];
//        item.frame = CGRectMake(0.0f, 0.0f, 20.0f, 20.0f);
//        item.isLeft = NO;
//        [item setBackgroundImage:kImageNamed(favor ? @"img_live_favor.png" : @"img_live_unfavor.png") forState:UIControlStateNormal];
//        [item addTarget:v action:action forControlEvents:UIControlEventTouchUpInside];
//        
//        [v.navigationItem setRightBarButtonItems:@[[[UIBarButtonItem alloc] initWithCustomView:item]] animated:YES];
}

- (void)setNavCustomNormalBg:(UIViewController *)v
{
    [self setNavCustomNormalBg:v hasBottomLine:YES];
}

- (void)setNavCustomNormalBg:(UIViewController *)v hasBottomLine:(BOOL)hasBottomLine
{
    [v.navigationController.navigationBar setBackgroundImage:[kImageNamed(@"navgation_bg.png") stretchableImageWithLeftCapWidth:1 topCapHeight:1]
                                               forBarMetrics:UIBarMetricsDefault];
}

- (void)setNavCustomTransBg:(UIViewController *)v
{
        [v.navigationController.navigationBar setBackgroundImage:[kImageNamed(@"img_live_nav_bg_7.png") stretchableImageWithLeftCapWidth:1 topCapHeight:1] forBarMetrics:UIBarMetricsDefault];
        // fix bottom hairLine of navigation bar issues.
}

- (void)setNavCustomUCBg:(UIViewController *)v
{
        [v.navigationController.navigationBar setBackgroundImage:kImageNamed(@"img_nav_bg_7.png") forBarMetrics:UIBarMetricsDefault];
        // fix bottom hairLine of navigation bar issues.
        [v.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}

- (void)setToolBarCustomUCBG:(UIToolbar *)toolBar
{
    [toolBar setBackgroundImage:kImageNamed(@"img_uc_album_bg.png") forToolbarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
        [toolBar setBackgroundImage:kImageNamed(@"img_uc_album_bg.png") forToolbarPosition:UIBarPositionAny barMetrics:UIBarMetricsLandscapePhone];
        // fix top hairLine of toolbar issues.
    [toolBar setShadowImage:[[UIImage alloc] init] forToolbarPosition:UIBarPositionAny];
}

- (void)setNavigationController:(UIViewController *)v title:(NSString *)s
{
    UILabel *titleLabel;
    [self setNavigationController:v title:s output:&titleLabel];
}

- (void)setNavigationController:(UIViewController *)v title:(NSString *)s isBlack:(BOOL)isBlack
{
    UILabel *titleLabel;
    [self setNavigationController:v title:s output:&titleLabel isBlack:isBlack];
}

- (void)setNavigationController:(UIViewController *)v title:(NSString *)s output:(UILabel **)l isBlack:(BOOL)isBlack
{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 150.0f, 25.0f)];
    v.title = s;
    [titleLabel setText:s];
    [titleLabel setFont:[UIFont boldSystemFontOfSize:kNavigationTitleFontSize]];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [titleLabel setTextColor:kWhiteColor];

    [titleLabel setTextAlignment:NSTextAlignmentCenter];

    [v.navigationItem setTitleView:titleLabel];
    
    *l = titleLabel;
}

- (void)setNavigationController:(UIViewController *)v title:(NSString *)s output:(UILabel **)l
{
    [self setNavigationController:v title:s output:l isBlack:YES];
}

- (void)setNavController:(UIViewController *)v title:(NSString *)s output:(UIButton**)button
{
    UIButton *titleButton = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 60.0f, 25.0f)];
    v.title = s;
    [titleButton setTitle:s forState:UIControlStateNormal];
    [titleButton setTitleColor:kNavTitleHighlightColor forState:UIControlStateNormal];
    [titleButton.titleLabel setFont:[UIFont systemFontOfSize:kNavigationTitleFontSize]];
    [titleButton setShowsTouchWhenHighlighted:YES];
    titleButton.titleLabel.shadowColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
    //    titleButton.titleLabel.shadowOffset = CGSizeMake(0.5f, 0.5f);
    [titleButton setBackgroundColor:[UIColor clearColor]];
    [v.navigationItem setTitleView:titleButton];
    *button = titleButton;
}

- (void)setTextFieldBg:(UITextField *)textField
{
    [textField setBackground:[kImageNamed(@"img_textfield_bg.png") resizableImageWithCapInsets:UIEdgeInsetsMake(6.0f, 6.0f, 6.0f, 6.0f)]];
}

- (void)setCustomButton:(UIButton *)button
{
    [self setCustomButton:button font:18.0f isPureBG:YES];
}

- (void)setCustomButton:(UIButton *)button isPureBG:(BOOL)isPureBG
{
    [self setCustomButton:button font:18.0f isPureBG:isPureBG];
}

- (void)setCustomButton:(UIButton *)button font:(CGFloat)size
{
    [self setCustomButton:button font:size isPureBG:YES];
}

- (void)setCustomButton:(UIButton *)button font:(CGFloat)size isPureBG:(BOOL)isPureBG
{
        if (isPureBG)
        {
            [button setBackgroundColor:kRGBA(255.0f, 255.0f, 255.0f, 0)];
        }
        else
        {
            [button setBackgroundImage:[kImageNamed(@"img_btn_normal.png") resizableImageWithCapInsets:UIEdgeInsetsMake(6.0f, 6.0f, 6.0f, 6.0f)] forState:UIControlStateNormal];
            [button setBackgroundImage:[kImageNamed(@"img_btn_press.png") resizableImageWithCapInsets:UIEdgeInsetsMake(6.0f, 6.0f, 6.0f, 6.0f)] forState:UIControlStateHighlighted];
        }
    
    [button.titleLabel setFont:kBoldFontOfSize(size)];
}

- (void)setImageAnimationLoading:(UIImageView *)img WithSource:(NSString *)urlString
{
    [self setImageAnimationLoading:img WithSource:urlString cache:YES];
//     img.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]]];
}

- (void)setLoadingImage:(UIImageView *)iv urlString:(NSString *)urlString size:(CGSize)size cache:(BOOL)cache
{
    if (![urlString isEqual: [NSNull null]]) {
        [iv sd_setImageWithURL:[NSURL URLWithString:urlString]];
    }
    
    iv.alpha = 0.0f;
    [UIView animateWithDuration:0.25f animations:^{
        iv.alpha = 1.0f;
    }];
}

- (void)setImageAnimationLoading:(UIImageView *)img WithSource:(NSString *)urlString cache:(BOOL)cache
{
    [self setLoadingImage:img urlString:urlString size:CGSizeZero cache:cache];
}

- (void)set4CornerBGCell:(UITableViewCell *)cell
{

}

- (void)setTopBGCell:(UITableViewCell *)cell
{

}

- (void)setCenterBGCell:(UITableViewCell *)cell
{

}

- (void)setBottomBGCell:(UITableViewCell *)cell
{

}

- (void)adaptFooter:(UIView *)v indentation:(CGFloat)indentation
{
    return;
}

- (void)adaptFooter:(UIView *)v
{
    [self adaptFooter:v indentation:10.0f];
}

- (void)adaptCellElementForWidth:(UIView *)v indentation:(CGFloat)indentation
{
    return;
}

- (void)adaptCellElememtForWidth:(UIView *)v
{
    [self adaptCellElementForWidth:v indentation:15.0f];
}

- (void)adaptCellElement:(UIView *)v indentation:(CGFloat)indentation
{
    return;
}

- (void)adaptCellElememt:(UIView *)v
{
    [self adaptCellElement:v indentation:15.0f];
}

- (CGRect)groupCellSuitFrame:(CGRect)frame
{
#if 1
    // do nothing.
    return frame;
#else
    if (kSystemVersionGreaterOrEqualThan(7.0f))
    {
        frame.origin.x += 10.0f;
        frame.size.width -= 20.0f;
    }
    return frame;
#endif
}

- (void)scrollToTop:(UITableView *)tableView Offset:(CGPoint)offset animated:(BOOL)animated
{
    if (tableView == nil)
    {
        return;
    }
    
    [tableView setContentOffset:offset animated:animated];
}

- (void)scrollToTop:(UITableView *)tableView
{
    [self scrollToTop:tableView Offset:CGPointMake(0.0f, 0.0f) animated:YES];
}

//- (void)scrollToTopForCollection:(PSUICollectionView *)view Offset:(CGPoint)offset animated:(BOOL)animated
//{
//    if (view == nil)
//    {
//        LOGERROR(@"No Data Loading.");
//        return;
//    }
//    
//    [view setContentOffset:offset animated:animated];
//}

//- (void)scrollToTopForCollection:(PSUICollectionView *)view
//{
//    double delayInSeconds = 0.5f;
//    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
//    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//        [self scrollToTopForCollection:view Offset:CGPointMake(0.0f, 0.0f) animated:YES];
//    });
//}

// draw cell bottom separator, thinner.
- (void)drawCellBottomLine:(CGFloat)height
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, 0.5f);
    CGContextSetStrokeColorWithColor(context, kCellSeparatorColor.CGColor);
    //    CGContextSetAllowsAntialiasing(UIGraphicsGetCurrentContext(), YES);
    CGContextBeginPath(UIGraphicsGetCurrentContext());
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), 0.0f, height);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), kScreenWidth, height);
    CGContextStrokePath(UIGraphicsGetCurrentContext());
}

// Custom status bar tips
- (void)postErrorMessage:(NSString *)strTips
{
    // Apple forbidden covering the staus bar.
#if 0
    MTStatusBarOverlay *overlay = [MTStatusBarOverlay sharedInstance];
    overlay.animation = MTStatusBarOverlayAnimationFallDown;
    overlay.detailViewMode = MTDetailViewModeCustom;
    overlay.frame = CGRectMake(0.0f, 0.0f, 320.0f, 20.0f);
    
    [overlay postImmediateErrorMessage:strTips duration:3.0f animated:YES];
#endif
}

- (void)postFinishMessage:(NSString *)strTips
{
    // Apple forbidden covering the staus bar.
#if 0
    MTStatusBarOverlay *overlay = [MTStatusBarOverlay sharedInstance];
    overlay.animation = MTStatusBarOverlayAnimationFallDown;
    overlay.detailViewMode = MTDetailViewModeCustom;
    overlay.frame = CGRectMake(0.0f, 0.0f, 320.0f, 20.0f);
    
    [overlay postImmediateFinishMessage:strTips duration:3.0f animated:YES];
#endif
}

// Global tabs is showing or hidding?
- (BOOL)isTabBarShow
{
    return self.isTabShow;
}

// tab bar controller show or hide.
- (void)hideTabBarDirectly:(UITabBarController *)tabBarController
{
    for(UIView *view in tabBarController.view.subviews)
    {
        if([view isKindOfClass:[UITabBar class]])
        {
            [view setFrame:CGRectMake(view.frame.origin.x, kScreenHeight, view.frame.size.width, view.frame.size.height)];
        }
        else
        {
            [view setFrame:CGRectMake(0.0f, 0.0f, kScreenWidth, kScreenHeight)];
        }
    }
    self.isTabShow = NO;
}



- (void)showTabBarDirectly:(UITabBarController *)tabBarController
{
    for(UIView *view in tabBarController.view.subviews)
    {
        if([view isKindOfClass:[UITabBar class]])
        {
            [view setFrame:CGRectMake(view.frame.origin.x, kScreenHeight - kTabBarHeight, view.frame.size.width, view.frame.size.height)];
        }
        else
        {
            [view setFrame:CGRectMake(0.0f, 0.0f, kScreenWidth, kScreenHeight - kTabBarHeight)];
        }
    }
    self.isTabShow = YES;
}


- (NSArray *)cutOffContent:(NSString *)content
{
    NSArray *symbolArray = [GlobalStatics EXPRESSIONS];
    if (content == nil || [content isEqualToString:@""])
    {
        return nil;
    }
    
    NSMutableString *finalStr = [[NSMutableString alloc] initWithString:content];
    // Symbol /高兴...eg.
    NSUInteger i = 0;
    NSUInteger j = 0;
    
    for (NSString *symbol in symbolArray)
    {
        @autoreleasepool
        {
            if([symbol hasPrefix:@"/v"]){
                    NSString *replaceString = [[NSString alloc] initWithFormat:@"%@%@gif_vip_expression_%lu%@",
                                       kChatCutOffContentSplitString,
                                       kChatCutOffContentExpression,
                                       (unsigned long)i-72,
                                       kChatCutOffContentSplitString];
                    [finalStr replaceOccurrencesOfString:symbol
                                      withString:replaceString
                                         options:NSCaseInsensitiveSearch
                                           range:NSMakeRange(0, [finalStr length])];
                i++;
            }else{
                    NSString *replaceString = [[NSString alloc] initWithFormat:@"%@%@gif_expression_%lu%@",
                                           kChatCutOffContentSplitString,
                                           kChatCutOffContentExpression,
                                           (unsigned long)i,
                                           kChatCutOffContentSplitString];
                    [finalStr replaceOccurrencesOfString:symbol
                                          withString:replaceString
                                             options:NSCaseInsensitiveSearch
                                               range:NSMakeRange(0, [finalStr length])];
                i++;
                
            }
        }
    }
    
    // 替换表情完毕后, 依据*$分割字符串. 且过滤空白字符串
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF != %@", @""];
    NSArray *sepArrays = [finalStr componentsSeparatedByString:kChatCutOffContentSplitString];
    NSArray *result = [sepArrays filteredArrayUsingPredicate:predicate];
    

    
    return result;
}

- (NSArray *)splitContent:(NSString *)content
{
    return [self splitContent:content color:kBColor size:kChatRoomFontSize];
}

- (NSArray *)splitContent:(NSString *)content color:(ChatRoomFontColorMode)color size:(CGFloat)size
{
    NSArray *contentArray = [self cutOffContent:content];
    NSMutableArray *resultArray = [[NSMutableArray alloc] init];
    
    for (NSString *s in contentArray)
    {
        @autoreleasepool
        {
            NSMutableDictionary *dictContent = [[NSMutableDictionary alloc] init];
            if ([s hasPrefix:kChatCutOffContentExpression])
            {
                // Expression..
                [dictContent setValue:@(kChatRoomLocalDynamicImage) forKey:kChatTypeKeyName];
                [dictContent setValue:[s substringFromIndex:kChatCutOffContentExpression.length] forKey:kChatImageKeyName];
                [dictContent setValue:@(kChatExpressionGifWidth) forKey:kChatImageWidthKeyName];
                [dictContent setValue:@(kChatExpressionGifHeight) forKey:kChatImageHeightKeyName];
                [dictContent setValue:@(kChatExpressionGifPaddingX) forKey:kChatImagePaddingXKeyName];
                [dictContent setValue:@(kChatExpressionGifPaddingY) forKey:kChatImagePaddingYKeyName];
            }
            else
            {
                // Text.
                [dictContent setValue:@(kChatRoomText) forKey:kChatTypeKeyName];
                [dictContent setValue:s forKey:kChatTextKeyName];
                [dictContent setValue:@(size) forKey:kChatTextFontSizeKeyName];
                [dictContent setValue:@(color) forKey:kChatTextColorTypeKeyName];
            }
            
            [resultArray addObject:dictContent];
        }
    }
    
    return resultArray;
}

//- (void)showAuthCode:(id)target controller:(UIViewController *)c mission:(NSString *)_id
//{
//    AuthCodeView *authCodeView = (AuthCodeView *)[c viewFromNib:@"AuthCodeView"];
//    authCodeView.delegate = target;
//    [authCodeView retrieveAuthCode];
//    [authCodeView setMissionID:_id];
//    [c presentSemiView:authCodeView withOptions:@{
//                                                  KNSemiModalOptionKeys.pushParentBack : @(NO),
//                                                  KNSemiModalOptionKeys.transitionStyle : @(KNSemiModalTransitionStyleFadeInOut),
//                                                  KNSemiModalOptionKeys.animationDuration : @(0.25f),
//                                                  KNSemiModalOptionKeys.shadowOpacity : @(0.2f),
//                                                  KNSemiModalOptionKeys.parentAlpha : @(0.8f)}
//            completion:nil];
//}

- (void)playPuzzleStartSound
{
    [self playSound:@"sound_puzzle_start" extend:@"m4a"];
}

- (void)playPuzzleWinSound
{
    [self playSound:@"sound_puzzle_win" extend:@"m4a"];
}

- (void)playPuzzleCompleteSound
{
    [self playSound:@"sound_puzzle_complete" extend:@"m4a"];
}

- (void)playPuzzleFailSound
{
    [self playSound:@"sound_puzzle_fail" extend:@"m4a"];
}

- (void)playSound:(NSString *)name extend:(NSString *)ext
{
#if 1
    NSError *error = nil;
    NSString *filePath = kSystemSoundPath(name, ext);
    NSURL *fileUrl = [NSURL URLWithString:filePath];
    
    if (self.avAudioPlayer != nil)
    {
        // firstly release.
        self.avAudioPlayer = nil;
    }
    
    // create AVAudioPlayer.
    self.avAudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileUrl error:&error];
    
    if (error != nil)
    {
        return;
    }
    [self.avAudioPlayer prepareToPlay];
    [self.avAudioPlayer play];
#else
    // play caf aiff ...etc simple format sound.
    SystemSoundID soundID;
    NSString *filePath = kSystemSoundPath(name, ext);
    NSURL *fileUrl = [NSURL URLWithString:filePath];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)fileUrl, &soundID);
    AudioServicesPlaySystemSound(soundID);
    
    if(soundID)
    {
        AudioServicesDisposeSystemSoundID(soundID);
        soundID = 0;
    }
#endif
}

- (void)setupLightStatusBarWithAnimated:(BOOL)animated
{

    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:animated];
}

- (void)setupLightStatusBar
{
    [self setupLightStatusBarWithAnimated:NO];
}

- (void)setupDarkStatusBarWithAnimated:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:animated];
}

- (void)setupDarkStatusBar
{
    [self setupDarkStatusBarWithAnimated:NO];
}

- (void)hideTabBar:(UITabBarController *)tabbarcontroller completion:(CompletionBlock)completion
{
    if (self.hideTabAnmiating || !self.isTabShow)
    {
        return;
    }
    __block UIView *transitView;
    self.hideTabAnmiating = YES;
    [UIView animateWithDuration:kTabAnimationDuration animations:^{
        for(UIView *view in tabbarcontroller.view.subviews)
        {
            if([view isKindOfClass:[UITabBar class]])
            {
                [view setFrame:CGRectMake(view.frame.origin.x, kScreenHeight, view.frame.size.width, view.frame.size.height)];
            }
            else
            {
                transitView = view;
            }
        }
        
    } completion:^(BOOL finished) {
        if (transitView != nil && finished)
        {
            [transitView setFrame:CGRectMake(0.0f, 0.0f, kScreenWidth, kScreenHeight)];
        }
        self.hideTabAnmiating = NO;
        self.isTabShow = NO;
        tabbarcontroller.tabBar.hidden = YES;
        if (completion)
        {
            completion();
        }
    }];
}

- (void)showTabBar:(UITabBarController *)tabbarcontroller completion:(CompletionBlock)completion
{
    if (self.showTabAnmiating || self.isTabShow)
    {
        return;
    }
    __block UIView *transitView;
    self.showTabAnmiating = YES;
    tabbarcontroller.tabBar.hidden = NO;
    [UIView animateWithDuration:kTabAnimationDuration animations:^{
        for(UIView *view in tabbarcontroller.view.subviews)
        {
            if([view isKindOfClass:[UITabBar class]])
            {
                [view setFrame:CGRectMake(view.frame.origin.x, kScreenHeight - kTabBarHeight, view.frame.size.width, view.frame.size.height)];
            }
            else
            {
                transitView = view;
            }
        }
    } completion:^(BOOL finished) {
        if (transitView != nil && finished)
        {
            [transitView setFrame:CGRectMake(0.0f, 0.0f, kScreenWidth, kScreenHeight - kTabBarHeight)];
        }
        self.showTabAnmiating = NO;
        self.isTabShow = YES;
        if (completion)
        {
            completion();
        }
    }];
}


@end
