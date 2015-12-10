//
//  TTShowScrollSegment.m
//  TTShow
//
//  Created by twb on 13-8-5.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import "TTShowScrollSegment.h"

#define kScrollItemWidth (80.0f)
#define kScrollItemHeight (35.0f)
#define kScrollItemDeviation (30.0f)

@implementation TTShowScrollSegment

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.scrollView.delegate = self;
    self.scrollView.frame = CGRectMake(0, 0, kScreenWidth, 36);
    self.scrollView.backgroundColor = kRGB(60, 54, 56);
    
//    self.left.frame = CGRectMake(0.0f, 0.0f, 14.0f, 34.0f);
//    self.right.frame = CGRectMake(kScreenWidth - 14.0f, 0.0f, 14.0f, 34.0f);
    
//    self.bg.frame = CGRectMake(0.0f, 0.0f, kScreenWidth, 34.0f);
//    self.bg.image = [kImageNamed(@"img_live_toolview_bg.png") resizableImageWithCapInsets:UIEdgeInsetsMake(10.0f, 1.0f, 10.0f, 1.0f)];
    
}

- (void)setItems:(NSArray *)items
{
    _items = items;
    
    if (items.count == 0)
    {
        return;
    }
    
    [self.scrollView setContentSize:CGSizeMake(kScrollItemWidth * items.count, kScrollItemHeight)];
    
    if (itemButtons == nil)
    {
        itemButtons = [NSMutableArray arrayWithCapacity:0];
    }
    
    NSInteger i = 0;
    for (NSString *item in items)
    {
        PacketButton *button = [PacketButton buttonWithType:UIButtonTypeCustom];
        button.packetIndex = i;
        [button.titleLabel setFont:kFontOfSize(13.0f)];
        [button setTitleColor:kRGB(153.0f, 153.0f, 153.0f) forState:UIControlStateNormal];
        [button setTitle:item forState:UIControlStateNormal];
        button.frame = CGRectMake(i * kScrollItemWidth, 0.0f, kScrollItemWidth, kScrollItemHeight);
        [button addTarget:self action:@selector(itemAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:button];
        [itemButtons addObject:button];
        i++;
    }
}

- (void)setSelectedIndex:(NSInteger)selectedIndex
{
    if (itemButtons.count == 0)
    {
        return;
    }
    
    if (selectedIndex >= itemButtons.count)
    {
        _selectedIndex = itemButtons.count - 1;
    }
    else
    {
        _selectedIndex = selectedIndex;
    }
    
    if (selectedIndex == -1)
    {
        _selectedIndex = 0;
    }
    else
    {
        _selectedIndex = selectedIndex;
    }
    
    NSInteger i = 0;
    for (PacketButton *faceButton in itemButtons)
    {
        if (i == selectedIndex)
        {
//            [faceButton setBackgroundImage:[kImageNamed(self.selectedBgStr) resizableImageWithCapInsets:self.selectedImagesInset] forState:UIControlStateNormal];
//            [faceButton setBackgroundImage:[kImageNamed(self.selectedBgStr) resizableImageWithCapInsets:self.selectedImagesInset] forState:UIControlStateHighlighted];
            [faceButton setTitleColor:kRGB(255.0f, 160.0f, 0.0f) forState:UIControlStateNormal];
            [faceButton setTitleColor:kRGB(255.0f, 160.0f, 0.0f) forState:UIControlStateHighlighted];
        }
        else
        {
//            [faceButton setBackgroundImage:[kImageNamed(self.normalBgStr) resizableImageWithCapInsets:self.normalImagesInset] forState:UIControlStateNormal];
//            [faceButton setBackgroundImage:[kImageNamed(self.normalBgStr) resizableImageWithCapInsets:self.normalImagesInset] forState:UIControlStateHighlighted];
            [faceButton setTitleColor:kRGB(153.0f, 153.0f, 153.0f) forState:UIControlStateNormal];
            [faceButton setTitleColor:kRGB(153.0f, 153.0f, 153.0f) forState:UIControlStateHighlighted];
        }
        
        i++;
    }
    
    // Scroll Category, this logic need optimizing...
    if (self.items.count * kScrollItemWidth > kScreenWidth + kScrollItemDeviation)
    {
        if (selectedIndex < (kScreenWidth / kScrollItemWidth))
        {
            [self.scrollView setContentOffset:CGPointMake(0.0f, 0.0f) animated:YES];

        }
        else
        {
            if ((selectedIndex + 1) * kScrollItemWidth > kScreenWidth)
            {
                [self.scrollView setContentOffset:CGPointMake(kScrollItemWidth * selectedIndex, 0.0f) animated:YES];

            }
        }
    }
    else
    {

    }
}
#pragma mark - Event part.

- (void)itemAction:(PacketButton *)sender
{
    [self setSelectedIndex:sender.packetIndex];
    [self.delegate selectItem:sender.packetIndex];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    LOGINFO(@"%.2f", scrollView.contentOffset.x);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
