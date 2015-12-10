//
//  RoomVideoViewController+Remote.m
//  memezhibo
//
//  Created by Xingai on 15/5/20.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "RoomVideoViewController+Remote.h"
#import "TTShowRemote+Live.h"
#import "RoomVideoViewController+ChatField.h"
#import "TTShowRemote+Live.h"
#import "TTShowCar.h"
#import "TTShowRemote+Car.h"

#define kRoomLiveSpentMostCount (5)
#define kRoomLiveAudiencesMax   (100)

@implementation RoomVideoViewController (Remote)

- (void)retrieveLiveSpentMost
{
    __weak __typeof(self) weakSelf = self;
    [self.dataManager.remote retrieveUserLiveRankRoom:self.currentRoom._id Size:kRoomLiveSpentMostCount UserRankType:0  completion:^(NSArray *array, NSError *error) {
        if (array != nil && error == nil)
        {
            if (weakSelf.liveSpentMost == nil)
            {
                NSMutableArray *spentMost = [[NSMutableArray alloc] init];
                weakSelf.liveSpentMost = spentMost;
            }
            else
            {
                [weakSelf.liveSpentMost removeAllObjects];
            }
            [weakSelf.liveSpentMost addObjectsFromArray:array];
        }
    }];
}


- (void)retrieveRoomStar
{
    __weak __typeof(self) weakSelf = self;
    [self.dataManager.remote retrieveRoomStar:self.currentRoom._id WithBlock:^(TTShowRoomStar *roomStar, NSError *error) {
        
        // Retrieve Room Chat Star Information.
        weakSelf.currentRoomStar = roomStar;
        if (!self.currentRoomStar.isLive) {
//            self.loadingViewTo.messageLabel.text = roomStar.message;
            NSString *str = [roomStar.message  stringByUnescapingFromHTML];
            self.loadingViewTo.messageLabel.text = str;
        }
                
        // Ready for Sending Gifts
        TTShowChatTarget *roomStarTarget = [[TTShowChatTarget alloc] init];
        [roomStarTarget setValue:@(weakSelf.currentRoomStar._id) forKey:kChatTargetIDKey];
        [roomStarTarget setValue:weakSelf.currentRoomStar.nick_name forKey:kChatTargetNickNameKey];
        
        if (weakSelf.chatTargets == nil)
        {
            // First One is Room Star.
            NSMutableArray *chatTargetList = [[NSMutableArray alloc] initWithObjects:roomStarTarget, nil];
            weakSelf.chatTargets = chatTargetList;
        }
        
        // Record recently watch list.
        [weakSelf recordRecentlyWatchStarList];
        
        // update feather count.
        [weakSelf updateFeatherCountUI:weakSelf.currentRoomStar.feather_receive_total];
        
        // update anchor upgrade bean count.
        NSInteger needBean = [self upgradeNeedBeanCount:weakSelf.currentRoomStar.bean_count_total];
        [weakSelf updateStarUpgradeNeedBeanCount:needBean];
        
        // float star UI.
        [weakSelf updateFloatTitleView];
    }];
}

- (void)recordRecentlyWatchStarList
{
    TTShowFollowRoomStar *star = [[TTShowFollowRoomStar alloc] init];
    star.roomID = self.currentRoom._id;
    star.live = self.currentRoom.live;
    star.starID = self.currentRoomStar._id;
    star.bean_count_total = self.currentRoomStar.bean_count_total;
    star.nick_name = self.currentRoomStar.nick_name;
    star.pic = self.currentRoomStar.pic;
    
    if ([self.dataManager.commonDA existRecentWatchWithStar:star.starID])
    {
        [self.dataManager.commonDA delRecentWatchWithStar:star.starID];
    }
    [self.dataManager.commonDA addRecentlyWatchListWithStar:star];
    //    [self.dataManager.defaults addRecentlyWatch:star];
    
    // Notify update.
    [kNotificationCenter postNotificationName:kNotificationUpdateRecentWatchList object:nil];
}

- (void)retrieveRoomManagerList
{
    __weak __typeof(self) weakSelf = self;
    [self.dataManager.remote retrieveRoomManagers:self.currentRoom._id completion:^(NSArray *array, NSError *error) {
        if (array != nil && error == nil)
        {
            if (weakSelf.adminList == nil)
            {
                NSMutableArray *al = [[NSMutableArray alloc] init];
                weakSelf.adminList = al;
            }
            else
            {
                [weakSelf.adminList removeAllObjects];
            }
            
            [weakSelf.adminList addObjectsFromArray:array];
        }
        else
        {
        }
    }];
}

- (void)retrieveCarList
{
    __weak __typeof(self) weakSelf = self;
    [self.dataManager.remote retrieveCarList:^(NSArray *array1, NSArray *array2, NSError *error) {
        if (array1 && !error)
        {
            if (!weakSelf.carList)
            {
                NSMutableArray *allCar = [[NSMutableArray alloc] init];
                weakSelf.carList = allCar;
            }
            else
            {
                [weakSelf.carList removeAllObjects];
            }
            
            [weakSelf.carList addObjectsFromArray:array1];
        }
        
    }];
}

