//
//  TTShowRemote.h
//  memezhibo
//
//  Created by Xingai on 15/5/14.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpClientSyn.h"
#import "HttpUtils.h"
#import "TTShowRoomStar.h"
#import "MMAFAppDotNetAPIClient.h"
#import "MMAFHTTPRequestOperation.h"
#import "TTShowXiaowoInfo.h"
#import "TTShowMessage.h"
#import "TTShowWapPay.h"
#import "TTShowUserNew.h"

@class TTShowDataManager;
@class TTShowUser;

#define kGroupApiHost @"http://wo.2339.com:100"
#define kGroupApiHostTest @"http://test.wo.2339.com:100"
#define kGroupUnReadMessages  [kGroupApiHost stringByAppendingString:@"/api/unread"]
#define kGroupHistoryMessages [kGroupApiHost stringByAppendingString:@"/api/history"]
#define kGroupUnReadMessagesTest  [kGroupApiHostTest stringByAppendingString:@"/api/unread"]
#define kGroupHistoryMessagesTest [kGroupApiHostTest stringByAppendingString:@"/api/history"]

#define kData @"data"
#define kRoomNodeName @"data"
#define kServerTimeStampNodeName @"data"
#define kAuthCodeNodeName @"auth_url"
#define kAuthKeyNodeName @"auth_key"
#define kUserLoginCheckNodeName @"data"
#define kUserLoginNodeName @"data"
#define kUserRegisterCheckNodeName @"data"
#define kUserRegisterNodeName @"data"
#define KRoomStarNodeName @"data"
#define kRoomUserRankNodeName @"data"
#define kUploadUserHeadPicNodeName @"data"
#define kAnchorRankNodeName @"data"
#define kFollowListNodeName @"data"
#define kRichRankNodeName @"data"
#define kGiftRankThisWeekNodeName @"data"
#define kGiftRankLastWeekNodeName @"gift_week"
// Gift
#define kGiftCollectionNodeName @"data"
#define kGiftCategoryNodeName @"categories"
#define kGiftsNodeName @"gifts"
// Special Gift Rank
#define kSpecialGiftNodeName @"data"
// Task
#define kTaskListNodeName @"data"
#define kTaskCompleteNodeName @"complete_mission"
#define kTaskAllMissionNodeName @"all_mission"
// Visitor Count
#define kVisitorCountNodeName @"data"
// Admin List
#define kAdminNodeName @"data"
#define kAdminListNodeName @"list"

