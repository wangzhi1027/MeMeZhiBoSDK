//
//  NavigationStyleController.m
//  TTShow
//
//  Created by twb on 14-4-21.
//  Copyright (c) 2014年 twb. All rights reserved.
//

#import "NavigationStyleController.h"
#import <QuartzCore/QuartzCore.h>
#import <objc/runtime.h>

@interface NavigationStyleController ()

@end

@implementation NavigationStyleController
{
    BOOL isShowingAnimation;
    BOOL useIOS7Animation;
    UIImageView *img_shadow;
    UIPanGestureRecognizer *_panGestureRecognier;
}

- (id)init
{
    self = [super init];
	if (self)
    {
        [self setupPanGesture];
        [self setupShadow];
        [self setupAnimationMethod];
	}
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self)
    {
        [self setupPanGesture];
        [self setupShadow];
        [self setupAnimationMethod];
	}
    return self;
}

- (id)initWithRootViewController:(UIViewController *)rootViewController
{
	self = [super initWithRootViewController:rootViewController];
	if (self)
    {
        [self setupPanGesture];
        [self setupShadow];
        [self setupAnimationMethod];
	}
	return self;
}

#pragma mark - setup part.

- (void)setupCustomNavigation
{
    self.navigationBar.translucent = NO;//SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7");
    [self.navigationBar setBackgroundImage:kImageNamed(@"img_nav_bg_7.png")
                             forBarMetrics:UIBarMetricsDefault];
}

- (void)setupPanGesture
{
#if 1
    if (!_panGestureRecognier)
    {
        _panGestureRecognier = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                       action:@selector(handlePan:)];
        _panGestureRecognier.delegate = self;
        [self.view addGestureRecognizer:_panGestureRecognier];
    }
#endif
}

- (void)setupShadow
{
    if (!img_shadow)
    {
        img_shadow = [[UIImageView alloc] initWithImage:kImageNamed(@"img_nav_side_shadow.png")];
    }
}

- (void)setupAnimationMethod
{
//    useIOS7Animation = SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7");
}

#pragma mark - Push

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    UIView *curView = [self view];
    [curView endEditing:YES];
	
	if ([viewController respondsToSelector:@selector(isDrawerView)])
    {
        if ([viewController isDrawerView] && [self.viewControllers count] > 0)
        {
            [self initDrawerView:viewController];
            [self initBackImage:viewController.backImage];
            
            if (animated)
            {
                if (useIOS7Animation)
                {
                    [curView setTransform:CGAffineTransformMakeTranslation(kScreenWidth, 0)];
                    [super pushViewController:viewController animated:NO];
                    [UIView animateWithDuration:0.35f
                                          delay:0.0f
                                        options:UIViewAnimationOptionCurveEaseInOut
                                     animations:^(void){
                                         [curView setTransform:CGAffineTransformMakeTranslation(0, 0)];
                                         [_imageView setTransform:CGAffineTransformMakeTranslation(-kScreenWidth, 0.0f)];
                                     }completion:^(BOOL finish){
                                         
                                     }];
                }
                else
                {
                    [curView setTransform:CGAffineTransformMakeTranslation(kScreenWidth, 0)];
                    [super pushViewController:viewController animated:NO];
                    [UIView animateWithDuration:0.35f
                                          delay:0.0f
                                        options:UIViewAnimationOptionCurveEaseInOut
                                     animations:^(void){
                                         [curView setTransform:CGAffineTransformMakeTranslation(0, 0)];
                                         [_imageView setTransform:CGAffineTransformMakeScale(0.95, 0.95)];
                                         _imageView.alpha = 0.6;
                                     }completion:^(BOOL finish){
                                         
                                     }];
                }
                return;
            }
        }
    }
	[super pushViewController:viewController animated:animated];
}

#pragma mark - Pop part.

- (UIViewController *)popViewControllerWithoutAnimation
{
    return [super popViewControllerAnimated:NO];
}

