//
//  TTShowRemote.m
//  memezhibo
//
//  Created by Xingai on 15/5/14.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "TTShowRemote.h"
#import "TTShowRemote+System.h"
#import "FilterCondition.h"
#import "TTShowRemote+Favor.h"
#import "TTShowRemote+UserManager.h"
#import "TTShowRemote+Main.h"
#import "TTShowRemote+UserInfo.h"
#import "TTShowRemote+RankList.h"
#import "TTShowRemote+TheHall.h"
#import "TTShowRemote+ManageStar.h"
#import "TTShowRemote+Friend.h"
#import "TTShowRemote+Live.h"
#import "TTShowRemote+Charge.h"


@implementation TTShowRemote

#pragma mark - system part.

+ (instancetype)sharedInstance
{
    static id instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init];
    });
    
    return instance;
}


- (TTShowDataManager *)dataManager
{
    return [Manager sharedInstance].dataManager;
}

- (id)init
{
    urlArray = @[@"/public/room_list",                           // 获取主播列表
                 @"/public/poster/2",                            // 海报
                 @"/public/t_hex",                               // 服务器时间戳
                 @"/public/http_pull_url/%d",                     //@"/public/hls_pull_url/%d" // 获取视频地址
                 @"/user/info/%@?qd=%@",                         // 获取用户信息retrieve_user_information_index
                 @"/zone/user_medal/%d",                         // 获取用户徽章
                 @"/zone/user_medal/%d?mid=%d",                  // 获取用户徽章详细信息
                 @"/user/pay_log/%@",                            // 充值记录
                 @"/user/luck_log/%@",                           // 中奖记录
                 @"/user/cost_log/%@",                           // 消费记录
                 @"/user/gift_rec/%@",                           // 收礼记录?page=%d&size=%d
                 @"/show/gift_list",                             // 礼物列表
                 @"/room/send_gift/%@/%d/%d?count=%d&user_id=%d",// 发送礼物token,roomId,giftId send_gift_index
                 @"/room/bag_gift/%@/%d/%d?count=%d&user_id=%d",// 送背包礼物token,roomId,giftId send_bag_gift_index
                 @"/fortune/send_fortune/%@/%d?count=%d",       // 送财神礼物token,roomId,count send_fortune_index
                 @"/public/room_star/%d",                        // 获取主播信息
                 @"/rank/room_user_%@/%d?size=%d",               // 消费排名
                 @"/user/%@/%@",                                 // 上传用户头像
                 @"/user/edit/%@",                               // 上传编辑后的用户信息
                 @"/rank/star_%@/%d",                            // 明星榜
                 @"/rank/song_%@/%d",                            // 点播榜
                 @"/rank/feather_%@/%d",                         // 魅力榜
                 @"/user/add_following/%@/%d",                   // 添加关注
                 @"/user/del_following/%@/%d",                   // 取消关注
                 @"/user/following_list/%@",                     // 我关注的主播
                 @"/user/managed_rooms?access_token=%@",         // 我管理的主播
                 @"/user/bag_info/%@",                            // 背包user_bag_index
                 @"/rank/user_%@/%d",                            // 财富排行
                 @"/rank/gift_week/%d",                          // 本周礼物周星
                 @"/gift_rank/latest.js",                        // 上周礼物周星
                 @"/show/history_special_gift?page=%d&size=%d",  // 历史奇迹礼物
                 @"/mission/list/%@[%d]",                        // 任务列表
                 @"/user/authcode/%@",                           // 获取验证码
                 @"/mission/award/%@?mission_id=%@",// 领取任务金币
                 @"/public/visiter_count",                       // 在线人数
                 @"/public/room_admin/%d",                       // 房间管理员列表
                 @"/user/shutup_ttl/%@/%d",                      // 禁止发言列表
                 @"/user/kick_ttl/%@/%d",                        // 踢出房间列表
                 @"/feather/amass/%@?uid=%@",                    // 积攒么么 客户端每十分钟请求一次即可
                 @"/feather/send/%@/%d",                         // 送么么
                 @"/show/cars_list",                             // 座驾列表
                 @"/user/exchange/%@/%lli",         // 维C兑换柠檬
                 @"/user/exchange_log/%@?page=%d&size=%d",       // 兑换柠檬历史记录
                 @"/shop/buy_car/%@/%d",                         // 买座驾
                 @"/shop/buy_vip/%@/%d?room_id=%d",              // 买VIP
                 @"/shop/buy_vip2/%@/%d?room_id=%d",             // 买至尊VIP
                 @"/shop/renew_vip/%@/%d?room_id=%d",            // 续费VIP
                 @"/shop/renew_vip2/%@/%d?room_id=%d",           // 续费至尊VIP
                 @"/user/car_info/%@",                           // 我的座驾信息
                 @"/shop/set_curr_car/%@/%d",                    // 设置默认座驾
                 @"/shop/unset_curr_car/%@",                     // 取消默认座驾
                 @"/shop/del_car/%@/%d",                         // 删除座驾
                 @"/public/room_viewer/%d?page=%d&size=%d",      // 观众列表
                 @"/show/yesterday_special_gift",                // 昨日奇迹
                 @"/show/today_special_gift/%d",                 // 今日奇迹
                 @"/room/broadcast/%@/%d?content=%@&horn=1",     // 发广播
                 @"/user/day_login/%@?uid=%@",                   // 每日设备登记
                 @"/apple/ipn/%@?test=%d",                               // AppStore充值, IAP
                 @"/apple/register/%@?device_token=%@",          // 上传DeviceToken
                 @"/user/vip_hiding/%@/%d",                      // VIP隐身:1为隐身,0为显示
                 @"/public/feedback?contact=%@&content=%@",      // 反馈意见
                 @"/zone/photo_count/%d",                        // 获取主播照片数量
                 @"/photo/praise/%@?path=%@",                    // 赞主播照片
                 @"/zone/photo_list/%d?type=%d&page=%d&size=%d", // 获取主播照片列表
                 @"/zone/user_info/%d",                          // 根据用户ID获取用户信息
                 @"/rank/all_rank/3?apple=1",                            // 排行榜前3名
                 @"/public/room_sofa/%d",                        // 沙发列表(..._sofa/:room_id)
                 @"/live/grab_sofa%d/%@/%d/%d",                  // 抢沙发(..._sofa:sofa_id/:access_token/:room_id/:coin_price)
                 @"/sign/list/%@",                               // 签到记录(sign/list/:access_token)
                 @"/sign/award/%@/%d",              // 签到奖励 (...rd/:access_token/:type?auth_code=*)
                 @"/live/puzzle_win/%@/%d?step=%d",              // 完成拼图 (..._win/:access_token/:room_id?step=)
                 @"/activevalue/active_rank/%d?size=%d",         // 活跃榜 (..ank/:roomid?size=%d)
                 @"/room/active_user/%@/%d",                     // 活跃值...ser/{access_token}/{room_id}
                 @"/room/add_active_value/%@/%d",                // 增加活跃值 ...lue/{access_token}/{room_id}
                 @"/tenpay/order_wap?_id=%d&amount=%d",          // 获取财付通WAP支付地址(wap?_id=userid&amount=金额)
                 @"/pay/ali_wap_sign?_id=%d&total_fee=%d",       // 获取支付宝WAP支付地址(...sign?_id=userid&total_fee=金额)
                 @"/manage/shutup/%@/%d/%d?minute=%d",           // 禁止发言 (...token/:room_id/:xy_user_id?minute=60)
                 @"/manage/recover/%@/%d/%d",                    // 恢复发言 (...token/:room_id/:xy_user_id)
                 @"/manage/kick/%@/%d/%d?minute=%d",             // 踢出房间 (...token/:room_id/:xy_user_id?minute=60)
                 
                 @"/msg/list/%@",                                // 通知列表(:access_token?page&size)
                 @"/msg/unread_count/%@",                        // 未读通知数量(:access_token)
                 @"/msg/info/%@/%@",                             // 通知明细(:access_token/:_id)
                 @"/msg/del/%@/%@",                              // 删除通知(:access_token/:_id)
                 @"/msg/mark_read/%@/%@",                        // 标记通知已读(:access_token/:_id)
                 @"/remind/list/%@",                             // 提醒列表(:access_token)
                 @"/remind/unread_count/%@",                     // 未读提醒数量(:access_token)
                 @"/remind/mark_read/%@/%@",                     // 标记提醒为已读(:access_token/:remind_id)
                 @"/remind/del/%@/%@",                           // 删除提醒(:access_token/:remind_id)
                 @"/remind/set/%@/%@",                           // 设置不再提醒(:access_token/:remind_id)
                 
                 @"/yujian/login",                               // 遇见登录 (?openid=%@&sessionkey=%@)
                 @"/authcode/send_mobile?mobile=%@&type=1",      // 绑定手机号码
                 @"/user/bind_mobile/%@?mobile=%@&sms_code=%@", // 验证手机号码
                 //好友
                 @"/friend/search?access_token=%@&id1=%@",       //搜索好友
                 @"/friend/apply?access_token=%@&id1=%d",                             //申请加好友
                 @"/friend/apply_list?access_token=%@&page=%d&size=%d",                            //好友申请列表
                 @"/friend/refuse?access_token=%@&id1=%d",                         //拒绝好友申请
                 @"/friend/del_apply?access_token=%@",                             //删除好友申请
                 @"/friend/agree?access_token=%@&id1=%d",                          //接受好友申请
                 @"/friend/list?access_token=%@",                                  //好友列表friend_friend_list
                 @"/friend/delete?access_token=%@&id1=%d",                         //删除好友
                 @"/friend/is_friend?access_token=%@&id1=%d",                      //是否朋友关系
                 @"/friend/add_blacklist?access_token=%@&id1=%d",                               //加入黑名单
                 @"/friend/blacklist?access_token=%@",                             //黑名单列表
                 @"/friend/del_blacklist?access_token=%@&id1=%d",                  //移除黑名单列表
                 @"/friend/refuse_apply?access_token=%@&status=%d",                //设置不被任何人添加为好友
                 
                 
                 //小窝
                 @"/nest/apply_list?access_token=%@&page=%d&size=%d",    // 申请列表(status: 0:未处理,1:已通过 2:未通过)
                 @"/nest/audit?access_token=%@&apply_id=%@&status=%d",   //主播审核申请 (1:已通过 2:未通过)
                 @"/nest/del_apply?access_token=%@&apply_id=%@",         //                 主播删除申请记录
                 @"/nest/kick?access_token=%@&id1=%d",                   //                 把用户踢出小窝
                 @"/nest/create?access_token=%@",                       //开通小窝  &name=%@&notice=%@&pic=%@
                 @"/nest/edit?access_token=%@",                         //编辑小窝  &name=%@&notice=%@&pic=%@
                 @"/nest/apply?access_token=%@&id1=%d",                                   //加入小窝
                 @"/nest/exit?access_token=%@&id1=%d",                                    //退出小窝
                 @"/nest/mine?access_token=%@",                                           //我的小窝
                 @"/show/nest_gift_list",                                                  //小窝礼物列表
                 @"/nest/send_gift?access_token=%@&id1=%d&id2=%d&count=%d&user_id=%d",                 //小窝送礼
                 @"/nest/my_list?access_token=%@&page=%d&size=%d&list_field=id",         //我加入的小窝ID列表
                 @"/nest/my_list?access_token=%@&page=%d&size=%d",                       //我加入的小窝列表
                 @"/nest/shutup?access_token=%@&id1=%d&id2=%d&minute=%d",                //小窝禁言
                 @"/nest/shutup_ttl?access_token=%@&id1=%d",                             //小窝禁言时间
                 @"/nest/photo_add?access_token=%@&id1=%d&path=%@",                      //上传照片
                 @"/nest/photo_del?access_token=%@&path=%@",                             //删除照片
                 @"/nestpublic/list?page=%d&size=%d",                                    //小窝列表
                 @"/nestpublic/info?id1=%d",                                             //小窝信息
                 @"/nestpublic/pic_list?id1=%d&size=%d&page1=%d",                        //小窝图片列表
                 @"/nestpublic/member_list?id1=%d&size=%d&page1=%d",                     //小窝成员列表
                 @"/user/upload_pic/%@/%d",                                              // 上传小窝头像
                 @"/user/upload_pic?id1=%d",                                              // 上传小窝背景
                 @"/photo/nest_photo_token?access_token=%@",                               //又拍云小窝图片上传token
                 @"/photo/nest_audio_token?access_token=%@",                               //又拍云小窝语音上传token
                 
                 @"/public/blackword_list/0",                                               //昵称敏感词
                 @"/public/blackword_list/1",                                               //聊天敏感词
                 @"/api/history?wo_id=%d&timestamp=%lld",                                //获取小窝历史记录
                 @"/api/unread?wo_ids=%d&user_id=%d&timestamp=%lld",                 //获取小窝未读消息

                 @"MAX, don't touch the last line.",
                 @"/app/index",                                 //主播推荐
                 @"/public/family_list?page=1&size=1",           //开通家族主播数
                 
                 @"/register/checkmobile?mobile=%@",                 //验证手机号码是否注册
                 @"/authcode/send_mobile?mobile=%@",                 //发送验证码
                 @"/register/mobile?sms_code=%@&pwd=%@&mobile=%@",   //验证码登录
                 
                 @"/public/room_found_latest?page=1&sort=1&size=50",      //推荐主播list接口
                 
                 @"/public/room_list?page=1&ebean=2147483647&sbean=1616000&size=30",  //超星接口
                 @"/rank/family_rank?size=50",                   //家族接口
                 
                 @"/public/room_by_ids?ids=",                            //看过请求数据    参数例子ids=11710736_5380081_6714954_11673058_7485426_1205135_10923283_1880623_4818390_10785731_9209131_6785649_6717404
                 @"/public/new_recomm_list?size=50",            //优秀新人
                 @"/public/blackword_list/0",                     //关键字
                 @"/public/blackword_list/1",
                 @"/nestlive/on?access_token=%@&id1=%d&mic=%d",    //上麦
                 @"/nestpublic/room_viewer?id1=%d&size=%d&page1=%d",   //小窝在线用户
                 @"/nestpublic/nest_admins?id1=%d",                  //小窝嘉宾列表
                 @"/nestmng/add_admin?access_token=%@&id1=%d&id2=%d",     //小窝设置嘉宾 (id1:小窝ID，id2:用户ID)
                 @"/nestmng/del_admin?access_token=%@&id1=%d&id2=%d",       //小窝取消嘉宾
                 @"/nest/is_following?access_token=%@&id1=%d",               //是否关注过小窝
                 @"/nest/add_following?access_token=%@&id1=%d",              //关注小窝
                 @"/nest/del_following?access_token=%@&id1=%d",               //取消关注小窝
                 @"/nestlive/kick?access_token=%@&id1=%d&kick_uid=%d",         //小窝踢麦
                 @"/nest/send_packet?access_token=%@&nest_id=%d&coins=%d&amount=%d", //小窝发红包
                 @"/nestpublic/redpacket?id1=%d",                               //小窝红包list
                 @"/nest/draw_packet?access_token=%@&nest_id=%d&redpacket_id=%@&s=%@", //小窝抢红包
                 @"/nestpublic/redpacket_grab_log?id1=%d&redpacket_id=%@",              //红包状态
                 @"/nestlive/push_url?access_token=%@&id1=%d",           //小窝上麦推流地址
                 @"/nestlive/pull_url?access_token=%@&id1=%d&id2=%d",      //小窝上麦拉流地址
                 @"/nestlive/off?access_token=%@&id1=%d",                    //小窝下麦
                 @"/nestlive/heartbeat?access_token=%@&id1=%d",               //小窝上麦后心跳
                 @"/nestmng/kick?access_token=%@&id1=%d&id2=%d",               //小窝踢人
                 @"/nestmng/kick_ttl?access_token=%@&id1=%d"                  //被踢出小窝时间确认
                 ];
    
    return [super init];
}