- (void)retrieveUserInfo
{
    __weak __typeof(self) weakSelf = self;
    [self.dataManager.remote updateUserInformationWithCompletion:^(TTShowUser *user, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            // update user in data manager.
            [self.dataManager updateUser];
            
            // update your feather count.
            if (user != nil)
            {
                Finance *finance = [[Finance alloc] initWithAttributes:user.finance];
                [weakSelf.dataManager.defaults setFeatherCount:finance.feather_count];
                self.giftController.balanceLabel.text = [NSString stringWithFormat:@"%lli", finance.coin_count];
                
                NSDictionary *attributeDic1 = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:14]};
                
                CGRect rect1 = [self.giftController.balanceLabel.text boundingRectWithSize:CGSizeMake(200, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine attributes:attributeDic1 context:nil];
                float width = rect1.size.width+5;
                
                if (width>56) {
                    self.giftController.width.constant = width;
                    [self.giftController.view needsUpdateConstraints];
                }
                [[UIGlobalKit sharedInstance] setImageAnimationLoading:self.keyboard.headImage WithSource:self.me.pic];
            }
            else
            {
                [weakSelf.dataManager.defaults setFeatherCount:0];
            }
        });
    }];
}


- (void)retrieveAudienceList
{
    // if you don't enter room in the first time and don't stay in the audience list ui.
    if (!self.isAudienceFirstLoading)
    {
        if (self.giftrankingTable.hidden && self.liveAudiences)
        {
            //            LOGINFO(@"audience controller is hidden. Don't update audience list.");
            return;
        }
    }
    
    __weak __typeof(self) weakSelf = self;
    [self.dataManager.remote retrieveAudienceList:self.currentRoom._id page:0 size:kRoomLiveAudiencesMax completion:^(NSArray *array, NSInteger count, NSError *error) {
        if (array.count != 0 && !error)
        {
            // Filter.
            NSMutableArray *resultAudiences = [[NSMutableArray alloc] init];
            
            @autoreleasepool {
                for (TTShowAudience *audience in array)
                {
                    if ([weakSelf roomOneIsAdmin:audience._id])
                    {
                        audience.manager = YES;
                    }
                    
                    if ([weakSelf oneSpentMost:audience._id])
                    {
                        audience.spentMost = YES;
                    }
                    
                    Finance *finance = [[Finance alloc] initWithAttributes:audience.finance];
                    audience.wealthLevel = [weakSelf.dataManager wealthLevel:finance.coin_spend_total];
                    [resultAudiences addObject:audience];
                }
            }
            
            if (!weakSelf.liveAudiences)
            {
                NSMutableArray *la = [[NSMutableArray alloc] init];
                weakSelf.liveAudiences = la;
            }
            else
            {
                [weakSelf.liveAudiences removeAllObjects];
            }
            
//            NSSortDescriptor *sortByOrder = [NSSortDescriptor sortDescriptorWithKey:@"coin_spend" ascending:NO];
//            NSArray *resultArray = [resultAudiences sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortByOrder]];
            
            [weakSelf.liveAudiences addObjectsFromArray:resultAudiences];
            
            // just loading once.
            static dispatch_once_t onceToken;
            dispatch_once(&onceToken, ^{
                self.giftRankingList = weakSelf.liveAudiences;
                [self.giftrankingTable reloadData];
            });
            
            // update audience List
            if (!weakSelf.giftrankingTable.hidden)
            {
                self.giftRankingList = weakSelf.liveAudiences;
                [self.giftrankingTable reloadData];
            }
            
            //
            [weakSelf updateAudienceCountUI:count];
            
            self.isAudienceFirstLoading = NO; 
            
        }
    }];
}

- (void)retrieveFavorStatus
{
    NSInteger starid = self.currentRoomStar._id;
    if (starid == 0)
    {
        starid = self.currentRoom._id;
    }
    self.isFollowStar = [self.dataManager.defaults hasFollowStar:starid];
}

- (void)retrieveGuanjianzi
{
    __weak __typeof(self) weakSelf = self;
    [self.dataManager.remote remoteGuanjianziCompletion:^(NSArray *cars, NSError *error) {
        
        if (cars && !error)
        {
            if (!weakSelf.guanjianziList)
            {
                NSMutableArray *allCar = [[NSMutableArray alloc] init];
                weakSelf.guanjianziList = allCar;
            }
            else
            {
                [weakSelf.guanjianziList removeAllObjects];
            }
            
            [weakSelf.guanjianziList addObjectsFromArray:cars];
            
        }
    }];
}

- (void)retrieveGuanjianzi1
{
    __weak __typeof(self) weakSelf = self;
    [self.dataManager.remote remoteGuanjianziToCompletion:^(NSArray *cars, NSError *error) {
        
        if (cars && !error)
        {
            if (!weakSelf.guanjianziList1)
            {
                NSMutableArray *allCar = [[NSMutableArray alloc] init];
                weakSelf.guanjianziList1 = allCar;
            }
            else
            {
                [weakSelf.guanjianziList1 removeAllObjects];
            }
            
            [weakSelf.guanjianziList1 addObjectsFromArray:cars];
        }
    }];
}

@end
