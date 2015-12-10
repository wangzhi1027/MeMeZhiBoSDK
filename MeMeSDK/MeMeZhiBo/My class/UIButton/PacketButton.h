//
//  PacketButton.h
//  TTShow
//
//  Created by twb on 13-9-2.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PacketButton : UIButton

@property (nonatomic, assign) NSInteger packetIndex;
@property (nonatomic, strong) id packet;

@end
