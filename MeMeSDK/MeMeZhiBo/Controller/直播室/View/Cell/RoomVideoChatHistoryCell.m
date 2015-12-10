//
//  RoomVideoChatHistoryCell.m
//  TTShow
//
//  Created by twb on 13-6-6.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import "RoomVideoChatHistoryCell.h"
#import "TTMultiLineView.h"

@implementation RoomVideoChatHistoryCell

- (id)init
{
    self = [super init];
    if (self)
    {
        // Initialization code
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectZero];
        bgView.backgroundColor = [UIColor colorWithWhite:0.9f alpha:0.9f];
        self.selectedBackgroundView = bgView;
    }
    return self;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectZero];
        bgView.backgroundColor = [UIColor colorWithWhite:0.9f alpha:0.9f];
        self.selectedBackgroundView = bgView;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)addChatContent:(TTMultiLineView *)contentView
{
    [self.contentView addSubview:contentView];
}

/*
 * Fixed gif reusing issumes.
 * playing gif once if you don't overwrite prepareForReuse
 * haha. thanks this url: http://stackoverflow.com/questions/16530942/uiimage-in-uitableview-displaying-the-other-cells-image-for-a-second
 */
- (void)prepareForReuse
{
    for (UIView *v in self.contentView.subviews)
    {
        if ([v isKindOfClass:[UIImageView class]])
        {
            [(UIImageView *)v setImage:nil];
        }
        [v removeFromSuperview];
    }
    
    [super prepareForReuse];
}

#pragma mark - Life cycle.

- (void)dealloc
{
//    for (UIView *v in self.contentView.subviews)
//    {
//        for (UIView *vv in v.subviews)
//        {
//            if ([vv isKindOfClass:[UIImageView class]])
//            {
//                [(UIImageView *)vv setImage:nil];
//            }
//            [vv removeFromSuperview];
//        }
//        [v removeFromSuperview];
//    }
}

@end