- (NSString *)baseURLStr
{
    return [FilterCondition sharedInstance].baseUrlStr;
}

-(NSString *)userURLStr
{
    return kbaseUserURL;
}

- (NSDictionary *)parseJson:(id)responseObject
{
    NSError *error;
    NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
    //    LOGINFO(@"JSON = %@", jsonData);
    return jsonData;
}

#pragma mark - user info part.

// upload user information


//system
- (void)requestSensitiveNickNames:(SuccessBlock)successBlock failBlock:(FailBlock)failBlock
{
    [self _requestSensitiveNickNames:successBlock failBlock:failBlock];
}

- (void)requestSensitiveWords:(SuccessBlock)successBlock failBlock:(FailBlock)failBlock
{
    [self _requestSensitiveWords:successBlock failBlock:failBlock];
}

- (void)collectLog
{
    [self _collectLog];
}

- (void)dayLoginWith:(NSString *)deviceUID
{
    [self _dayLoginWith:deviceUID];
}

- (void)registerDeviceToken:(NSString *)deviceToken
{
    [self _registerDeviceToken:deviceToken];
}

#pragma mark - favor part.

- (void)followingForStar:(NSUInteger)star_id add:(BOOL)isAdd completion:(RemoteCompletionBool)completion
{
    [self _followingForStar:star_id add:isAdd completion:completion];
}

