//
//  TTShowRemote+JuwanLogin.m
//  MeMeZhiBo
//
//  Created by XIN on 15/11/25.
//  Copyright (c) 2015年 XIN. All rights reserved.
//

#import "TTShowRemote+JuwanLogin.h"
#import "NSString+Hashes.h"
#import "NSDictionary+SafeValue.h"
#import "TTShowRemote+UserManager.h"

// http://api1.juwan.cn/PhoneAssistantServer/template/getJuwanUser.php?type=meme&key=JUWANMID5TEST1000016&module=verify


//http://api.memeyule.com/juwan/login?sign=f8b6f68a35199347e60d9ceb6634e663&_id=JW0945522RRLU&qd=juwan_lianyun

static NSString *const juwanBaseUrl = @"http://api1.juwan.cn/PhoneAssistantServer/template/getJuwanUser.php";
static NSString *const memeBaseUrl = @"http://api.memeyule.com/juwan/login";

@implementation TTShowRemote (JuwanLogin)

- (void)retrieveJuwanLoginStatusWithToken:(NSString *)_id
                                  success:(void(^)(NSData *data))finishBlock
                                   failed:(void(^)(NSError *error))failedBlock;
{
    NSString *juwanUrl = [NSString stringWithFormat:@"%@?type=meme&key=%@&module=verify",juwanBaseUrl, _id];
    
    [[MMAFAppDotNetAPIClient sharedClient] getPath:juwanUrl parameters:nil success:^(MMAFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:0];
        NSString *user_name = [responseDic safeStringForKey:@"user_name"];
        
        if (!user_name.length || user_name.length <= 0) {
            return ;
        } else {

            NSString *sign = [[NSString stringWithFormat:@"%@_%@", user_name, @"8c1cfb79e172ac066e6aced222773495"] md5];
            [self retrieveMeMeServerLoginStatusWithUserName:user_name andSign:sign];
        }
    } failure:^(MMAFHTTPRequestOperation *operation, NSError *error) {
        failedBlock(error);
        UIAlertView  *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"验证聚玩服务器失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }];
}

- (void)retrieveMeMeServerLoginStatusWithUserName:(NSString *)userName andSign:(NSString *)sign
{
    NSString *memeUrl = [NSString stringWithFormat:@"%@?sign=%@_id=%@&qd=juwan_lianyun", memeBaseUrl, sign, userName];
    
    [[MMAFAppDotNetAPIClient sharedClient] getPath:memeUrl parameters:nil success:^(MMAFHTTPRequestOperation *operation, id responseObject) {

        NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:0];
        if ([[responseDic safeNumberForKey:@"code"] isEqualToNumber:@(1)]) {
            NSString *access_token = [responseDic safeStringForKey:@"access_token"];
            
            [self.dataManager.remote updateUserInfo:access_token completion:^(TTShowUser *user, NSError *error) {

                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [self.dataManager updateUser];
     
                    [kNotificationCenter postNotificationName:kNotificationUpdateUser object:nil];
                });
            }];
        }
        
    } failure:^(MMAFHTTPRequestOperation *operation, NSError *error) {
    }];
}

@end