- (void)reomoveBackImageWhenPopViewController
{
    if ([self.topViewController respondsToSelector:@selector(isDrawerView)])
    {
        UIViewController *curViewController = self.topViewController;
        if ([curViewController isDrawerView] && curViewController.backImage)
        {
            [self initBackImage:curViewController.backImage];
        }
        else if (_imageView)
        {
            [_imageView setImage:nil];
        }
    }
    
    if ([[self viewControllers] count] == 1 && _imageView)
    {
        [_imageView removeFromSuperview];
        _imageView = nil;
    }
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    if (animated)
    {
        UIView *curView = [self view];
        self.isPopAnimating = YES;
        if (useIOS7Animation)
        {
            [curView setTransform:CGAffineTransformMakeTranslation(0, 0)];
            [_imageView setTransform:CGAffineTransformMakeTranslation(-kScreenWidth, 0)];
            [UIView animateWithDuration:0.40f
                                  delay:0.0f
                                options:UIViewAnimationOptionCurveEaseInOut
                             animations:^(void){
                                 [curView setTransform:CGAffineTransformMakeTranslation(kScreenWidth, 0)];
                                 [_imageView setTransform:CGAffineTransformMakeTranslation(0, 0)];
                             }completion:^(BOOL finish){
                                 
                             }];
        }
        else
        {
            [curView setTransform:CGAffineTransformMakeTranslation(0, 0)];
            [_imageView setTransform:CGAffineTransformMakeScale(0.95, 0.95)];
            _imageView.alpha = 0.6;
            [UIView animateWithDuration:0.40f
                                  delay:0
                                options:UIViewAnimationOptionCurveEaseInOut
                             animations:^(void){
                                 [curView setTransform:CGAffineTransformMakeTranslation(kScreenWidth, 0)];
                                 _imageView.alpha = 1.0;
                                 [_imageView setTransform:CGAffineTransformMakeScale(1.0, 1.0)];
                             }completion:^(BOOL finish){

                             }];
        }
        
        // waiting animating finish in 0.5s in main thread.
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.5f]];
        
        isShowingAnimation = NO;
        self.isPopAnimating = NO;
        UIViewController *popVC = [self popViewControllerWithoutAnimation];
        [curView setTransform:CGAffineTransformMakeTranslation(0, 0)];
        [self reomoveBackImageWhenPopViewController];
        return popVC;
    }
    else
    {
        UIViewController *popVC = [self popViewControllerWithoutAnimation];
        [self reomoveBackImageWhenPopViewController];
        return popVC;
    }
}

- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated
{
	NSArray *poppedViewController = [super popToViewController:viewController animated:animated];
    if ([self.topViewController respondsToSelector:@selector(isDrawerView)])
    {
        UIViewController *curViewController = self.topViewController;
        if ([curViewController isDrawerView] && curViewController.backImage)
        {
            [self initBackImage:curViewController.backImage];
        }
        else if (_imageView)
        {
            [_imageView setImage:nil];
        }
    }
    if ([[self viewControllers] count] == 1 && _imageView)
    {
        [_imageView removeFromSuperview];
        _imageView = nil;
    }
	return poppedViewController;
}

- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated
{
	NSArray *poppedViewController = [super popToRootViewControllerAnimated:animated];
    if (_imageView)
    {
        [_imageView removeFromSuperview];
        _imageView = nil;
    }
	return poppedViewController;
}

- (void)popWithAnimation
{
    isShowingAnimation = YES;
    UIView *curView = [self view];
    self.isPopAnimating = YES;
    if (useIOS7Animation)
    {
        if (CGAffineTransformIsIdentity(curView.transform))
        {
            isShowingAnimation = NO;
            self.isPopAnimating = NO;
            [self popViewControllerAnimated:YES];
            return;
        }
        [UIView animateWithDuration:0.20f
                              delay:0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^(void){
                             [curView setTransform:CGAffineTransformMakeTranslation(kScreenWidth, 0)];
                             [_imageView setTransform:CGAffineTransformMakeTranslation(0, 0)];
                         }completion:^(BOOL finish){
                             [curView setTransform:CGAffineTransformMakeTranslation(0, 0)];
                             isShowingAnimation = NO;
                             self.isPopAnimating = NO;
                             [self popViewControllerAnimated:NO];
                         }];
    }
    else
    {
        [UIView animateWithDuration:0.20f
                              delay:0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^(void){
                             [curView setTransform:CGAffineTransformMakeTranslation(kScreenWidth, 0)];
                             _imageView.alpha = 1.0;
                             [_imageView setTransform:CGAffineTransformMakeScale(1.0, 1.0)];
                         }completion:^(BOOL finish){
                             [curView setTransform:CGAffineTransformMakeTranslation(0, 0)];
                             isShowingAnimation = NO;
                             self.isPopAnimating = NO;
                             [self popViewControllerAnimated:NO];
                         }];
    }
}

#pragma mark - Pan Gesture