typedef NS_ENUM(NSInteger, RemoteType)
{
    retrieve_room_list_index,                     // 获取主播列表
    retrieve_poster_index,                        // 海报
    retrieve_timestamp_index,                     // 服务器时间戳
    retrieve_video_url_index,                     // 获取视频地址
    retrieve_user_information_index,              // 获取用户信息
    retrieve_user_badge_index,                    // 获取用户徽章
    retrieve_user_badge_detail_index,             // 获取用户徽章详细信息
    retrieve_user_charge_record_index,            // 充值记录
    retrieve_user_lucky_record_index,             // 中奖记录
    retrieve_user_cost_record_index,              // 消费记录
    retrieve_user_gift_receive_record_index,      // 收礼记录
    retrieve_gift_list_index,                     // 礼物列表
    send_gift_index,                              // 发送礼物
    send_bag_gift_index,                          // 送背包礼物
    send_fortune_index,                           // 送财神礼物
    retrieve_room_star_index,                     // 获取主播信息
    retrieve_room_user_rank_index,                // 消费排名
    upload_user_head_portrait,                    // 上传用户头像
    upload_user_information,                      // 上传编辑后的用户信息
    retrieve_star_rank_index,                     // 明星榜
    retrieve_song_rank_index,                     // 点播榜
    retrieve_feather_rank_index,                  // 魅力榜
    add_following_index,                          // 添加关注
    del_following_index,                          // 取消关注
    following_list_index,                         // 我关注的主播
    manage_star_list_index,                       // 我管理的主播
    user_bag_index,                               // 背包
    retrieve_rich_rank_index,                     // 财富排行
    retrieve_gift_this_week_rank_index,           // 本周礼物周星
    retrieve_gift_last_week_rank_index,           // 上周礼物周星
    retrieve_gift_special_history_index,          // 历史奇迹礼物
    retrieve_task_list_index,                     // 任务列表
    retrieve_authcode_index,                      // 获取验证码
    retrieve_mission_coin_index,                  // 领取任务金币
    retrieve_visiter_count_index,                 // 在线人数
    retrieve_room_admin_list_index,               // 房间管理员列表
    retrieve_shutup_ttl_list_index,               // 禁止发言列表
    retrieve_kick_ttl_list_index,                 // 踢出房间列表
    collect_feather_index,                        // 积攒么么 客户端每十分钟请求一次即可
    send_feather_index,                           // 送么么
    retrieve_car_list_index,                      // 座驾列表
    exchange_bean_index,                          // 维C兑换柠檬
    exchange_bean_history_index,                  // 兑换柠檬历史记录
    buy_car_index,                                // 买座驾
    buy_vip_index,                                // 买VIP
    buy_extreme_vip_index,                        // 买至尊VIP
    renew_vip_index,                              // 续费VIP
    renew_vip_extreme_index,                      // 续费至尊VIP
    retrieve_mycar_list_index,                    // 我的座驾信息
    set_my_default_car_index,                     // 设置默认座驾
    cancel_my_default_car_index,                  // 取消默认座驾
    delete_my_car_index,                          // 删除座驾
    retrieve_audience_list_index,                 // 观众列表
    retrieve_yesterday_special_gift_index,        // 昨日奇迹
    retrieve_today_special_gift_index,            // 今日奇迹
    send_broadcast_index,                         // 发广播
    day_login_record_index,                       // 每日设备登记
    charge_from_app_store_index,                  // AppStore充值, IAP
    upload_device_token_index,                    // 上传DeviceToken
    vip_hide_show_setting_index,                  // VIP隐身
    send_suggestion_index,                        // 反馈意见
    retrieve_star_photo_number_index,             // 获取主播照片数量
    praise_star_photo_index,                      // 赞主播照片
    retrieve_star_photo_list_index,               // 获取主播照片列表
    retrieve_user_information_by_id_index,        // 根据用户ID获取用户信息
    retrieve_rank_all_index,                      // 排行榜前3名
    retrieve_sofa_list_index,                     // 沙发列表
    grab_sofa_index,                              // 抢沙发
    retrieve_sign_records_index,                  // 签到记录(sign/list/:access_token)
    sign_award_index,                             // 签到奖励 (/sign/award/:access_token/:type?auth_code=*)
    upload_puzzle_archievement_index,             // 完成拼图 (..._win/:access_token/:room_id?step=)
    retrieve_active_rank_index,                   // 活跃榜 (..ank/:roomid?size=%d)
    retrieve_active_value_index,                  // 活跃值...ser/{access_token}/{room_id}
    add_active_value_index,                       // 增加活跃值 ...lue/{access_token}/{room_id}
    
    get_tenpay_wap_url_index,                     // 获取财付通WAP支付地址(wap?_id=userid&amount=金额)
    get_alipay_wap_url_index,                     // 获取支付宝WAP支付地址(wap?_id=userid&amount=金额)
    
    manage_shutup_index,                          // 禁止发言 (...token/:room_id/:xy_user_id?minute=60)
    manage_recover_index,                         // 恢复发言 (...token/:room_id/:xy_user_id)
    manage_kick_index,                            // 踢出房间 (...token/:room_id/:xy_user_id?minute=60)
    
    retrieve_msg_list_index,                      // 通知列表(:access_token?page&size)
    retrieve_msg_unread_count_index,              // 未读通知数量(:access_token)
    retrieve_msg_info_index,                      // 通知明细(:access_token/:_id)
    msg_del_index,                                // 删除通知(:access_token/:_id)
    msg_mark_read_index,                          // 标记通知已读(:access_token/:_id)
    retrieve_remind_list_index,                   // 提醒列表(:access_token)
    retrieve_remind_unread_count_index,           // 未读提醒数量(:access_token)
    remind_mark_read_index,                       // 标记提醒为已读(:access_token/:remind_id)
    remind_del_index,                             // 删除提醒(:access_token/:remind_id)
    remind_set_index,                             // 设置不再提醒(:access_token/:remind_id)
    
    get_yujian_accesstoken_index,                 // 遇见登录 (获取遇见登录AccessToken.)
    send_phonenumber_for_sms,                       // 绑定手机号码
    send_sms_for_verify ,                            // 验证手机号码
    
    //好友
    friend_search,                                  //搜索好友
    friend_request_add,                             //申请加好友
    friend_request_list,                            //好友申请列表
    friend_add_refuse,                              //拒绝好友申请
    friend_del_apply,                                //删除好友申请
    friend_add_agree,                               //接受好友申请
    friend_friend_list,                             //好友列表
    friend_del_one,                                 //删除好友
    friend_is_friend,                               //是否朋友关系
    friend_add_blacklist,                           //加入黑名单
    friend_black_list,                               //黑名单列表
    friend_del_blacklist,                            //移除黑名单列表
    friend_setting_not_add,                           //设置不被任何人添加为好友
    
    
    //小窝
    xiaowo_request_list,                              // 申请列表(status: 0:未处理,1:已通过 2:未通过)
    xiaowo_handle_request,                            //主播审核申请 (1:已通过 2:未通过)
    xiaowo_delete_request,                            //主播删除申请记录
    xiaowo_kick_member,                               //把用户踢出小窝
    
    xiaowo_create,                                  //开通小窝
    xiaowo_edit,                                    //编辑小窝
    xiaowo_join,                                    //加入小窝
    xiaowo_exit,                                    //退出小窝
    xiaowo_mine,                                    //我的小窝
    xiaowo_gift_list,                               //小窝礼物列表
    xiaowo_gift_send,                               //小窝送礼
    
    xiaowo_id_my_list,                              //我加入的小窝ID
    xiaowo_my_list,                                 //我加入的小窝
    xiaowo_shutup,                                  //小窝禁言
    xiaowo_shutup_time,                             //小窝禁言时间
    xiaowo_photo_upload,                            //上传照片
    xiaowo_photo_del,                               //删除照片
    xiaowo_list,                                    //小窝列表
    xiaowo_info,                                    //小窝信息
    xiaowo_pic_url_list,                            //小窝图片列表
    xiaowo_member_list,                             //小窝成员列表
    xiaowo_upload_portrait,                      // 上传小窝头像
    xiaowo_upload_back_image,                      // 上传小窝背景
    upyun_xiaowo_pic_token,                      // 又拍云小窝图片上传token
    upyun_xiaowo_audio_token,                      // 又拍云小窝语音上传token
    
    sensitive_nick_names,                       //昵称敏感词
    sensitive_words,                            //聊天敏感词
    xiaowo_get_chat_history,                       //获取小窝历史记录
    xiaowo_get_chat_unread,                     //获取小窝未读消息

    
    retrieve_data_from_remote_max,
    
    Anchor_recommendation,                       //主播推荐
    
    Family_Open_number,                           //家族主播开通数
    
    phone_Verification_code,                    //手机是否注册
    
    phone_authcode,                              //手机请求验证码
    
    phone_register,                               //手机验证码登录
    
    tuijian_list,                                  //主播推荐list
    
    chaoxing_list,                                  //超星接口
    
    jiazu_list,                                      //家族接口
    
    kanguo_list,                                    //看过list
    
    youxiuXinren_list,                               //优秀新人
    guanjianzi_list,                                 //关键字
    guanjianzi_list1,                                 //关键字List1
    shangmai,                                          //上麦
    xiaowoRenshu,                                       //小窝人数
    xiaowoJiabin,                                        //小窝嘉宾
    xiaowoAddJiabin,                                //小窝设置嘉宾
    XiaowoCanceJiabin,                              //取消嘉宾
    xiaowoFollowingCheck,                           //是否关注小窝
    xiaowoAddFollowing,                             //关注小窝
    xiaowoDelFollowing,                              //取消关注小窝
    xiaowoTimai,                                     //小窝踢麦
    xiaowoFahongbao,                                  //小窝发红包
    xiaowohongbaoList,                                 //小窝红包list
    xiaowoQianghongbao,                                 //小窝抢红包
    hongbaoZhuangtai,                                    //红包状态
    xiaowoShangmaiUrl,                                    //小窝上麦地址
    xiaowoShangmaiLaliuUrl,                                //小窝上麦拉流地址
    xiaowoXiaMai,                                           //小窝下麦
    xiaowoShangMaiXintiao,                                   //小窝上麦后心跳
    xiaowoTiren,                                             //小窝踢人
    xiaowoTirenCheck                                         //小窝被踢时间确认
};