- (void)followingListWithCompletion:(RemoteCompletionArray)completion
{
    [self _followingListWithCompletion:completion];
}


// User Register.

- (void)loginFromThirdParty:(NSString *)urlString completion:(RemoteCompletionUser)completion
{
    [self _loginFromThirdParty:urlString completion:completion];
}

- (void)loginFrom3rdPartySDK:(NSDictionary *)param completion:(RemoteCompletionUser)completion
{
    [self _loginFrom3rdPartySDK:param completion:completion];
}

- (void)updateUserInformationWithCompletion:(RemoteCompletionUser)completion
{
    [self _updateUserInformationWithCompletion:completion];
}


#pragma mark - main part.

-(void)retrieveTheHallimage:(RemoteCompletionArray)completion
{
    [self _retrieveTheHallimage:completion];
}

- (void)retrieveRoomListWithParams:(NSDictionary *)params completion:(RemoteCompletionArray)completion
{
    [self _retrieveRoomListWithParams:params completion:completion];
}


- (void)retrieveKickTtl:(NSInteger)roomID completion:(RemoteCompletionInteger)completion
{
    [self _retrieveTTL:kRoomKickTTL room:roomID completion:completion];
}

//login
- (void)userLogin:(NSString *)userName password:(NSString *)password key:(NSString*)key completion:(RemoteCompletionUser)completion
{
    [self _userLogin:userName password:password key:key completion:completion];
}