- (void)handlePan:(UIPanGestureRecognizer*)panGestureRecognizer
{
    UIView *curView = [self view];
    
    CGPoint translation = [panGestureRecognizer translationInView:self.imageView];
    
    if ([[self viewControllers] count] > 1)
    {
        if (translation.x > 0)
        {
            if (!isShowingAnimation)
            {
                isShowingAnimation = YES;
                if (!img_shadow.superview)
                {
                    CGRect screenFrame = [[UIScreen mainScreen] bounds];
                    curView.clipsToBounds = NO;
                    [curView addSubview:img_shadow];
                    [img_shadow setFrame:CGRectMake(-6 , 0, 6, screenFrame.size.height)];
                }
            }
            
            [curView setTransform:CGAffineTransformMakeTranslation(translation.x, 0)];
            if (useIOS7Animation)
            {
                double translatedX = translation.x / 2.0f - 160;
                [_imageView setTransform:CGAffineTransformMakeTranslation(translatedX, 0)];
            }
            else
            {
                double scale = MIN(1.0f, 0.91 + translation.x / 4000);
                [_imageView setTransform:CGAffineTransformMakeScale(scale, scale)];
                double alpha = MIN(1.0f, 0.5 + translation.x / 500);
                _imageView.alpha = alpha;
            }
        }
        if (panGestureRecognizer.state == UIGestureRecognizerStateEnded)
        {
            if (translation.x > 100)
            {
                [self.topViewController backToPreviousViewController];
            }
            else
            {
                [self cancelPopWithAnimation];
            }
        }
    }
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (![self.topViewController respondsToSelector:@selector(isDrawerView)])
    {
        return NO;
    }
    UIViewController *lastViewController = self.topViewController;
    if (![lastViewController isDrawerView] || lastViewController.backImage == nil)
    {
        return NO;
    }
    CGPoint translation = [_panGestureRecognier translationInView:self.imageView];
    //    LOGINFO(@"x:%.2f", translation.x);
    return (translation.x > 0);
}

- (void)cancelPopWithAnimation
{
    UIView *curView = [self view];
    if (CGAffineTransformIsIdentity(curView.transform))
    {
        return;
    }
    [UIView animateWithDuration:0.2
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^(void){
                         [curView setTransform:CGAffineTransformMakeTranslation(0, 0)];
                         if (useIOS7Animation)
                         {
                             [_imageView setTransform:CGAffineTransformMakeTranslation(-160, 0)];
                         }
                         else
                         {
                             _imageView.alpha = 0.95;
                             [_imageView setTransform:CGAffineTransformMakeScale(0.95, 0.95)];
                         }
                     }completion:^(BOOL finish){
                         isShowingAnimation = NO;
                     }];
}

#pragma mark - initDrawerView

- (void)initDrawerView:(UIViewController *)viewController
{
    UIView *curView = nil;
    if (self.tabBarController && viewController.hidesBottomBarWhenPushed)
    {
        curView = self.tabBarController.view;
    }
    else
    {
        curView = self.view;
    }
    
    if (UIGraphicsBeginImageContextWithOptions != NULL)
    {
        UIGraphicsBeginImageContextWithOptions(curView.frame.size, curView.opaque, 0.0);
    }
    else
    {
        UIGraphicsBeginImageContext(curView.frame.size);
    }
    
    [curView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *lastViewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [viewController setBackImage:lastViewImage];
}

- (void)initBackImage:(UIImage *)backImage
{
    if (!_imageView)
    {
        _imageView = [[UIImageView alloc] initWithImage:backImage];
        _imageView.frame  = self.view.frame;
        _imageView.backgroundColor = [UIColor clearColor];
        [self.view.superview insertSubview:_imageView atIndex:0];
    }
    else
    {
        [_imageView setImage:backImage];
        [_imageView setTransform:CGAffineTransformMakeScale(1, 1)];
        _imageView.alpha = 1;
        [_imageView setTransform:CGAffineTransformMakeTranslation(0, 0)];
    }
}

#pragma mark -
#pragma mark View Life Methods

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self setupCustomNavigation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    if (_imageView)
    {
        [_imageView removeFromSuperview];
        _imageView = nil;
    }
}

@end

@implementation UIViewController (TTNavigationController)

@dynamic backImage;

static char const * const BackImageTag = "BackImageTag";

- (void)setBackImage:(UIImage *)backImage
{
    objc_setAssociatedObject(self, BackImageTag, backImage, OBJC_ASSOCIATION_RETAIN);
}

- (UIImage *)backImage
{
    return objc_getAssociatedObject(self, BackImageTag);
}

- (BOOL)isDrawerView
{
    return YES;
}

- (UIBarButtonItem *)backBarButtonItem
{
    return [[UIBarButtonItem alloc] initWithTitle:@"返回"
                                            style:UIBarButtonItemStylePlain
                                           target:self
                                           action:@selector(backToPreviousViewController)];
}

- (void)backToPreviousViewController
{
	if ([self.navigationController isKindOfClass:[NavigationStyleController class]])
    {
        NavigationStyleController *navController = (NavigationStyleController *)self.navigationController;
        if ([self respondsToSelector:@selector(isDrawerView)])
        {
            if ([self isDrawerView] && [navController.viewControllers count] > 1)
            {
                [navController popWithAnimation];
                return;
            }
        }
    }
    
	[self.navigationController popViewControllerAnimated:YES];
}

- (void)cancelBackToPreviousViewController
{
	if (![self.navigationController isKindOfClass:[NavigationStyleController class]])
    {
        return;
    }
    
    NavigationStyleController *navController = (NavigationStyleController *)self.navigationController;
    [navController cancelPopWithAnimation];
}

@end
