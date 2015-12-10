//
//  CommonParameter.m
//  TTShow
//
//  Created by twb on 13-9-22.
//  Copyright (c) 2013年 twb. All rights reserved.
//

#import "CommonParameter.h"
#import <sys/sysctl.h>
#import <sys/socket.h>
#import <net/if.h>
#import <net/if_dl.h>

typedef NS_ENUM(NSInteger, TTNetworkType)
{
    kNetworkNone = -1,
    kNetwork2G,
    kNetworkWap,
    kNetworkWifi,
    kNetwork3G,
    kNetworkMax
};

#define kCollectionLogVersion (@"1.0")
#define kCollectionAppName    (@"beauty")

@implementation CommonParameter

+ (instancetype)sharedInstance
{
	static id instance;
	
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		instance = [[[self class] alloc] init];
	});
	
	return instance;
}

- (NSString *)uid
{
    // Apple forbide retrieving UDID from 2013.5.1 on.
    return @"";
}

- (NSString *)app
{
    return kCollectionAppName;
}

- (NSString *)hid
{
    return [self macAddress];
}

//- (NSString *)openid
//{
//    return [OpenUDID value];
//}

- (NSString *)v
{
    return kCollectionLogVersion;
}

- (NSString *)f
{
    return @"f0";
}

- (NSString *)s
{
    return @"s310";
}

- (NSString *)imsi
{
    return @"";
}

//- (NSInteger)net
//{
//    Reachability *reachability = [Reachability reachabilityForInternetConnection];
//    [reachability startNotifier];
//    NetworkStatus status = reachability.currentReachabilityStatus;
//    switch (status)
//    {
//        case NotReachable:
//            return kNetworkNone;
//            break;
//        case ReachableViaWiFi:
//            return kNetworkWifi;
//            break;
//        case ReachableViaWWAN:
//            return kNetwork3G;
//            break;
//        default:
//            break;
//    }
//    return kNetwork2G;
//}

- (NSString *)mid
{
    NSString *platform = [self devicePlatform];
    if ([platform isEqualToString:@"iPhone1,1"])
    {
        return @"iPhone";
    }
    if ([platform isEqualToString:@"iPhone1,2"])
    {
        return @"iPhone3G";
    }
    if ([platform isEqualToString:@"iPhone2,1"])
    {
        return @"iPhone3GS";
    }
    if ([platform isEqualToString:@"iPhone3,1"])
    {
        return @"iPhone4";
    }
    if ([platform isEqualToString:@"iPhone3,2"])
    {
        return @"iPhone4";
    }
    if ([platform isEqualToString:@"iPhone3,3"])    // @"Verizon iPhone 4"
    {
        return @"iPhone4";
    }
    if ([platform isEqualToString:@"iPhone4,1"])
    {
        return @"iPhone4S";
    }
    if ([platform isEqualToString:@"iPhone5,1"])  //iPhone 5(AT&T)
    {
        return @"iPhone5";
    }
    if ([platform isEqualToString:@"iPhone5,2"]) //iPhone 5(GSM/CDMA)
    {
        return @"iPhone5";
    }
    if ([platform isEqualToString:@"iPod1,1"])
    {
        return @"iTouch";
    }
    if ([platform isEqualToString:@"iPod2,1"])
    {
        return @"iTouch2";
    }
    if ([platform isEqualToString:@"iPod3,1"])
    {
        return @"iTouch3";
    }
    if ([platform isEqualToString:@"iPod4,1"])
    {
        return @"iTouch4";
    }
    if ([platform isEqualToString:@"iPod5,1"])
    {
        return @"iTouch5";
    }
    if ([platform isEqualToString:@"iPad1,1"])
    {
        return @"iPad";
    }
    if ([platform isEqualToString:@"iPad2,1"])
    {
        return @"iPad2";	//WiFi
    }
    if ([platform isEqualToString:@"iPad2,5"])
    {
        return @"iPad Mini (WiFi)";
    }
    if ([platform isEqualToString:@"iPad2,6"])
    {
        return @"iPad Mini (GSM)";
    }
    if ([platform isEqualToString:@"iPad2,7"])
    {
        return @"iPad Mini (CDMA)";
    }
    if ([platform isEqualToString:@"iPad3,1"])
    {
        return @"iPad 3 (WiFi)";
    }
    if ([platform isEqualToString:@"iPad3,2"])
    {
        return @"iPad 3 (GSM)";
    }
    if ([platform isEqualToString:@"iPad3,3"])
    {
        return @"iPad 3 (CDMA)";
    }
    if ([platform isEqualToString:@"iPad3,4"])
    {
        return @"iPad 4 (WiFi)";
    }
    if ([platform isEqualToString:@"iPad3,5"])
    {
        return @"iPad 4 (GSM)";
    }
    if ([platform isEqualToString:@"iPad3,6"])
    {
        return @"iPad 4 (CDMA)";
    }
    
    if ([platform isEqualToString:@"i386"] || [platform isEqualToString:@"x86_64"])
    {
        return @"iPhone Simulator";
//        return @"iPhone Simulator iPhone Simulator iPhone Simulator iPhone Simulator iPhone Simulator iPhone Simulator iPhone Simulator iPhone Simulator iPhone Simulator iPhone Simulator iPhone Simulator iPhone Simulator iPhone Simulator iPhone Simulator iPhone Simulator iPhone Simulator iPhone Simulator iPhone Simulator iPhone Simulator ";
    }
    
    return platform;
}

- (NSString *)splus
{
    return [[UIDevice currentDevice] systemVersion];
}

- (NSInteger)active
{
    return 1;
}

- (NSInteger)tid
{
    return 0;
}

#pragma mark - Operation Type.

- (NSDictionary *)openDictionary
{
    NSString *now = [[GlobalStatics DATETIME_LOG_FMT] stringFromDate:[NSDate date]];
    NSDictionary *open = [NSDictionary dictionaryWithObjectsAndKeys:
                          kCollectionLogVersion, @"v",
                          now, @"time",
                          @"startup", @"module",
                          @"1", @"value",
                          @"startup", @"origin",
                          @"startup", @"type",
                          nil];
    return open;
}

#pragma mark - Device Information.

- (NSString*)devicePlatform
{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = (char *)malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    free(machine);
    return platform;
}

#pragma mark - Get Mac Address

- (NSString *)macAddress
{
    int                     mib[6];
    size_t                  len;
    char                    *buf;
    unsigned char           *ptr = NULL;
    struct if_msghdr        *ifm;
    struct sockaddr_dl      *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error\n");
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1\n");
    }
    
    if ((buf = (char*)malloc(len)) == NULL) {
        printf("Could not allocate memory. error!\n");
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    if (sdl != nil)
    {
        ptr = (unsigned char *)LLADDR(sdl);
    }
    
    //    NSString *outstring1 = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    //    NSLogDebug(@"OUT1 : %@", outstring1);
    
    // 这里进行一个简单的加密, 取反
    unsigned char data[6] = {'0'};
    for (int n = 0; n < 6; n++) {
        data[n] = *(ptr + n);
        data[n] = ~data[n]; // 值取反
    }
    
    NSString *outstring = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x", data[0], data[1], data[2], data[3], data[4], data[5]];
    free(buf);
    
    return [outstring uppercaseString];
}

@end
