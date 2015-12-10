//
//  Manager.h
//  MeMeZhiBo
//
//  Created by XIN on 15/11/24.
//  Copyright (c) 2015年 XIN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTShowUIManager.h"
#import "TTShowDataManager.h"

@interface Manager : NSObject

+ (instancetype)sharedInstance;

@property (nonatomic, strong) TTShowDataManager *dataManager;
@property (strong, nonatomic) TTShowUIManager *uiManager;

@end
