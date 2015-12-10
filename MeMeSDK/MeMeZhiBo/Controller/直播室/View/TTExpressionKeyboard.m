//
//  TTExpressionKeyboard.m
//  TTShow
//
//  Created by twb on 13-6-17.
//  Copyright (c) 2013年 twb. All rights reserved.
//
#import "TTExpressionKeyboard.h"
#import "TTPageControl.h"
#import "PacketImage.h"
#import "NSBundle+SDK.h"

#ifndef __EXPRESSION_GIF_PREVIEW_ON__
//#define __EXPRESSION_GIF_PREVIEW_ON__
#endif

#define kTTExpressionTotalCount (108)
#define kTTExpressionVIPPos (72)
#define kTTExpressionColumns (7)
#define kTTExpressionRows    (4)
#define kTTExpressionPaddingY (0.0f)
#define kTTExpressionSize (kTTExpressionRows * kTTExpressionColumns)

#define kExpresionSendButtonX (kScreenWidth - 80.0f - 5.0f)
#define kExpresionSendButtonY (self.frame.size.height - 30.0f - 5.0f)
#define kExpresionSendButtonWidth (80.0f)
#define kExpresionSendButtonHeight (30.0f)

@implementation TTExpressionKeyboard

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = kCommonBgColor;
        
        _emojiArray = [[NSMutableArray alloc] init];
        
        self.pageCount = (kTTExpressionTotalCount / kTTExpressionSize) + 1;
        
        for (NSUInteger i = 0; i < kTTExpressionTotalCount; i++)
        {
            @autoreleasepool
            {
#ifdef __EXPRESSION_GIF_PREVIEW_ON__
                [_emojiArray addObject:[UIImage sd_animatedGIFNamed:[NSString stringWithFormat:@"gif_expression_%d", i]]];
#else
                if(i < kTTExpressionVIPPos){
                    NSString *expGif = [NSString stringWithFormat:@"gif_expression_%lu.gif", (unsigned long)i];
                    [_emojiArray addObject:expGif];
                }else{
                    NSString *expGif = [NSString stringWithFormat:@"gif_vip_expression_%lu.gif", (unsigned long)i-kTTExpressionVIPPos];
                    [_emojiArray addObject:expGif];
                }
#endif
                if (((i + 1) % (kTTExpressionSize - 1)) == 0 || i == kTTExpressionTotalCount - 1)
                {
                    // Last One For Delete Expression.
                    [_emojiArray addObject:@"del_key_normal.png"];
                }
            }
        }
        
        // Custom Expression Symbols String Array.
        if (!_symbolArray)
        {
            NSString *expressionsPath = [[NSBundle SDKResourcesBundle] pathForResource:@"pics/TTShowExpression" ofType:@"plist"];
            _symbolArray = [NSArray arrayWithContentsOfFile:expressionsPath];
            
        }
        
        // Container
        UIScrollView *contentView = [[UIScrollView alloc] initWithFrame:self.bounds];
        self.scrollView = contentView;
        self.scrollView.pagingEnabled = YES;
        self.scrollView.contentSize = CGSizeMake(self.pageCount * kScreenWidth, self.bounds.size.height);
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.showsVerticalScrollIndicator = NO;
        self.scrollView.delegate = self;
        [self addSubview:self.scrollView];
        
        // Page
        TTPageControl *page = [[TTPageControl alloc] initWithFrame:CGRectMake(0.0f, self.bounds.size.height - 30.0f, kScreenWidth, 30.0f)];
        self.pageControl = page;
        self.pageControl.numberOfPages = self.pageCount;
        self.pageControl.currentPage = 0;
        [self.pageControl addTarget:self action:@selector(pageChanged:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:self.pageControl];
        
        NSInteger delCount = 0;
        NSInteger expressionsMax = _emojiArray.count;
        for (NSUInteger j = 0; j < expressionsMax; j++)
        {
            // Calculate origin in axis.
            CGFloat originX = (self.bounds.size.width / kTTExpressionColumns) * (j % kTTExpressionColumns) +
                                ((self.bounds.size.width / kTTExpressionColumns) - kTTExpressionSize ) / 2 +
                                (j / kTTExpressionSize) * kScreenWidth;
            CGFloat originY = ((j % kTTExpressionSize) / kTTExpressionColumns) *
                                ((self.bounds.size.height / kTTExpressionRows) * 0.78f) +
                                ((self.bounds.size.width / kTTExpressionColumns) - kTTExpressionSize ) / 2;
            @autoreleasepool
            {
                PacketImage *faceImage = [[PacketImage alloc] initWithFrame:CGRectMake(originX, originY + kTTExpressionPaddingY, kTTExpressionSize, kTTExpressionSize)];
                faceImage.image = kImageNamed(_emojiArray[j]);
                faceImage.userInteractionEnabled = YES;
                [faceImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(faceImageTap:)]];
                
                if ((j % kTTExpressionSize) == kTTExpressionSize - 1 || j == expressionsMax - 1)
                {
                    faceImage.imageIndex = -1;
                    delCount++;
                }
                else
                {
                    faceImage.imageIndex = j - delCount;
                }
                
                faceImage.layer.masksToBounds = YES;
                faceImage.layer.cornerRadius = 14;
                
                [self.scrollView addSubview:faceImage];
            }
        }
    }
    
//    self.sendBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    self.sendBtn.frame = CGRectMake(self.frame.size.width-80, self.frame.size.height-50, <#CGFloat width#>, <#CGFloat height#>)
    
    return self;
}

#pragma mark - Actions

- (void)faceImageTap:(UITapGestureRecognizer *)sender
{
    PacketImage *faceImage = (PacketImage *)[sender view];
    NSInteger index = faceImage.imageIndex;
    
    
    
    if (self.delegate)
    {
        if (index == -1)
        {
            // Last One For Delete Expression.
            if ([self.delegate respondsToSelector:@selector(didDeleteExpressionView:)])
            {
                
                [self.delegate didDeleteExpressionView:self];
            }
        }
        else
        {
            if ([self.delegate respondsToSelector:@selector(didTouchExpressionView:touchedExpression:flag:)])
            {
                [self.delegate didTouchExpressionView:self touchedExpression:[_symbolArray objectAtIndex:index] flag:index];
            }
        }
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

#pragma mark - UIScrollViewDelegate

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self.pageControl setCurrentPage:scrollView.contentOffset.x / kScreenWidth];
    [self.pageControl updateCurrentPageDisplay];
}

#pragma mark - event part.

//- (void)sendMsg:(id)sender
//{
//    [self.delegate sendMessage];
//}

- (void)pageChanged:(TTPageControl *)sender
{
    [self.scrollView setContentOffset:CGPointMake(self.pageControl.currentPage * kScreenWidth, 0) animated:YES];
    [self.pageControl setCurrentPage:self.pageControl.currentPage];
}

#pragma mark - Life Cycle

- (void)dealloc
{
    _delegate = nil;
    _emojiArray = nil;
    _symbolArray = nil;
    
//    self.sendMessageButton = nil;
    self.scrollView = nil;
    self.pageControl = nil;
}

@end
