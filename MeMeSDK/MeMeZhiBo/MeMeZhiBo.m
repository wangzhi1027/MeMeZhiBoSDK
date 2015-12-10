//
//  MeMeZhiBo.m
//  MeMeZhiBo
//
//  Created by XIN on 15/11/20.
//  Copyright (c) 2015年 XIN. All rights reserved.
//

#import "MeMeZhiBo.h"
#import "TheHallViewController.h"
#import "TTShowRemote+JuwanLogin.h"
#import "NSString+Hashes.h"
#import "NSDictionary+SafeValue.h"
#import "TTShowRemote+UserManager.h"
#import "NSBundle+SDK.h"
#import "TTShowRemote+TuijianList.h"
#import "TTShowRoom.h"
#import "RoomVideoViewController.h"

// http://api1.juwan.cn/PhoneAssistantServer/template/getJuwanUser.php?type=meme&key=JUWANMID5TEST1000016&module=verify
//http://api.memeyule.com/juwan/login?sign=f8b6f68a35199347e60d9ceb6634e663&_id=JW0945522RRLU&qd=juwan_lianyun

static NSString *const juwanBaseUrl = @"http://api1.juwan.cn/PhoneAssistantServer/template/getJuwanUser.php";
static NSString *const memeBaseUrl  = @"http://api.memeyule.com/juwan/login";
static NSString *const loginKey     = @"8c1cfb79e172ac066e6aced222773495";

typedef NS_ENUM(NSInteger, MeMeQd){ // 么么推广渠道号
    MeMeQdJuwan,                    // 聚玩推广
};

@interface MeMeZhiBo ()

@property (nonatomic, assign) BOOL isAuthorizedSuccess;
@property (nonatomic, strong) NSArray *memeQdArray;

@property (nonatomic, copy) NSString *user_name;
@property (nonatomic, copy) NSString *access_token;

@end

@implementation MeMeZhiBo

+ (instancetype)sharedInstance
{
    static MeMeZhiBo *memezhibo;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        memezhibo = [[[self class] alloc] init];
    });
    return memezhibo;
}

#pragma mark - Private Methods

- (void)authorizedWithToken:(NSString *)token isHall:(BOOL)isHall roomID:(NSInteger)roomID
{
    
    NSString *juwanUrl = [NSString stringWithFormat:@"%@?type=meme&key=%@&module=verify",juwanBaseUrl, token];
    
    [[MMAFAppDotNetAPIClient sharedClient] getPath:juwanUrl parameters:nil success:^(MMAFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:0];
        NSString *temp_user_name = [responseDic safeStringForKey:@"user_name"];
        self.user_name = [temp_user_name copy];
        
        if (!temp_user_name.length || temp_user_name.length <= 0) {
            
            UIAlertView  *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                             message:@"验证聚玩服务器失败" delegate:nil
                                                   cancelButtonTitle:@"确定"
                                                   otherButtonTitles:nil, nil];
            [alert show];
            
        } else {
            NSString *sign = [[NSString stringWithFormat:@"%@_%@",temp_user_name, loginKey] md5];
            [self retrieveMeMeServerLoginStatusWithUserName:temp_user_name andSign:sign isHall:isHall roomID:roomID];
        }
        
    } failure:^(MMAFHTTPRequestOperation *operation, NSError *error) {
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(authorizedFailed:)]) {
            [self.delegate performSelector:@selector(authorizedFailed:) withObject:error];
        }
    }];
}

- (void)getRoomMessage:(NSInteger)roomID
{
    [[Manager sharedInstance].dataManager.remote getLishiWithPage:[NSString stringWithFormat:@"%zd", roomID] completion:^(NSArray *array, NSError *error) {
        if (!error) {
            TTShowRoom *room = (TTShowRoom *)[array firstObject];
            [self enterRoom:room roomID:roomID];
        }
    }];
}

