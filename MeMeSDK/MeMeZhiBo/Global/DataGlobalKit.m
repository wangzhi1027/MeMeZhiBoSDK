//
//  DataGlobalKit.m
//  TTShow
//
//  Created by twb on 13-11-15.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import "DataGlobalKit.h"
#import "UIImage+MMGIF.h"
#import "TTShowUser.h"
#import "NSBundle+SDK.h"

#define kVistorRandomCountMax (100)
#define kVistorCountDown      (20)
#define kVistorCountUp        (50)
#define kSecondsPerDay        (24 * 60 * 60)
#define kSecondsPerHour       (60 * 60)

@implementation DataGlobalKit

+ (instancetype)sharedInstance
{
	static id instance;
	
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		instance = [[[self class] alloc] init];
	});
	
	return instance;
}

- (BOOL)isUserlogin
{
    return [TTShowUser archiveDataValid];
}

- (void)logout
{
    [TTShowUser logout];
}


+ (NSArray *)TTShowExpressions
{
    // Custom Expression Symbols String Array.
    NSString *expressionsPath = [[NSBundle mainBundle] pathForResource:@"TTShowExpression" ofType:@"plist"];
    return [NSArray arrayWithContentsOfFile:expressionsPath];
}

+ (NSDictionary *)locations
{
    NSString *locationPath = [[NSBundle mainBundle] pathForResource:@"ProvinceAndCity" ofType:@"plist"];
    return [NSDictionary dictionaryWithContentsOfFile:locationPath];
}

+ (NSArray *)statures
{
    return @[@"消瘦",
             @"结实",
             @"强壮",
             @"魁梧"];
}

+ (NSArray *)staturesWomen
{
    return @[@"苗条",
             @"丰满",
             @"丰腴",
             @"富态"];
}

+ (NSArray *)constellations
{
    return @[@"白羊座",
             @"金牛座",
             @"双子座",
             @"巨蟹座",
             @"狮子座",
             @"处女座",
             @"天秤座",
             @"天蝎座",
             @"射手座",
             @"摩羯座",
             @"水瓶座",
             @"双鱼座"];
}

+ (NSArray *)sexes
{
    return @[@"女", @"男"];
}

// get grade image string
- (NSString *)anchorImageString:(NSInteger)grade
{
    return [[NSString alloc] initWithFormat:@"img_star_level_%ld", (long)grade];
}

- (NSString *)wealthImageString:(NSInteger)grade
{
    return [[NSString alloc] initWithFormat:@"img_user_level_%ld", (long)grade];
}

- (UIImage *)anchorImage:(NSInteger)grade
{
    NSString *imageName = [[NSString alloc] initWithFormat:@"img_star_level_%ld", (long)grade];
    return kImageNamed(imageName);
}

- (UIImage *)wealthImage:(NSInteger)grade
{
    NSString *imageName = [[NSString alloc] initWithFormat:@"img_user_level_%ld.png", (long)grade];
    return kImageNamed(imageName);
}

// Convert Server Time Stamp, Give off Micro Second.
+ (long long int)filterTimeStamp:(NSString *)s
{
    if (s.length > 3) {
        return [[s substringToIndex:s.length - 3] longLongValue];
    }
    return 0;
}

+ (long long int)filterTimeStampWithInteger:(long long int)s
{
    return s / 1000;
}

+ (long long int)shamVistorCount:(long long int)count
{
    if (count < kVistorCountDown)
    {
        return count * 100 + [self fakeRandomCount];
    }
    else if (count >= kVistorCountDown && count < kVistorCountUp)
    {
        return count * 80 + [self fakeRandomCount];
    }
    else
    {
        return count * 68 + [self fakeRandomCount];
    }
}

+ (long long int)shamVistorCountInMainPage:(long long int)count
{
    return count * 68 + [self fakeRandomCount];
}

+ (long long int)fakeRandomCount
{
    NSInteger randNum = arc4random() % kVistorRandomCountMax;
    randNum = randNum < 0 ? (kVistorRandomCountMax + randNum) : randNum;
    return randNum;
}

+ (NSInteger)getRandomNumber:(NSInteger)from to:(NSInteger)to
{
    return (NSInteger)(from + (arc4random() % (to - from + 1)));
}


//+ (BOOL)networkOK
//{
//    return [self checkInternetIsRegular] || [self checkWifiIsRegular];
//}

// User manager status code.