#pragma mark - user info part.

// upload user information
- (void)retrieveUserInfo:(NSInteger)userID completion:(RemoteCompletionUser)completion
{
    [self _retrieveUserInfo:userID completion:completion];
}

#pragma mark - manage star part

- (void)manageStarListWithCompletion:(RemoteCompletionArray)completion
{
    [self _manageStarListWithCompletion:completion];
}

#pragma mark - RoomVideo

- (void)retrieveRoomStar:(NSUInteger)roomID WithBlock:(void (^)(TTShowRoomStar *roomStar, NSError *error))block
{
    [self _retrieveRoomStar:roomID WithBlock:block];
}

- (void)retrieveRoomManagers:(NSUInteger)roomID completion:(RemoteCompletionArray)completion
{
    [self _retrieveRoomManagers:roomID completion:completion];
}

- (void)retrieveUserLiveRankRoom:(NSUInteger)roomID Size:(NSUInteger)size UserRankType:(UserRankType)rankType completion:(RemoteCompletionArray)completion
{
    [self _retrieveUserRank:rankType Room:roomID Size:size completion:completion];
}

- (void)recommendationList:(RemoteCompletionArray)completion
{
    [self _recommendationList:completion];
}

#pragma mark - rankList
- (void)retrieveAnchorRank:(AnchorRankMainType)main subType:(RichRankType)sub size:(NSUInteger)size completion:(RemoteCompletionArray)completion
{
    [self _retrieveAnchorRank:main subType:sub size:size completion:completion];
}
//
// This/Last Week Gift
- (void)retrieveGiftRank:(GiftSubRankType)type size:(NSUInteger)size completion:(RemoteCompletionArray)completion
{
    [self _retrieveGiftRank:type size:size completion:completion];
}

- (void)retrieveSpecialGiftRank:(RemoteCompletionArray)completion
{
    [self _retrieveSpecialGiftRank:completion];
}

// Rich List
- (void)retrieveRichRank:(RichRankType)type size:(NSUInteger)size completion:(RemoteCompletionArray)completion
{
    [self _retrieveRichRank:type size:size completion:completion];
}


-(void)loginWhenAppStart
{
    [self _loginWhenAppStart];
}

#pragma mark - live part.
- (void)retrieveShutupTtl:(NSInteger)roomID completion:(RemoteCompletionInteger)completion
{
     [self _retrieveTTL:kRoomShutUpTTL room:roomID completion:completion];
}

@end
