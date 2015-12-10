//
//  FilterCondition.h
//  memezhibo
//
//  Created by Xingai on 15/5/14.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import <Foundation/Foundation.h>

// for layout more beautiful. the value can be divided by 3.
#define kFCDefaultLimit             (50)
#define kFCDefaultPLimit            (50)
#define kFCDefaultRLimit            (50)
#define kFCDefaultLLimit            (50)
#define kFCDefaultAlbumLimit        (30)
#define kFilterConditionDefaultPage (1)
#define kRoomListTypeDefault        (0)
#define kRoomGiftDefaultSendCount   (1)

@interface FilterCondition : NSObject

// Test Mode
@property (nonatomic, assign) BOOL testModeOn;
@property (nonatomic, assign) BOOL messageBtnHiden;


@property (nonatomic, readonly, strong) NSString *baseUrlStr;
@property (nonatomic, readonly, strong) NSString *baseVideoUrlStr;
@property (nonatomic, readonly, strong) NSString *baseRTMPMediaURL;
@property (nonatomic, readonly, strong) NSString *videoPrivateKey;
@property (nonatomic, readonly, strong) NSString *baseSocketUrlStr;
@property (nonatomic, readonly, assign) NSInteger baseSocketPort;

// UDID
@property (nonatomic, strong) NSString *UDID;

// DeviceToken
@property (nonatomic, assign) BOOL deviceTokenRegistered;

// Task
@property (nonatomic, assign) BOOL firstRegisterLogin;
@property (nonatomic, assign) BOOL firstSendGift;
@property (nonatomic, assign) BOOL firstFavorStar;
@property (nonatomic, assign) BOOL firstEditNick;
@property (nonatomic, assign) BOOL firstCharge;

// Gift
@property (nonatomic, assign) NSInteger lastGiftSendCount;
// Last Login User Name
@property (nonatomic, strong) NSString *lastLoginUserName;


+ (instancetype)sharedInstance;


- (void)clearTaskRecords;


@end