+ (NSArray *)userManageStatus
{
    return @[@{@"code": @(404), @"msg" : @"url 格式不正确.或者资源不存在"},
             @{@"code": @(500), @"msg" : @"url 格式不正确"},
             @{@"code": @(30301), @"msg" : @"认证失败"},
             @{@"code": @(30302), @"msg" : @"用户名或密码不正确"},
             @{@"code": @(30303), @"msg" : @"服务器登录异常"},
             @{@"code": @(30304), @"msg" : @"用户名密码认证超过请求限制"},
             @{@"code": @(30305), @"msg" : @"token失效"},
             @{@"code": @(30306), @"msg" : @"缺少必要的参数"},
             @{@"code": @(30307), @"msg" : @"用户昵称已存在"},
             @{@"code": @(30308), @"msg" : @"用户名已存在"},
             @{@"code": @(30309), @"msg" : @"用户昵称不符合规范"},
             @{@"code": @(30310), @"msg" : @"用户名必须是邮箱"},
             @{@"code": @(30311), @"msg" : @"用户密码不规范"},
             @{@"code": @(30312), @"msg" : @"用户名不存在"},
             @{@"code": @(30313), @"msg" : @"服务器请求第三方资源失败"},
             @{@"code": @(30400), @"msg" : @"内容长度超过14字符"},
             @{@"code": @(30401), @"msg" : @"内容长度超过100字符"},
             @{@"code": @(30402), @"msg" : @"用户名或密码不正确"},
             @{@"code": @(30403), @"msg" : @"服务器登录异常"},
             @{@"code": @(30404), @"msg" : @"用户名密码认证超过请求限制"},
             @{@"code": @(30405), @"msg" : @"token失效"},
             @{@"code": @(30406), @"msg" : @"缺少必要的参数"},
             @{@"code": @(30407), @"msg" : @"用户昵称已存在"},
             @{@"code": @(30408), @"msg" : @"用户名已经存在"},
             @{@"code": @(30409), @"msg" : @"用户昵称不符合规范"},
             @{@"code": @(30410), @"msg" : @"用户名必须是邮箱"},
             @{@"code": @(30411), @"msg" : @"用户密码不规范"},
             @{@"code": @(30412), @"msg" : @"余额不足"},
             @{@"code": @(30413), @"msg" : @"权限不足"},
             @{@"code": @(30414), @"msg" : @"房间为开始直播"},
             @{@"code": @(30415), @"msg" : @"房间已关闭直播"},
             @{@"code": @(30416), @"msg" : @"主播禁止打开"},
             @{@"code": @(30417), @"msg" : @"任务未完成"},
             @{@"code": @(30418), @"msg" : @"用户冻结"},
             @{@"code": @(30419), @"msg" : @"验证码验证失败"},
             @{@"code": @(30420), @"msg" : @"抢沙发失败（已被别人抢占,所加筹码不够）"},
             @{@"code": @(30421), @"msg" : @"恶意访问，ip，设备被禁"},
             @{@"code": @(30422), @"msg" : @"VIP专享特权，请购买VIP"},
             @{@"code": @(30423), @"msg" : @"注册太频繁"},
             @{@"code": @(30424), @"msg" : @"已被抢光，明天早点来"},
             @{@"code": @(30437), @"msg" : @"验证码发送太频繁，请明天再来"},
             @{@"code": @(30432), @"msg" : @"手机号码格式错误"},
             @{@"code": @(30431), @"msg" : @"验证码格式错误"},
             @{@"code": @(30433), @"msg" : @"手机号码已存在"},
             @{@"code": @(30436), @"msg" : @"手机号码不存在"},
             @{@"code": @(30444), @"msg" : @"需要绑定手机"},
             @{@"code": @(30600), @"msg" : @"不能添加自己为好友"},
             @{@"code": @(30601), @"msg" : @"只能加普通用户为好友 "},
             @{@"code": @(30602), @"msg" : @"已经为好友"},
             @{@"code": @(30603), @"msg" : @"不是好友"},
             @{@"code": @(30604), @"msg" : @"好友已超过上限"},
             @{@"code": @(30605), @"msg" : @"消息字数超过上限"},
             @{@"code": @(30606), @"msg" : @"离线消息数目超过上限"},
             @{@"code": @(30607), @"msg" : @"对方已加入你到黑名单"},
             @{@"code": @(30608), @"msg" : @"已加入黑名单"},
             @{@"code": @(30609), @"msg" : @"对方设置不被任何人添加为好友"},
             @{@"code": @(30700), @"msg" : @"小窝已开通"},
             @{@"code": @(30701), @"msg" : @"已经加入小窝"},
             @{@"code": @(30702), @"msg" : @"小窝编辑信息错误"},
             @{@"code": @(30703), @"msg" : @"小窝人数已满"},
             @{@"code": @(30704), @"msg" : @"已提交过小窝申请"},
             @{@"code": @(30790), @"msg" : @"麦上已经有人"},
             @{@"code": @(30791), @"msg" : @"此麦上无人"},
             @{@"code": @(30792), @"msg" : @"被踢下麦，3分钟内无法上麦"}
             ];
}

