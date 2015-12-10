//
//  TableViewCell.m
//  TTShow
//
//  Created by twb on 13-9-11.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell

- (id)init
{
    self = [super init];
    if (self)
    {
        // Initialization code
        self.backgroundColor = kClearColor;
    }
    return self;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = kClearColor;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    // Adapt iOS7
    self.backgroundColor = kClearColor;
}

@end
