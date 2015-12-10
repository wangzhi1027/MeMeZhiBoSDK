//
//  Manager.m
//  MeMeZhiBo
//
//  Created by XIN on 15/11/24.
//  Copyright (c) 2015年 XIN. All rights reserved.
//

#import "Manager.h"
#import "CyberPlayerController.h"

@implementation Manager

+ (instancetype)sharedInstance;
{
    static Manager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[[self class] alloc] init];
    });
    return manager;
}

- (instancetype)init
{
    if (self = [super init]) {
        NSString* msAK=@"26158772a91643f889b8f1c42c89cd8c";
        NSString* msSK=@"";
        //百度云播放器添加开发者信息
        [CyberPlayerController setBAEAPIKey:msAK SecretKey:msSK];
        [GlobalStatics initAll];
    }
    return self;
}

- (TTShowUIManager *)uiManager
{
    if (!_uiManager) {
        _uiManager = [TTShowUIManager sharedInstance];
    }
    return _uiManager;
}

- (TTShowDataManager *)dataManager
{
    if (!_dataManager) {
        _dataManager = [[TTShowDataManager alloc] init];
    }
    return _dataManager;
}

@end