+ (NSString *)messageWithStatus:(NSInteger)code
{
    NSArray *statusArray = [self userManageStatus];
    for (NSDictionary *statusDict in statusArray)
    {
        NSInteger statusCode = [[statusDict valueForKey:@"code"] integerValue];
        NSString *message = [statusDict valueForKey:@"msg"];
        if (statusCode == code)
        {
            return message;
        }
    }
    return nil;
}

- (BOOL)balanceNotEnoughWithCode:(NSInteger)code
{
    return (code == 30412);
}

- (BOOL)authorityNotEnoughWithCode:(NSInteger)code
{
    return (code == 30413);
}

- (BOOL)needMailAuth:(NSInteger)code
{
    return (code == 30444);
}

- (BOOL)needPhoneAuth:(NSInteger)code
{
    return (code == 30444);
}

- (NSInteger)vipRemainDays:(long long int)expires
{
    NSInteger days = [[DataGlobalKit sharedInstance] daysBetweenNowAndDate:[NSDate dateWithTimeIntervalSince1970:[DataGlobalKit filterTimeStampWithInteger:expires]]];
    return days + 1;
}

- (NSInteger)daysBetweenNowAndDate:(NSDate *)date
{
    if (date == nil)
    {
        return 0;
    }
    NSDate *nowDate = [NSDate date];
    NSTimeInterval timeDiff = [date timeIntervalSinceDate:nowDate];
    return (timeDiff / kSecondsPerDay);
}

- (NSInteger)remainHoursBetweenNowAndDate:(NSDate *)date
{
    if (date == nil)
    {
        return 0;
    }
    NSDate *nowDate = [NSDate date];
    NSTimeInterval timeDiff = [date timeIntervalSinceDate:nowDate];
    NSLog(@"%lld....", (long long int)timeDiff % kSecondsPerDay);
    return (((long long int)timeDiff % kSecondsPerDay) / kSecondsPerHour);
}

- (NSDateComponents *)componentsBetweenNowAndDate:(NSDate *)date
{
    return [self componentsBetweenNowAndDate:date flags:0];
}

- (NSDateComponents *)componentsBetweenNowAndDate:(NSDate *)date flags:(unsigned int)flags
{
#if 0
    NSDate *now = [GlobalStatics SERVER_DATETIME];
    if (now == nil)
    {
        now = [NSDate date];
    }
#else
    NSDate *now = [NSDate date];
#endif
    NSDate *nowWith8 = [[GlobalStatics DATETIME_FMT] dateFromString:[now dateTimeString]];
    
    // Difference.
    if (flags == 0)
    {
        flags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    }
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    cal.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    
    NSDateComponents *components = [cal components:flags fromDate:nowWith8 toDate:date options:0];
    
    return components;
}

- (NSString *)vipImageString:(MemberType)type
{
    switch (type)
    {
        case kTrialVip:
            return @"vip_trial.png";
        case kVIPNone:
//            return @"vip_no.png";
            return @"";
            break;
        case kVIPNormal:
            return @"vip.png";
            break;
        case kVIPSuper:
            return @"vip_extreme1.png";
            break;
        default:
            break;
    }
    // forbidden crash.
    return @"";
}

- (CGFloat)getLabelLength:(NSString *)text fontSize:(CGFloat)fontSize
{
    CGSize size = [text sizeWithFont:kFontOfSize(fontSize) constrainedToSize:CGSizeMake(MAXFLOAT, 21.0f)];
    return size.width;
}

- (CGFloat)getLabelHeight:(NSString *)text width:(CGFloat)width fontSize:(CGFloat)fontSize
{
    CGSize size = [text sizeWithFont:kFontOfSize(fontSize) constrainedToSize:CGSizeMake(width, MAXFLOAT)];
    return size.height;
}

@end