typedef NS_ENUM(NSInteger, TaskSource)
{
    kTaskSourcePC = 1,     // PC
    kTaskSourcePhone,      // 手机
    kTaskSourceAll         // 所有
};

typedef NS_ENUM(NSInteger, UserRankType)
{
    kUserRankLive,   // 本场排名
    kUserRankMonth,  // 月排名
    kUserRankTotal   // 总排名
};

// 主播排名
typedef NS_ENUM(NSInteger, AnchorRankMainType)
{
    kAnchorStarRank,    // 明星榜
    kAnchorFeatherRank, // 魅力榜
    kAnchorSongRank,    // 点播榜
    kAnchorSubRankMax
};

typedef NS_ENUM(NSInteger, AnchorRankSubType)
{
    kAnchorDayRank,   // 日排名
    kAnchorWeekRank,  // 周排名
    kAnchorMonthRank, // 月排名
    kAnchorTotalRank, // 总排名
    kAnchorRankMax
};

// 富豪排行榜
typedef NS_ENUM(NSInteger, RichRankType)
{
    kRichDayRank,   // 日排名
    kRichWeekRank,  // 周排名
    kRichMonthRank, // 月排名
    kRichTotalRank, // 总排名
    kRichRankMax
};

// 礼物排行榜
typedef NS_ENUM(NSInteger, GiftMainRankType)
{
    kGiftWeekRank,   // 礼物周星
    kGiftSpecialRank,  // 奇迹礼物
    kGiftRankMax
};