- (void)enterRoom:(TTShowRoom *)room roomID:(NSInteger)roomID
{
    [[Manager sharedInstance].dataManager.remote retrieveKickTtl:roomID completion:^(NSInteger count, NSError *error) {
        if (!error) {
            if (count <= 0) {
                RoomVideoViewController *rvc = [[RoomVideoViewController alloc] initWithNibName:@"RoomVideoViewController" bundle:[NSBundle SDKResourcesBundle]];
                [rvc setCurrentRoom:room];
                [rvc setEnterType:kVideoEnterMain];
                
                NavigationController *vnc = [[NavigationController alloc] initWithRootViewController:rvc];
                
                if (self.delegate && [self.delegate respondsToSelector:@selector(authorizedSuccessWithRoomVideoViewController:)]) {
                    [self.delegate authorizedSuccessWithRoomVideoViewController:vnc];
                }
            } else {
                [UIAlertView showInfoMessage:[NSString stringWithFormat:@"已被踢出房间,%ld秒后再进", (long)count]];
            }
        } else {
            [[Manager sharedInstance].uiManager showRoomVideoEnterType:kVideoEnterMain controller:nil room:room];
        }
    }];

}

#pragma mark - 具体房间

- (void)authorizedWithToken:(NSString *)token userName:(NSString *)userName roomID:(NSInteger)roomID
{
    [self authorizedWithToken:token isHall:NO roomID:roomID];
}

#pragma mark - 大厅

- (void)authorizedWithToken:(NSString *)token openUdid:(NSString *)udid;
{
    [self authorizedWithToken:token isHall:YES roomID:0];
}

#pragma mark -

- (void)retrieveMeMeServerLoginStatusWithUserName:(NSString *)userName andSign:(NSString *)sign isHall:(BOOL)isHall roomID:(NSInteger)roomID
{
    NSString *memeUrl = [NSString stringWithFormat:@"%@?sign=%@&_id=%@&qd=%@", memeBaseUrl, sign, userName, self.memeQdArray[MeMeQdJuwan]];
        
    [[MMAFAppDotNetAPIClient sharedClient] getPath:memeUrl parameters:nil success:^(MMAFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:0];
        if ([[responseDic safeNumberForKey:@"code"] isEqualToNumber:@(1)]) {
            
            NSString *temp_access_token = [responseDic safeStringForKey:@"access_token"];
            self.access_token = [temp_access_token copy];
            
            [[Manager sharedInstance].dataManager.remote updateUserInfo:temp_access_token completion:^(TTShowUser *user, NSError *error) {
                
                if (error) {
                    UIAlertView  *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                     message:@"取回么么服务器access_token失败"
                                                                    delegate:nil
                                                           cancelButtonTitle:@"确定"
                                                           otherButtonTitles:nil, nil];
                    [alert show];
                } else {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        [[Manager sharedInstance].dataManager updateUser];
                        
                        [kNotificationCenter postNotificationName:kNotificationUpdateUser object:nil];
                        
                        if (isHall) { //进入大厅
                            if (self.delegate && [self.delegate respondsToSelector:@selector(authorizedSuccessWithHallViewController:)]) {
                                TheHallViewController *theHallVC = [[TheHallViewController alloc] initWithNibName:@"TheHallViewController" bundle:[NSBundle SDKResourcesBundle]];
                                [self.delegate performSelector:@selector(authorizedSuccessWithHallViewController:) withObject:theHallVC];
                            }
                        } else { //进入直播间
                            [self getRoomMessage:roomID];
                        }
                    });
                }
            }];
        }
    } failure:^(MMAFHTTPRequestOperation *operation, NSError *error) {
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(authorizedFailed:)]) {
            [self.delegate performSelector:@selector(authorizedFailed:) withObject:error];
        }
    }];
}

#pragma mark - Setter/Getter

- (NSArray *)memeQdArray
{
    if (!_memeQdArray ) {
        
        _memeQdArray = @[@"juwan_lianyun"];
    }
    return _memeQdArray;
}

@end
