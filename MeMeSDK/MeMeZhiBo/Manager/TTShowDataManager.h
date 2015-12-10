//
//  TTShowDataManager.h
//  memezhibo
//
//  Created by Xingai on 15/5/14.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FilterCondition.h"
#import "TTShowRemote+Favor.h"
#import "TTShowRemote.h"
#import "TTAlixpay.h"
#import "TTShowDatabase.h"
#import "TTShowUser.h"
#import "CommonDataAccess.h"
#import "TTShowDefaults.h"
#import "HttpClientSyn.h"

#import "IMSocket.h"
#import "GroupSocket.h"

@interface TTShowDataManager : NSObject

@property (nonatomic, readonly) IMSocket *imSocket;
@property (nonatomic, readonly) GroupSocket *groupSocket;
@property (nonatomic, readonly) FilterCondition *filter;
@property (nonatomic, readonly) TTShowRemote *remote;
@property (nonatomic, readonly) TTShowDatabase *db;
@property (nonatomic, readonly) TTShowUser *me;
@property (nonatomic, readonly) CommonDataAccess *commonDA;
@property (nonatomic, readonly) TTShowDefaults *defaults;
@property (nonatomic, readonly) DataGlobalKit *global;
@property (nonatomic, readonly) HttpClientSyn *synRemote;
@property (nonatomic, readonly) TTAlixpay *alixpay;

@property (nonatomic, strong) NSMutableArray *friendList;
@property (nonatomic, strong) NSMutableArray *myGroupList;
@property (nonatomic, strong) NSMutableArray *myGroupIDList;
@property (nonatomic, assign) NSInteger currentChatFriendID;
@property (nonatomic, assign) NSInteger currentChatGroupID;
@property (nonatomic, strong) NSString *currentChatGroupName;
@property (nonatomic, strong) NSMutableDictionary *groupSwitch;


- (void)retrieveFavorStar;

- (void)updateUser;

- (NSInteger)anchorLevel:(long long int)bean_count_total;
- (NSInteger)anchorUpgradeNeedBeanCount:(long long int)bean_count_total;
- (NSInteger)anchorCurrentBeanCount:(long long int)bean_count_total;
- (NSInteger)wealthLevel:(long long int)coin_spend_total;

@end