typedef NS_ENUM(NSInteger, GiftSubRankType)
{
    kGiftThisWeekRank,   // 本周
    kGiftLastWeekRank,  // 上周
    kGiftWeekRankMax
};

typedef NS_ENUM(NSInteger, RoomTTLType)
{
    kRoomShutUpTTL,   // 禁言
    kRoomKickTTL,     // 被踢
    kRoomTTLMax,
};

typedef NS_ENUM(NSInteger, StarPhotoType)
{
    kStarLivePhoto,
    kStarLifePhoto,
    kStarPhotoTypeMax
};

typedef NS_ENUM(NSInteger, SignAwardType)
{
    kSignAwardNone,
    kSignAward3Days,
    kSignAward7Days,
    kSignAward15Days,
    kSignAward28Days,
    kSignAwardMax
};

typedef NS_ENUM(NSInteger, SignAwardTypeValue)
{
    kSignAwardValueNone = 0,
    kSignAwardValue3 = 3,
    kSignAwardValue7 = 7,
    kSignAwardValue15 = 15,
    kSignAwardValue28 = 28,
    kSignAwardValueMax
};

typedef void (^RemoteCompletionString)(NSString *string, NSError *error);
typedef void (^RemoteCompletionDic)(NSDictionary *dic, NSError *error);
typedef void (^RemoteCompletionString2)(NSString *string1,NSString *string2, NSError *error);
typedef void (^RemoteCompletionArray)(NSArray *array, NSError *error);
typedef void (^RemoteCompletionDoubleArray)(NSArray *array1, NSArray *array2, NSError *error);
typedef void (^RemoteCompletionInteger)(NSInteger count, NSError *error);
typedef void (^RemoteCompletionLongLong)(long long int count, NSError *error);
typedef void (^RemoteCompletionArrayInteger)(NSArray *array, NSInteger count, NSError *error);
typedef void (^RemoteCompletionArraylLliInteger)(NSArray *array, NSInteger count, long long int timestamp, NSError *error);
typedef void (^RemoteCompletionArrayIntegerIntegerInteger)(NSArray *array, NSInteger count, NSInteger amount, NSInteger award_coins,NSError *error);
typedef void (^RemoteCompletionBool)(BOOL success, NSError *error);
typedef void (^RemoteCompletionUser)(TTShowUser *user, NSError *error);
typedef void (^RemoteCompletionUserNew)(TTShowUserNew *user, NSError *error);
typedef void (^RemoteCompletionImage)(UIImage *image, NSError *error);
typedef void (^RemoteCompletionData)(NSData *data, NSError *error);
//typedef void (^RemoteCompletionWapPay)(TTShowWapPay *wapPay, NSError *error);
typedef void (^RemoteCompletionMessage)(TTShowMessage *message, NSError *error);
typedef void (^RemoteCompletionWapPay)(TTShowWapPay *wapPay, NSError *error);
//typedef void (^RemoteCompletionMessage)(TTShowMessage *message, NSError *error);

@interface TTShowRemote : NSObject

{
    NSArray *urlArray;
}

@property(nonatomic, readonly, strong) NSString *baseURLStr;
@property(nonatomic, readonly, strong) NSString *userURLStr;
@property(nonatomic, strong) TTShowDataManager *dataManager;

+ (instancetype)sharedInstance;

- (NSDictionary *)parseJson:(id)responseObject;

// Collect iOS Client Logs.
- (void)collectLog;

// Login record everyday.
- (void)dayLoginWith:(NSString *)deviceUID;


- (void)registerDeviceToken:(NSString *)deviceToken;

// Third Login
- (void)loginFromThirdParty:(NSString *)urlString completion:(RemoteCompletionUser)completion;
// 3rd SDK login
- (void)loginFrom3rdPartySDK:(NSDictionary *)param completion:(RemoteCompletionUser)completion;

- (void)updateUserInformationWithCompletion:(RemoteCompletionUser)completion;

// add/del follow.
//- (void)followingForStar:(NSUInteger)star_id add:(BOOL)isAdd completion:(RemoteCompletionBool)completion;

-(void)retrieveTheHallimage:(RemoteCompletionArray)completion;


//- (void)followingForStar:(NSUInteger)star_id add:(BOOL)isAdd completion:(RemoteCompletionBool)completion;


// my follow.
- (void)followingListWithCompletion:(RemoteCompletionArray)completion;

- (void)followingForStar:(NSUInteger)star_id add:(BOOL)isAdd completion:(RemoteCompletionBool)completion;

- (void)userLogin:(NSString *)userName password:(NSString *)password key:(NSString*)key completion:(RemoteCompletionUser)completion;

- (void)retrieveKickTtl:(NSInteger)roomID completion:(RemoteCompletionInteger)completion;

- (void)retrieveRoomListWithParams:(NSDictionary *)params completion:(RemoteCompletionArray)completion;

//system
- (void)requestSensitiveNickNames:(SuccessBlock)successBlock failBlock:(FailBlock)failBlock;
- (void)requestSensitiveWords:(SuccessBlock)successBlock failBlock:(FailBlock)failBlock;

// upload user information

- (void)retrieveUserInfo:(NSInteger)userID completion:(RemoteCompletionUser)completion;


// RoomVideo
- (void)retrieveRoomStar:(NSUInteger)roomID WithBlock:(void (^)(TTShowRoomStar *roomStar, NSError *error))block;
- (void)retrieveRoomManagers:(NSUInteger)roomID completion:(RemoteCompletionArray)completion;
- (void)retrieveUserLiveRankRoom:(NSUInteger)roomID Size:(NSUInteger)size completion:(RemoteCompletionArray)completion;

//car
//- (void)retrieveCarList:(RemoteCompletionArray)completion;
//manager
- (void)manageStarListWithCompletion:(RemoteCompletionArray)completion;

//Anchor recommendation
- (void)recommendationList:(RemoteCompletionArray)completion;

//rankList
- (void)retrieveAnchorRank:(AnchorRankMainType)main subType:(RichRankType)sub size:(NSUInteger)size completion:(RemoteCompletionArray)completion;

- (void)retrieveGiftRank:(GiftSubRankType)type size:(NSUInteger)size completion:(RemoteCompletionArray)completion;

- (void)retrieveSpecialGiftRank:(RemoteCompletionArray)completion;

- (void)retrieveRichRank:(RichRankType)type size:(NSUInteger)size completion:(RemoteCompletionArray)completion;


- (void)retrieveUserLiveRankRoom:(NSUInteger)roomID Size:(NSUInteger)size UserRankType:(UserRankType)rankType completion:(RemoteCompletionArray)completion;


//xiaowo
- (void)retrievePublic:(NSInteger)page Size:(NSUInteger)size completion:(RemoteCompletionArray)completion;

-(void)loginWhenAppStart;

- (void)retrieveMyJoined:(NSInteger)page Size:(NSUInteger)size completion:(RemoteCompletionArray)completion;

- (void)joinXiaowo:(NSInteger)xiaowoID completion:(RemoteCompletionBool)completion;

- (void)retrieveMyXiaowoInfo:(void (^)(TTShowXiaowoInfo *xiaowo, NSError *error))block;

-(void)retrieveXiaowoPublic:(NSInteger)page Size:(NSUInteger)size completianString:(RemoteCompletionString)completion;


//Family
-(void)retrieveFamilyPublic:(NSInteger)page Size:(NSUInteger)size completianString:(RemoteCompletionString)completion;

//friend
- (void)retrieveFriendList:(RemoteCompletionArray)completion;

//live
- (void)retrieveShutupTtl:(NSInteger)roomID completion:(RemoteCompletionInteger)completion;

@end
