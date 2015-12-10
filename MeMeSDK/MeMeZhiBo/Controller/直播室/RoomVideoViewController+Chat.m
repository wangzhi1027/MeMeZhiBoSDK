//
//  RoomVideoViewController+Chat.m
//  memezhibo
//
//  Created by Xingai on 15/6/9.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "RoomVideoViewController+Chat.h"
#import "RoomVideoViewController+ChatField.h"
#import "RoomVideoViewController+Remote.h"
#import "RoomVideoViewController+Socket.h"

#define kChatHistoryCacheCountMax      (30)
#define kChatWealthLevelShowMin        (8)
#define kChatFullScreenGifMax          (200)
#define kChatRoomChangedCommoner       (0)
#define kChatContentAutoScrollDuration (3.0f)
#define kChatRoomSingleLineSendFontSize        (18.0f)

#define kChatRoomLiveEvent            @"room.live"
#define kChatRoomSomeoneEnterAction   @"room.change"       // 进入房间推送
#define kChatRoomStarAction           @"room.star"         // 房间主播推送
#define kChatRoomAdminListAction      @"room.admin_list"   // 房间管理推送
#define kChatRoomKickAction           @"manage.kick"       // 踢出房间推送
#define kChatRoomShutupAction         @"manage.shutup"     // 禁止发言推送
#define kChatRoomBroadcastAction      @"message.broadcast" // 发布广播推送
#define kChatRoomUserInfoAction       @"user.info"         // 用户信息推送
#define kChatRoomLiveRankAction       @"live.rank"         // 本场直播消费排名推送
#define kChatRoomGiftNotifyAction     @"gift.notify"       // 送礼物推送
#define kChatRoomGiftFeatherAction    @"gift.feather"      // 么么推送
#define kChatRoomSystemNotice         @"sys.notice"        // 系统公告
#define kChatRoomGiftMarquee          @"gift.marquee"      // 横向滚动的礼物
#define kChatRoomLiveStatusAction     @"room.live"         // 直播状态
#define kChatRoomSofaListAction       @"sofa.list"         // 沙发列表
#define kChatRoomPuzzleBeginAction    @"live.puzzle_begin" // 拼图开始
#define kChatRoomPuzzleWinAction      @"live.puzzle_win"   // 拼图获胜

@implementation RoomVideoViewController (Chat)

- (void)handleReceivedMessage:(id)data
{
    [self abondonLoadingText];
    
    [self receiveMessage:data];
    
    [self updateChatHistoryUI];
}

- (void)updateChatHistoryUI
{
    __weak __typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        @autoreleasepool
        {
            if (self.isMymessage) {
                [weakSelf.MyMessageTable reloadData];
            }else{
                [weakSelf.messageTable reloadData];
            }
            
            
            if (self.isMymessage) {
                self.chatHistoryArray = self.chatHistroyPrivateArray;
            }
            else
            {
                self.chatHistoryArray = self.chatHistoryPublicArray;
            }
            [weakSelf chatHistoryScrollToBottom];
        }
    });
}

#pragma mark - Data Refresh Part.

- (void)chatHistoryScrollToBottom
{

    
    if ([self.chatHistoryArray count] == 0)
    {
        return;
    }
    
    NSIndexPath *bottomIndexPath = [NSIndexPath indexPathForRow:[self.chatHistoryArray count] - 1 inSection:0];
    if (bottomIndexPath == nil)
    {
        return;
    }
    
    [self.isMymessage? self.MyMessageTable:self.messageTable scrollToRowAtIndexPath:bottomIndexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

- (void)abondonLoadingText
{
    [UIView animateWithDuration:0.25f animations:^{

    } completion:^(BOOL finished) {

    }];
}

- (void)receiveMessage:(id)data
{
    if (![data isKindOfClass:[NSString class]])
    {
        return;
    }
    
    NSDictionary *jsonData = [data JSONValue];
    if (![jsonData isKindOfClass:[NSDictionary class]])
    {
        return;
    }
    
//    LOGINFO(@"receiveMessage Live Message = %@", jsonData);
    
    if ((self.chatHistoryPublicArray == nil && self.chatHistoryPublicArray.count == 0)&&(self.chatHistroyPrivateArray == nil && self.chatHistroyPrivateArray.count == 0))
    {
        // init data container.
        
        NSMutableArray *publicArray = [[NSMutableArray alloc] init];
        NSMutableArray *privateArray = [[NSMutableArray alloc] init];
        self.chatHistoryPublicArray = publicArray;
        self.chatHistroyPrivateArray = privateArray;
        
        // Default Public Message.
        [self roomChatDefaultPublicAnnounce];
        
        // Default Private Message.
        [self roomChatDefaultPrivateHistory];
        
        // Defaut Public Chat.
        self.chatHistoryArray = self.chatHistoryPublicArray;
    }
    else
    {
        [self cutDownChatHistory];
    }

    // Parse Nofity Mode.
    NSString *actionName = [self action:jsonData];
    ChatRoomNotifyMode notifyMode;

    if ([actionName isEqualToString:kChatRoomLiveEvent]) {
        

        self.playerContainer = nil;
        self.loadingView = nil;
        
        [self setupLoadingTo];
        [self retrieveRoomStar];
    }
    
    
    if ([actionName isEqualToString:kChatRoomSomeoneEnterAction])
    {
        NSString *myNickName = self.me.nick_name;
        NSString *nickName = [self chatNickName:jsonData];
        
        if ([nickName isEqualToString:myNickName]
            || [self.dataManager.defaults isMeFromChatNick:nickName])
        {
            notifyMode = kActionRoomChangeMode;
        }
        else
        {
            notifyMode = kActionRoomChangeMode;
        }
    }else if ([actionName isEqualToString:kChatRoomStarAction])
    {
        notifyMode = kActionRoomStarMode;
    }
    else if ([actionName isEqualToString:kChatRoomAdminListAction])
    {
        notifyMode = kActionRoomAdminListMode;
    }
    else if ([actionName isEqualToString:kChatRoomKickAction])
    {
        NSString *myNickName = self.me.nick_name;
        NSString *nickName = [self chatNickName:jsonData];
        if ([nickName isEqualToString:myNickName]
            || [self.dataManager.defaults isMeFromChatNick:nickName])
        {
            notifyMode = kActionManageMeKickMode;
        }
        else
        {
            notifyMode = kActionManageKickMode;
        }
    }
    else if ([actionName isEqualToString:kChatRoomShutupAction])
    {
        NSString *myNickName = self.me.nick_name;
        NSString *nickName = [self chatNickName:jsonData];
        if ([nickName isEqualToString:myNickName]
            || [self.dataManager.defaults isMeFromChatNick:nickName])
        {
            notifyMode = kActionManageMeShutupMode;
        }
        else
        {
            notifyMode = kActionManageShutupMode;
        }
    }
    else if ([actionName isEqualToString:kChatRoomBroadcastAction])
    {
        notifyMode = kActionMessageBroadcastMode;
    }
    else if ([actionName isEqualToString:kChatRoomUserInfoAction])
    {
        notifyMode = kActionUserInfoMode;
    }
    else if ([actionName isEqualToString:kChatRoomLiveRankAction])
    {
        notifyMode = kActionLiveRankMode;
    }
    else if ([actionName isEqualToString:kChatRoomGiftNotifyAction])
    {
        NSString *myNickName = self.me.nick_name;
        NSString *nickNameFrom = [self giftFromNickName:jsonData];
        NSString *nickNameTo = [self giftToNickName:jsonData];
        if ([nickNameFrom isEqualToString:myNickName]
            || [self.dataManager.defaults isMeFromChatNick:nickNameFrom])
        {
            notifyMode = kActionGiftNotifyFromMeMode;
        }
        else if ([nickNameTo isEqualToString:myNickName]
                 || [self.dataManager.defaults isMeFromChatNick:nickNameTo])
        {
            notifyMode = kActionGiftNotifyToMeMode;
        }
        else
        {
            notifyMode = kActionGiftNotifyMode;
        }
    }
    else if ([actionName isEqualToString:kChatRoomGiftFeatherAction])
    {
        NSString *myNickName = self.me.nick_name;
        NSString *nickNameFrom = [self featherFromNickName:jsonData];
        if ([nickNameFrom isEqualToString:myNickName]
            || [self.dataManager.defaults isMeFromChatNick:nickNameFrom])
        {
            notifyMode = kActionGiftFeatherFromMeMode;
        }
        else
        {
            notifyMode = kActionGiftFeatherMode;
        }
    }
    else if ([actionName isEqualToString:kChatRoomSystemNotice])
    {
        notifyMode = kActionSystemNoticeMode;
    }
    else if ([actionName isEqualToString:kChatRoomGiftMarquee])
    {
        notifyMode = kActionGiftMarqueeMode;
    }
    else if ([actionName isEqualToString:kChatRoomLiveStatusAction])
    {
        notifyMode = kActionLiveStatusMode;
    }
    else if ([actionName isEqualToString:kChatRoomSofaListAction])
    {
        notifyMode = kActionSofaListMode;
    }
    else if ([actionName isEqualToString:kChatRoomPuzzleBeginAction])
    {
        notifyMode = kActionPuzzleBeginMode;
    }
    else if ([actionName isEqualToString:kChatRoomPuzzleWinAction])
    {
        notifyMode = kActionPuzzleWinMode;
    }
    else
    {
        // Chat Content
        NSString *chatContent = [self chatContent:jsonData];
        
        notifyMode = kChatNofityModeNone;
        
        if (![chatContent isEqualToString:@""] && chatContent != nil)
        {
            NSString *nickNameFrom = [self chatFromNickName:jsonData];
            NSString *nickNameTo = [self chatToNickName:jsonData];
            NSString *myNickName = self.me.nick_name;
            BOOL privateConversation = [self chatIsPrivate:jsonData];
            
            if (![nickNameFrom isEqualToString:@""] && nickNameFrom != nil)
            {
                // 'To' field is valid?
                if (![nickNameTo isEqualToString:@""] && nickNameTo != nil)
                {
                    // is Me to Some One?
                    if ([nickNameFrom isEqualToString:myNickName]
                        || [self.dataManager.defaults isMeFromChatNick:nickNameFrom])
                    {
                        // private conversation?
                        if (privateConversation)
                        {
                            notifyMode = kRoomChatMeToOnePrivateMode;
                        }
                        else
                        {
                            notifyMode = kRoomChatMeToOneMode;
                        }
                    }
                    else if ([nickNameTo isEqualToString:myNickName]
                             || [self.dataManager.defaults isMeFromChatNick:nickNameTo])
                    {
                        // private conversation?
                        if (privateConversation)
                        {
                            notifyMode = kRoomChatOneToMePrivateMode;
                        }
                        else
                        {
                            notifyMode = kRoomChatOneToMeMode;
                        }
                    }
                    else
                    {
                        // private conversation?
                        if (privateConversation)
                        {
                            notifyMode = kRoomChatOneToOnePrivateMode;
                        }
                        else
                        {
                            notifyMode = kRoomChatOneToOneMode;
                        }
                    }
                }
                else
                {
                    // is Me to All?
                    if ([nickNameFrom isEqualToString:myNickName]
                        || [self.dataManager.defaults isMeFromChatNick:nickNameFrom])
                    {
                        notifyMode = kRoomChatMeToAllMode;
                    }
                    else
                    {
                        notifyMode = kRoomChatOneToAllMode;
                    }
                }
            }
        }
        else
        {
//            LOGINFO(@"jsonData = %@", jsonData);
        }
    }
    
    // Switch To Responding Notify Mode
    [self switchToWhichNotifyMode:notifyMode withJson:jsonData];
}


// Cut down array'count to kChatHistoryCacheCountMax
- (void)cutDownChatHistory
{
    // Remove First Element.
    if ([self.chatHistoryPublicArray count] > kChatHistoryCacheCountMax)
    {
        [self.chatHistoryPublicArray removeObjectAtIndex:0];
        NSMutableDictionary *firstElement = self.chatHistoryPublicArray[0];
        if ([firstElement isKindOfClass:[NSMutableDictionary class]])
        {
            for (NSString *key in firstElement.allKeys)
            {
                [firstElement removeObjectForKey:key];
            }
        }
        
        //        TTMultiLineView *mv = [firstElement valueForKey:kChatHistoryViewKey];
        //        mv = nil;
        //        firstElement = nil;
    }
}


- (void)starToMe
{
    // NickName
//    NSDictionary *dictNickName = [self chatText:self.currentRoomStar.nick_name size:kChatRoomFontSize color:kFromNickNameColor];
    
    // To
    NSDictionary *dictTo = [self chatText:kChatCommonWordWhisper size:kChatRoomFontSize color:kToColor];
    
    // kToNickNameColor
    NSDictionary *dictToNickName = [self chatText:kChatCommonWordMy size:kChatRoomFontSize color:kToNickNameColor];
    
//    // Say
    NSDictionary *dictSay = [self chatText:[self.dataManager.global isUserlogin]?[NSString stringWithFormat:@"%@,",self.me.nick_name]:@"我" size:kChatRoomFontSize color:kToSayColor];
    
//    NSArray *starPicArray = [self combineStar];
//    NSMutableArray *chatHistory = [NSMutableArray arrayWithArray:starPicArray];
    NSMutableArray *chatHistory = [[NSMutableArray alloc] init];
//    [chatHistory addObject:dictNickName];
    [chatHistory addObject:dictTo];
    [chatHistory addObject:dictToNickName];
    [chatHistory addObject:dictSay];
    
    // Content
    NSArray *contentDicts = [self.uiManager.global splitContent:self.currentRoomStar.greetings];
    if (contentDicts != nil)
    {
        [chatHistory addObjectsFromArray:contentDicts];
    }
    
    TTMultiLineView *cellView = [[TTMultiLineView alloc] initWithSubViews:chatHistory];
    CGFloat cellViewHeight = cellView.frame.size.height;
    NSDictionary *dict = @{kChatHistoryModeKey: @(kRoomChatOneToMePrivateMode),
                           kChatHistoryNickNameFromKey : kFormatNilString(@""),
                           kChatHistoryNickNameToKey : kFormatNilString(self.me.nick_name),
                           kChatHistoryContentKey : kFormatNilString(self.currentRoomStar.greetings),
                           kChatHistoryFromUserIDKey : @(self.currentRoomStar._id),
                           kChatHistoryToUserIDKey : @(self.me._id),
                           kChatHistoryPrivateKey : @(YES),
                           kChatHistoryViewKey : cellView,
                           kChatHistoryViewHeightKey : @(cellViewHeight)};
    [self.chatHistroyPrivateArray addObject:dict];
    [self.chatHistoryPublicArray addObject:dict];
}

//
- (NSArray *)combineStar
{
    // Level
    NSDictionary *levelDictionary = nil;
    // Star.
    NSDictionary *starDictionary = nil;
    
    // kChatWealthLevelShowMin
    NSInteger level = [self.dataManager wealthLevel:self.currentRoomStar.coin_spend_total];
    if (self.currentRoomStar._id != 0)
    {
        if (level >= kChatWealthLevelShowMin)
        {
            levelDictionary = [self wealthLevelDictionary:level];
        }
        
        starDictionary = [self starDictionary];
    }
    
    // Vip?
    NSDictionary *vipDictionary = nil;
    
    switch (self.currentRoomStar.vip)
    {
        case kTrialVip:
            vipDictionary = [self trialVipDictionary];
            break;
        case kVIPNone:
            // do nothing.
            break;
        case kVIPNormal:
            vipDictionary = [self vipDictionary];
            break;
        case kVIPSuper:
            vipDictionary = [self vipExtremeDictionary];
            break;
        default:
            break;
    }
    
    NSMutableArray *picArray = [[NSMutableArray alloc] init];
    
    if (levelDictionary != nil)
    {
        [picArray addObject:levelDictionary];
    }
    
    if (starDictionary != nil)
    {
        [picArray addObject:starDictionary];
    }
    
    if (vipDictionary != nil)
    {
        [picArray addObject:vipDictionary];
    }
    
    return picArray;
}


- (void)defaultChargeTip
{
    // Announce Text.
    NSDictionary *announceDict = [self chatText:kChatDefaultChargeAnnounce size:kChatRoomFontSize color:kDefaultAnnounceColor];

    NSDictionary *chargeDict = [self chatText:[NSString stringWithFormat:@"欢迎来到%@的直播间!",self.currentRoom.nick_name] size:kChatRoomFontSize color:kDefaultChargeColor withUnderLine:NO];

    NSMutableArray *chatHistory;
    if (announceDict && chargeDict) {
      chatHistory = [NSMutableArray arrayWithObjects:announceDict, chargeDict, nil];

    } else {
        chatHistory = [[NSMutableArray alloc] init];
    }

    TTMultiLineView *cellView = [[TTMultiLineView alloc] initWithSubViews:chatHistory];
    CGFloat cellViewHeight = cellView.frame.size.height;
    NSDictionary *dict = @{kChatHistoryModeKey: @(kDefaultAnnounceChargeMode),
                           kChatHistoryViewKey : cellView,
                           kChatHistoryViewHeightKey : @(cellViewHeight)};
    [self.chatHistoryPublicArray addObject:dict];
}

#pragma mark - Default Public Announce History

- (void)roomChatDefaultPublicAnnounce
{
    [self defaultChargeTip];
#if 0
    [self defaultWebsite];
#endif
}

#pragma mark - Room Star Default Private Chat History

- (void)roomChatDefaultPrivateHistory
{
    [self starToMe];
}





- (void)switchToWhichNotifyMode:(ChatRoomNotifyMode)notifyMode withJson:(NSDictionary *)json
{
    switch (notifyMode)
    {
            /******************************************
             ************ Action Part.*****************
             ******************************************/
        case kChatNofityModeNone:
            [self chatNofityModeNone:json];
            break;
        case kActionRoomChangeMode:
            [self actionRoomChangeMode:json];
            break;
        case kActionMeRoomChangeMode:
            [self actionMeRoomChangeMode:json];
            break;
        case kActionRoomStarMode:
            [self actionRoomStarMode:json];
            break;
        case kActionManageKickMode:
            [self actionManageKickMode:json];
            break;
        case kActionManageMeKickMode:
            [self actionManageMeKickMode:json];
            break;
        case kActionManageShutupMode:
            [self actionManageShutupMode:json];
            break;
        case kActionManageMeShutupMode:
            [self actionManageMeShutupMode:json];
            break;
        case kActionMessageBroadcastMode:
            [self actionMessageBroadcastMode:json];
            break;
        case kActionUserInfoMode:
            [self actionUserInfoMode:json];
            break;
        case kActionLiveRankMode:
            [self actionLiveRankMode:json];
            break;
        case kActionGiftNotifyMode:
            [self actionGiftNotifyMode:json];
            break;
        case kActionGiftNotifyFromMeMode:
            [self actionGiftFromMeNotifyMode:json];
            break;
        case kActionGiftNotifyToMeMode:
            [self actionGiftToMeNotifyMode:json];
            break;
        case kActionGiftFeatherMode:
            [self actionGiftFeatherMode:json];
            break;
        case kActionGiftFeatherFromMeMode:
            [self actionGiftFeatherFromMeMode:json];
            break;
        case kActionSystemNoticeMode:
            [self actionSystemNoticeMode:json];
            break;
        case kActionGiftMarqueeMode:
            [self actionGiftMarqueeMode:json];
            break;
        case kActionLiveStatusMode:
            [self actionLiveStatusMode:json];
            break;
//        case kActionSofaListMode:
//            [self actionSofaListMode:json];
//            break;
//        case kActionPuzzleBeginMode:
//            [self actionPuzzleBeginMode:json];
//            break;
//        case kActionPuzzleWinMode:
//            [self actionPuzzleWinMode:json];
//            break;
            /******************************************
             ************ Chat Part.*******************
             ******************************************/
        case kRoomChatMeToAllMode:
            [self roomChatMeToAllMode:json];
            break;
        case kRoomChatMeToOneMode:
            [self roomChatMeToOneMode:json];
            break;
        case kRoomChatMeToOnePrivateMode:
            [self roomChatMeToOnePrivateMode:json];
            break;
        case kRoomChatOneToAllMode:
            [self roomChatOneToAllMode:json];
            break;
        case kRoomChatOneToOneMode:
            [self roomChatOneToOneMode:json];
            break;
        case kRoomChatOneToOnePrivateMode:
            [self roomChatOneToOnePrivateMode:json];
            break;
        case kRoomChatOneToMeMode:
            [self roomChatOneToMeMode:json];
            break;
        case kRoomChatOneToMePrivateMode:    //悄悄话
            [self roomChatOneToMePrivateMode:json];
            break;
        default:
            [self chatNofityModeNone:json];
            break;
    }

    
}

#pragma mark - NofityMode Event Part.

- (void)chatNofityModeNone:(NSDictionary *)json
{
//    LOGINFO(@"chatNofity = %@",json);
}

- (void)actionRoomChangeMode:(NSDictionary *)json
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    BOOL lauched = [userDefaults boolForKey:kSettingShowEnterMessageLaunched];
    if (lauched) { // 已点击过设置按钮，取值点击后的值
        BOOL switchState = [[NSUserDefaults standardUserDefaults] boolForKey:kShowEnterMessage];
        if (switchState) { // 点击后的值为YES，显示进场信息
            [self roomChange:json isMe:NO mode:kActionRoomChangeMode];
        }
    } else { // 未点击过设置按钮，直接显示
        [self roomChange:json isMe:NO mode:kActionRoomChangeMode];
    }
}

- (void)actionMeRoomChangeMode:(NSDictionary *)json
{
    [self roomChange:json isMe:YES mode:kActionMeRoomChangeMode];
}

- (void)roomChatMeToAllMode:(NSDictionary *)json
{
    [self oneToAll:json isFromMe:YES mode:kRoomChatMeToAllMode];
}

- (void)roomChatMeToOneMode:(NSDictionary *)json
{
    [self oneToOne:json isFromMe:YES isToMe:NO isPrivate:NO mode:kRoomChatMeToOneMode];
}

- (void)roomChatMeToOnePrivateMode:(NSDictionary *)json
{
    [self oneToOne:json isFromMe:YES isToMe:NO isPrivate:YES mode:kRoomChatMeToOnePrivateMode];
}

- (void)roomChatOneToAllMode:(NSDictionary *)json
{
    [self oneToAll:json isFromMe:NO mode:kRoomChatOneToAllMode];
}

- (void)roomChatOneToOneMode:(NSDictionary *)json
{
    [self oneToOne:json isFromMe:NO isToMe:NO isPrivate:NO mode:kRoomChatOneToOneMode];
}

- (void)roomChatOneToOnePrivateMode:(NSDictionary *)json
{
    [self oneToOne:json isFromMe:NO isToMe:NO isPrivate:YES mode:kRoomChatOneToOnePrivateMode];
}

- (void)roomChatOneToMeMode:(NSDictionary *)json
{
    [self oneToOne:json isFromMe:NO isToMe:YES isPrivate:NO mode:kRoomChatOneToMeMode];
}

- (void)roomChatOneToMePrivateMode:(NSDictionary *)json
{
//    if (self.audienceToolView)
//    {
//        [self.audienceToolView setPrivateDotHidden:YES];
//    }
    
    [self oneToOne:json isFromMe:NO isToMe:YES isPrivate:YES mode:kRoomChatOneToMePrivateMode];
}

#pragma mark - Other Push...

- (void)actionRoomStarMode:(NSDictionary *)json
{
    [self doRoomStar:json];
}

- (void)actionRoomAdminListMode:(NSDictionary *)json
{
    
}

- (void)actionManageKickMode:(NSDictionary *)json
{
    [self stopAction:json mode:kActionManageKickMode];
}

- (void)actionManageMeKickMode:(NSDictionary *)json
{
    [self stopAction:json mode:kActionManageMeKickMode];
    // God , kicked out. exit UI.
    [self goBack:nil];
}

- (void)actionManageShutupMode:(NSDictionary *)json
{
    [self stopAction:json mode:kActionManageShutupMode];
}

- (void)actionManageMeShutupMode:(NSDictionary *)json
{
    [self stopAction:json mode:kActionManageMeShutupMode];
}

- (void)actionMessageBroadcastMode:(NSDictionary *)json
{
    [self showBroadcast:json];
}

- (void)actionUserInfoMode:(NSDictionary *)json
{
    //    LOGINFO(@"UserInfo Json = %@", json);
}

- (void)actionLiveRankMode:(NSDictionary *)json
{
    //    LOGINFO(@"LiveRank Json = %@", json);
}

- (void)actionGiftNotifyMode:(NSDictionary *)json
{
    //    LOGINFO(@"GiftNotify Json = %@", json);
    [self showGift:json mode:kActionGiftNotifyMode];
}

- (void)actionGiftFromMeNotifyMode:(NSDictionary *)json
{
    [self showGift:json mode:kActionGiftNotifyFromMeMode];
}

- (void)actionGiftToMeNotifyMode:(NSDictionary *)json
{
    [self showGift:json mode:kActionGiftNotifyToMeMode];
}

- (void)actionGiftFeatherMode:(NSDictionary *)json
{
    [self showGift:json mode:kActionGiftFeatherMode];
    
    // update feather count UI.
//    [self increaseFeatherUI];
}

//- (void)increaseFeatherUI
//{
//    if (self.giftPlayContainer)
//    {
//        [self.giftPlayContainer setFeatherIncrease];
//    }
//}

- (void)actionGiftFeatherFromMeMode:(NSDictionary *)json
{
    [self showGift:json mode:kActionGiftFeatherFromMeMode];
    
    
    // update feather count UI.
//    [self increaseFeatherUI];
}

- (void)actionSystemNoticeMode:(NSDictionary *)json
{
    [self showSystemNotice:json mode:kActionSystemNoticeMode];
}

- (void)actionGiftMarqueeMode:(NSDictionary *)json
{
    //    LOGINFO(@"GiftMarquee = %@", json);
    [self hShowGiftMarquee:json mode:kActionGiftMarqueeMode];
}

- (void)actionLiveStatusMode:(NSDictionary *)json
{
    [self setLiveStatus:json];
}


- (void)roomChange:(NSDictionary *)json isMe:(BOOL)me mode:(ChatRoomNotifyMode)mode
{
    CGFloat max = 10;
    NSInteger level = [self.dataManager wealthLevel:[self enterSpend:json]];
    if (!self.commonerChangeRoomDisplay && !me && level < kChatRoomChangedCommoner)
    {
        return;
    }
    
    NSString *nickName = [self enterRoomNickName:json];
    NSUInteger userID = [self enterRoomUserID:json];
    BOOL vipHidding = NO;
    
    NSString *carPicUrl = [self carPicUrl:json];
    NSDictionary *carActionDictionary = nil;
    NSDictionary *carDictionary = nil;
    if (carPicUrl && ![carPicUrl isEqualToString:@""])
    {
        BOOL isFamousCar = [self isFamousCar:json];
        carActionDictionary = [self carEnterDictionary:isFamousCar json:json];
        NSString *carName = [self carName:json];
        
        
        CGSize titleSize = [[NSString stringWithFormat:@"开着%@",carName ] boundingRectWithSize:CGSizeMake(kScreenWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10]} context:nil].size;
        max += (NSInteger)titleSize.width;
        [carActionDictionary setValue:@"YES" forKey:@"commonWordEnter"];
        
        
        carDictionary = [self carDictionary:carPicUrl];
    }else{
        CGSize titleSize = [[NSString stringWithFormat:@"徒步"] boundingRectWithSize:CGSizeMake(kScreenWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10]} context:nil].size;
        max += (NSInteger)titleSize.width;
    }
    
    // is Vip?
    MemberType memberType = [self enterRoomVipType:json];
    if (memberType == kVIPSuper)
    {
        vipHidding = [self enterRoomVipHiding:json];
    }
//    NSDictionary *vipDictionary = nil;
    
//    switch (memberType)
//    {
//        case kTrialVip:
//            vipDictionary = [self trialVipDictionary];
//            break;
//        case kVIPNone:
//            // do nothing.
//            break;
//        case kVIPNormal:
//            vipDictionary = [self vipDictionary];
//            break;
//        case kVIPSuper:
//            vipDictionary = [self vipExtremeDictionary];
//            break;
//        default:
//            break;
//    }
    
    // is admin?
//    BOOL isAdmin = [self roomOneIsAdmin:userID];
//    NSDictionary *adminDictionary = nil;
//    if (isAdmin)
//    {
//        adminDictionary = [self adminDictionary];
//    }
    
    // NickName
    NSString *nick = (vipHidding ? kChatCommonWordMystical : (nickName));
    NSDictionary *dictNickName = [self chatText:[NSString stringWithFormat:@"  %@",nick]
                                           size:kChatoNoNickNameSize
                                          color:[self nike_namecolor:memberType]];
    [dictNickName setValue:@"YES" forKey:@"commonWordEnter"];

    
    // Content
    NSDictionary *dictContent = [self chatText:kChatCommonWordEnter
                                          size:kChatJrSize
                                         color:kEnterRoomColor];
    
    [dictContent setValue:@"YES" forKey:@"commonWordEnter"];

//    [dictContent setValue:@"YES" forKey:@"commonWordEnter"];
    
//    NSArray *dictPics = [self combineFrom:YES
//                                      Pic:json
//                               roomChange:YES];
//    NSMutableArray *chatHistory = [NSMutableArray arrayWithArray:dictPics];
    NSMutableArray *chatHistory = [NSMutableArray arrayWithCapacity:0];
    
//    if (adminDictionary != nil)
//    {
//        max += 12;
//    }
//    
//    if (vipDictionary != nil)
//    {
//        max += 12;
//    }
//    
//    
    CGSize titleSize = [[NSString stringWithFormat:@" 进入房间"] boundingRectWithSize:CGSizeMake(kScreenWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10]} context:nil].size;
    max += (NSInteger)titleSize.width;

    CGSize nike_nametitleSize = [nick boundingRectWithSize:CGSizeMake(kScreenWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil].size;
    max += (NSInteger)nike_nametitleSize.width;
//    NSMutableDictionary *mDic = [NSMutableDictionary dictionaryWithCapacity:0];
//    
//    if (adminDictionary != nil)
//    {
//        [mDic addEntriesFromDictionary:adminDictionary];
//        [mDic setValue:[NSString stringWithFormat:@"%f",max] forKey:@"max"];
//        [chatHistory addObject:adminDictionary];
//    }
//
//    if (vipDictionary != nil)
//    {
//        [mDic addEntriesFromDictionary:vipDictionary];
//        if (adminDictionary == nil)
//        {
//            [mDic setValue:[NSString stringWithFormat:@"%f",max] forKey:@"max"];
//        }
//        [chatHistory addObject:vipDictionary];
//    }
//
    if (carDictionary != nil && !vipHidding)
    {
        max += 40;
    }

    [dictNickName setValue:[NSString stringWithFormat:@"%f",max] forKey:@"max"];

    
    [chatHistory addObject:dictNickName];
    
    
    
    if (carActionDictionary != nil && !vipHidding)
    {
        [chatHistory addObject:carActionDictionary];
    }else{
        carActionDictionary = [self chatText:@"徒步" size:kChatJrSize color:kEnterRoomColor];
        [carActionDictionary setValue:@"YES" forKey:@"commonWordEnter"];
        [chatHistory addObject:carActionDictionary];
    }
    
    if (carDictionary != nil && !vipHidding)
    {
        [chatHistory addObject:carDictionary];
    }
    
    [chatHistory addObject:dictContent];
        
    TTMultiLineView *cellView = [[TTMultiLineView alloc] initWithSubViews:chatHistory];
    CGFloat cellViewHeight = cellView.frame.size.height;
    NSDictionary *dict = @{kChatHistoryModeKey: @(mode),
                           kChatHistoryNickNameKey : kFormatNilString(nickName),
                           kChatHistoryVIPHiddingKey : @(vipHidding),
                           kChatHistoryUserIDKey : @(userID),
                           kChatHistoryViewKey : cellView,
                           kChatHistoryViewHeightKey : @(cellViewHeight)};
    
    [self.chatHistoryPublicArray addObject:dict];
}

//进场名字颜色
-(ChatRoomFontColorMode)nike_namecolor:(MemberType)memberType
{
    switch (memberType)
    {
        case kTrialVip:
            return kSendFeatherFrom;
            break;
        case kVIPNone:
            // do nothing.
            break;
        case kVIPNormal:
            return kSendFeatherFrom;
            break;
        case kVIPSuper:
            return kZColor;
            break;
        default:
            break;
    }
    return kJcNameColor;
}

//说话名字颜色ono
-(ChatRoomFontColorMode)oNonike_namecolor:(MemberType)memberType
{
    switch (memberType)
    {
        case kTrialVip:
            return kSendFeatherFrom1;
            break;
        case kVIPNone:
            // do nothing.
            break;
        case kVIPNormal:
            return kSendFeatherFrom1;
            break;
        case kVIPSuper:
            return kZColor1;
            break;
        default:
            break;
    }
    return kFromNickNameColor;
}


//说话名字颜色to
-(ChatRoomFontColorMode)Tonike_namecolor:(MemberType)memberType
{
    switch (memberType)
    {
        case kTrialVip:
            return kSendFeatherFrom;
            break;
        case kVIPNone:
            // do nothing.
            break;
        case kVIPNormal:
            return kSendFeatherFrom;
            break;
        case kVIPSuper:
            return kZColor;
            break;
        default:
            break;
    }
    return kToNickNameColor;
}

//说话颜色
-(ChatRoomFontColorMode)oNoContentcolor:(MemberType)memberType
{
    switch (memberType)
    {
        case kTrialVip:
            return kSendFeatherFrom;
            break;
        case kVIPNone:
            // do nothing.
            break;
        case kVIPNormal:
            return kSendFeatherFrom;
            break;
        case kVIPSuper:
            return kZColor;
            break;
        default:
            break;
    }
    return kBColor;
}


- (void)oneToAll:(NSDictionary *)json isFromMe:(BOOL)me mode:(ChatRoomNotifyMode)mode
{
    MemberType memberType = [self roomFromVip:json];
    // NickName
    NSDictionary *dictNickName = [self chatText:([self chatFromNickName:json])
                                           size:kChatoNoNickNameSize
                                          color:[self oNonike_namecolor:memberType]];
    
    
    // Say
    NSDictionary *dictSay = [self chatText:kChatCommonWordSay
                                      size:kChatRoomFontSize
                                     color:[self oNonike_namecolor:memberType]];
    
    [dictSay setValue:@"YES" forKey:@"nike_oNo"];
    
    NSArray *dictPics = [self combineFrom:YES
                                      Pic:json
                               roomChange:NO];
    
    // Content
    NSMutableArray *chatHistory = [NSMutableArray arrayWithArray:dictPics];
    [chatHistory addObject:dictNickName];
    [chatHistory addObject:dictSay];
    
    NSArray *contentDicts = [self.uiManager.global splitContent:[self chatContent:json] color:[self oNoContentcolor:memberType] size:kChatRoomFontSize];
    
//   [chatHistory addObject:contentDicts];
    
    if (contentDicts != nil)
    {
        [chatHistory addObjectsFromArray:contentDicts];
        
    }
    
    TTMultiLineView *cellView = [[TTMultiLineView alloc] initWithSubViews:chatHistory];
    CGFloat cellViewHeight = cellView.frame.size.height;
    NSDictionary *dict = @{kChatHistoryModeKey: @(mode),
                           kChatHistoryNickNameFromKey : kFormatNilString([self chatFromNickName:json]),
                           kChatHistoryContentKey : kFormatNilString([self chatContent:json]),
                           kChatHistoryFromUserIDKey : @([self chatFromUserID:json]),
                           kChatHistoryViewKey : cellView,
                           kChatHistoryViewHeightKey : @(cellViewHeight)};
    [self.chatHistoryPublicArray addObject:dict];
}

- (NSArray *)combineFrom:(BOOL)isFrom Pic:(NSDictionary *)jsonData roomChange:(BOOL)isRoomChange
{
    // User Type.
    NSInteger userType = 0;
    if (isRoomChange)
    {
        userType = [self enterPriv:jsonData];
    }
    else
    {
        userType = (isFrom ? [self roomFromPriv:jsonData] : [self roomToPriv:jsonData]);
    }
    
    NSDictionary *userTypeDictionary = nil;
    switch (userType)
    {
        case kChatManager:
            userTypeDictionary = [self businessDictionary];
            break;
        case kChatAnchor:
            // Do nothing...
            break;
        case kChatNormal:
            // Do nothing...
            break;
        case kChatCService:
            
            userTypeDictionary = [self cServiceDictionary];
            break;
        case kChatAgent:
            userTypeDictionary = [self agentDictionary];
            break;
        default:
            break;
    }

    
    // spent most?
    BOOL isSpentMost = (isFrom ? [self roomFromSpentMost:jsonData] : [self roomToSpentMost:jsonData]);
    NSDictionary *spentMostDictionary = nil;
    if (isSpentMost)
    {
        spentMostDictionary = [self spentMostDictionary];
    }
    
    // is star?
    BOOL isStar = (isFrom ? [self roomFromStar:jsonData] : [self roomToStar:jsonData]);
    NSDictionary *starDictionary = nil;
    if (isStar)
    {
        starDictionary = [self starDictionary];
    }
    
    // star level or wealth level.
    NSInteger level = (isFrom ? [self roomFromLevel:jsonData] : [self roomToLevel:jsonData]);
    NSDictionary *levelDictionary = nil;
    if (isStar)
    {
        level = [self.dataManager wealthLevel:self.currentRoomStar.coin_spend_total];
    }
    
    if (level >= kChatWealthLevelShowMin)
    {
        levelDictionary = [self wealthLevelDictionary:level];
    }
    
    // is admin?
    BOOL isAdmin = (isFrom ? [self roomFromAdmin:jsonData] : [self roomToAdmin:jsonData]);
    NSDictionary *adminDictionary = nil;
    if (isAdmin)
    {
        adminDictionary = [self adminDictionary];
    }
    
    // is Vip?
    MemberType memberType = (isFrom ? [self roomFromVip:jsonData] : [self roomToVip:jsonData]);
    NSDictionary *vipDictionary = nil;
    switch (memberType)
    {
        case kTrialVip:
            vipDictionary = [self trialVipDictionary];
            break;
        case kVIPNone:
            // do nothing.
            break;
        case kVIPNormal:
            vipDictionary = [self vipDictionary];
            break;
        case kVIPSuper:
            vipDictionary = [self vipExtremeDictionary];
            break;
        default:
            break;
    }
    
    NSInteger userid = 0;
    NSDictionary *userFlamesDictionary = nil;
    if (isRoomChange)
    {
        userid = [self enterRoomUserID:jsonData];
    }
    else
    {
        userid = (isFrom ? [self chatFromUserID:jsonData] : [self chatToUserID:jsonData]);
    }
    
    BOOL isFlames = [self roomOneHasFlames:userid];
    if (isFlames)
    {
        userFlamesDictionary = [self flameDictionary];
    }
    
    NSMutableArray *picArray = [[NSMutableArray alloc] init];
    if (userTypeDictionary != nil)
    {
        [picArray addObject:userTypeDictionary];
    }
    
    if (levelDictionary != nil)
    {
        [picArray addObject:levelDictionary];
    }
    
    if (adminDictionary != nil)
    {
        [picArray addObject:adminDictionary];
    }
    
    if (starDictionary != nil)
    {
        [picArray addObject:starDictionary];
    }
    
    if (vipDictionary != nil)
    {
        [picArray addObject:vipDictionary];
    }
    
    if (spentMostDictionary != nil)
    {
        [picArray addObject:spentMostDictionary];
    }
    
    if (userFlamesDictionary != nil)
    {
        [picArray addObject:userFlamesDictionary];
    }
    
    return picArray;
}

- (void)oneToOne:(NSDictionary *)json isFromMe:(BOOL)fromMe isToMe:(BOOL)toMe isPrivate:(BOOL)private mode:(ChatRoomNotifyMode)mode
{
    if (fromMe && toMe)
    {
        // No talking to self.
        return;
    }
    
    MemberType memberType = [self roomFromVip:json];
    
    // NickName
    NSDictionary *dictNickName = [self chatText:([self chatFromNickName:json]) size:kChatoNoNickNameSize color:[self oNonike_namecolor:memberType]];
    
    // To
    NSDictionary *dictTo = [self chatText:kChatCommonWordTo size:kChatoNoNickNameSize color:kToColor];
    [dictTo setValue:@"YES" forKey:@"nike_oNo"];
    
    
    MemberType memberType1 = [self roomToVip:json];
    
    NSDictionary *dictQa = [self chatText:kChatCommonWordMy size:kChatRoomFontSize color:[self Tonike_namecolor:memberType1]];
    
    
    // kToNickNameColor
    NSDictionary *dictToNickName = [self chatText:([self chatToNickName:json]) size:kChatRoomFontSize color:[self Tonike_namecolor:memberType1]];
    
    // Say
    NSDictionary *dictSay = [self chatText:@"," size:kChatRoomFontSize color:[self Tonike_namecolor:memberType1]];
    
    NSArray *dictPics = [self combineFrom:YES Pic:json roomChange:NO];
    NSArray *dictPicsTo = [self combineFrom:NO Pic:json roomChange:NO];
    
    NSMutableArray *chatHistory;
    if (dictPics) {
        chatHistory = [NSMutableArray arrayWithArray:dictPics];
    } else {
        chatHistory = [[NSMutableArray alloc] init];
    }
    [chatHistory addObject:dictNickName];
    [chatHistory addObject:dictTo];
    [chatHistory addObject:dictQa];
    [chatHistory addObjectsFromArray:dictPicsTo];
    [chatHistory addObject:dictToNickName];
    [chatHistory addObject:dictSay];
    
    // Content
    NSArray *contentDicts = [self.uiManager.global splitContent:[self chatContent:json] color:[self oNoContentcolor:memberType] size:kChatRoomFontSize];
    if (contentDicts != nil)
    {
        [chatHistory addObjectsFromArray:contentDicts];
    }
    
    TTMultiLineView *cellView = [[TTMultiLineView alloc] initWithSubViews:chatHistory];
    CGFloat cellViewHeight = cellView.frame.size.height;
    NSDictionary *dict = @{kChatHistoryModeKey: @(mode),
                           kChatHistoryNickNameFromKey : kFormatNilString([self chatFromNickName:json]),
                           kChatHistoryNickNameToKey : kFormatNilString([self chatToNickName:json]),
                           kChatHistoryContentKey : kFormatNilString([self chatContent:json]),
                           kChatHistoryFromUserIDKey : @([self chatFromUserID:json]),
                           kChatHistoryToUserIDKey : @([self chatToUserID:json]),
                           kChatHistoryPrivateKey : @(private),
                           kChatHistoryViewKey : cellView,
                           kChatHistoryViewHeightKey : @(cellViewHeight)
                           };
//    if (!private)
//    {
        [self.chatHistoryPublicArray addObject:dict];
//    }
    if (toMe || fromMe)
    {
        [self.chatHistroyPrivateArray addObject:dict];
    }
}

#pragma mark - Room Star part.

- (void)doRoomStar:(NSDictionary *)json
{
    // update room star upgrade bean count of upgrade.
    long long int roomStarBeanTotalCount = [self roomStarBeanTotalCount:json];
    NSInteger needBean = [self upgradeNeedBeanCount:roomStarBeanTotalCount];
    [self updateStarUpgradeNeedBeanCount:needBean];
}

- (void)stopAction:(NSDictionary *)json mode:(ChatRoomNotifyMode)mode
{
    NSString *nickNameFrom = [self stopNickNameFrom:json];
    NSInteger IDFrom = [self stopIDFrom:json];
    NSString *nickNameTo = [self stopNickNameTo:json];
    NSInteger stopTime = [self stopTime:json];
    BOOL isMeStop = NO;
    
    NSString *content = nil;
    switch (mode) {
        case kActionManageShutupMode:
            content = [NSString stringWithFormat:kChatCommonShutup, (long)stopTime];
            isMeStop = NO;
            break;
        case kActionManageMeShutupMode:
            isMeStop = YES;
            content = [NSString stringWithFormat:kChatCommonShutup, (long)stopTime];
            break;
        case kActionManageKickMode:
            isMeStop = NO;
            content = kChatCommonKickOut;
            break;
        case kActionManageMeKickMode:
            isMeStop = YES;
            content = kChatCommonKickOut;
            break;
        default:
            break;
    }
    
    MemberType memberType = [self roomFromVip:json];
    // To.
    NSDictionary *dictNickNameTo = [self chatText:nickNameTo size:kChatRoomFontSize color:[self oNonike_namecolor:memberType]];
    
    // Suffer.
    NSDictionary *dictSuffer = [self chatText:kChatCommonSuffer size:kChatRoomFontSize color:kFromNickNameColor];
    
    // is admin?
    BOOL isAdmin = [self roomOneIsAdmin:IDFrom];
    NSDictionary *adminDictionary = nil;
    if (isAdmin)
    {
        adminDictionary = [self adminDictionary];
    }
    
    // is Star?
    BOOL isStar = [self roomOneIsStar:IDFrom];
    NSDictionary *starDictionary = nil;
    if (isStar)
    {
        starDictionary = [self starDictionary];
    }
    
    MemberType memberType1 = [self roomToVip:json];
    // From
    NSDictionary *dictNickName = [self chatText:(isMeStop ? kChatCommonWordYou : nickNameFrom)
                                           size:kChatRoomFontSize
                                          color:[self Tonike_namecolor:memberType1]];
    
    // Content
    NSDictionary *dictNickNameContent = [self chatText:content
                                                  size:kChatRoomFontSize
                                                 color:kBColor];
    NSMutableArray *chatHistory = [NSMutableArray arrayWithObjects:dictNickNameTo, dictSuffer, nil];
    
    if (adminDictionary != nil)
    {
        [chatHistory addObject:adminDictionary];
    }
    
    if (starDictionary != nil)
    {
        [chatHistory addObject:starDictionary];
    }
    
    [chatHistory addObject:dictNickName];
    [chatHistory addObject:dictNickNameContent];
    
    TTMultiLineView *cellView = [[TTMultiLineView alloc] initWithSubViews:chatHistory];
    CGFloat cellViewHeight = cellView.frame.size.height;
    NSDictionary *dict = @{kChatHistoryModeKey: @(mode),
                           kChatHistoryNickNameKey : kFormatNilString(nickNameFrom),
                           kChatHistoryUserIDKey : @(IDFrom),
                           kChatHistoryViewKey : cellView,
                           kChatHistoryViewHeightKey : @(cellViewHeight)};
    
    [self.chatHistoryPublicArray addObject:dict];
}

- (void)goBack:(id)sender
{
    self.closeSocketIOWhenDisappear = YES;
    
    [self closeSockIO];
    
    [self.mediaPlayer1 stop];
    [self clearCache];

    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)clearCache
{
    [self.dataManager.defaults setNickNameCacheCopy:@""];
}

#pragma mark - Show Broadcast part.

- (void)showBroadcast:(NSDictionary *)json
{
    if (self.broadcastCaches == nil)
    {
        NSMutableArray *bc = [[NSMutableArray alloc] init];
        self.broadcastCaches = bc;
    }
    
    NSMutableDictionary *broadcastDict = [[NSMutableDictionary alloc] init];
    [broadcastDict setValue:[self broadcastMessage:json] forKey:@"broadcast.content"];
    [broadcastDict setValue:[self broadcastFromNickName:json] forKey:@"broadcast.nick"];
    [broadcastDict setValue:[self broadcastRoomStar:json] forKey:@"broadcast.roomstar"];
    [self.broadcastCaches addObject:broadcastDict];
}

- (void)showGift:(NSDictionary *)json mode:(ChatRoomNotifyMode)mode
{
    // From
    NSString *nickNameFrom = nil;
    NSInteger useridFrom = 0;
    switch (mode)
    {
            // gift.
        case kActionGiftNotifyFromMeMode:
            nickNameFrom = self.me.nick_name;
            useridFrom = self.me._id;
            break;
        case kActionGiftNotifyToMeMode:
        case kActionGiftNotifyMode:
            nickNameFrom = [self giftFromNickName:json];
            useridFrom = [self giftFromID:json];
            break;
            
            // feather.
        case kActionGiftFeatherFromMeMode:
            nickNameFrom = self.me.nick_name;
            useridFrom = self.me._id;
            break;
        case kActionGiftFeatherMode:
            nickNameFrom = [self featherFromNickName:json];
            useridFrom = [self featherFromID:json];
            break;
        default:
            break;
    }
    
    NSDictionary *dictFromNickName = [self chatText:nickNameFrom size:kChatRoomSendFontSize color:kSendFeatherFrom];
    
    // Send
    NSDictionary *dictSend = [self chatText:kChatCommonSend size:kChatRoomSendFontSize color:kSend];
    
    NSString *nickNameTo = nil;
    NSInteger useridTo = 0;
    switch (mode)
    {
            // gift.
        case kActionGiftNotifyToMeMode:
            nickNameTo = self.me.nick_name;
            useridTo = self.me._id;
            break;
        case kActionGiftNotifyFromMeMode:
        case kActionGiftNotifyMode:
            nickNameTo = [self giftToNickName:json];
            useridTo = [self giftToID:json];
            break;
            
            // feather.
        case kActionGiftFeatherFromMeMode:
        case kActionGiftFeatherMode:
            nickNameTo = [self.currentRoomStar.nick_name stringByUnescapingFromHTML];
            useridTo = self.currentRoomStar._id;
            break;
        default:
            break;
    }
    
    
    

    // To
    NSDictionary *dictToNickName = [self chatText:nickNameTo size:kChatRoomSendFontSize color:kSendFeatherTo];
    
    // Pic
    NSDictionary *picDictionary = nil;
    if (mode == kActionGiftNotifyMode ||
        mode == kActionGiftNotifyFromMeMode ||
        mode == kActionGiftNotifyToMeMode)
    {
        picDictionary = [self giftDictionary:[self giftPicUrl:[self giftID:json]]];
    }
    else
    {
        picDictionary = [self featherDictionary];

    }
    
    // Count
    NSString *giftCountString = nil;
    if (mode == kActionGiftNotifyMode ||
        mode == kActionGiftNotifyFromMeMode ||
        mode == kActionGiftNotifyToMeMode)
    {
        giftCountString = [[NSString alloc] initWithFormat:kChatCommonSendGiftCount, (long)[self giftCount:json]];

//        dispatch_async(dispatch_get_global_queue(0, 0), ^{
//            if ((long)[self giftCount:json]>=50&&(long)[self giftCount:json]<=99)
//            {
//                [self run:[UIImage imageNamed:@"怪盗基德"] xml:@"smile_face"];
//            }else if ((long)[self giftCount:json]>=100&&(long)[self giftCount:json]<=299)
//            {
//                [self run:[UIImage imageNamed:@"怪盗基德"] xml:@"love"];
//            }else if ((long)[self giftCount:json]>=300&&(long)[self giftCount:json]<=519)
//            {
//                [self run:[self getImageFromURL:[self giftPicUrl:[self giftID:json]]] xml:@"double_heart"];
//            }else if ((long)[self giftCount:json]>=520&&(long)[self giftCount:json]<=1313)
//            {
//                [self run:[self getImageFromURL:[self giftPicUrl:[self giftID:json]]] xml:@"v520"];
//            }else if ((long)[self giftCount:json]>=1314&&(long)[self giftCount:json]<=3343)
//            {
//                [self run:[self getImageFromURL:[self giftPicUrl:[self giftID:json]]] xml:@"v1314"];
//            }else if ((long)[self giftCount:json]>=3344&&(long)[self giftCount:json]<=9998)
//            {
//                [self run:[self getImageFromURL:[self giftPicUrl:[self giftID:json]]] xml:@"v3344"];
//            }else if ((long)[self giftCount:json]>=9999)
//            {
//                [self run:[self getImageFromURL:[self giftPicUrl:[self giftID:json]]] xml:@"heart"];
//            }
//        });
    }
    else
    {
        giftCountString = kChatCommonSendFeatherCount;
    }
    
    NSDictionary *dictCount = [self chatText:giftCountString
                                        size:kChatRoomSendFontSize
                                       color:kSystemNoticeContent];
    
    
    NSMutableArray *sendArrays = [NSMutableArray arrayWithCapacity:0];
    NSArray *starPicArray = [self combineStar];
    

    [sendArrays addObject:dictFromNickName];
    [sendArrays addObject:dictSend];
    [sendArrays addObjectsFromArray:starPicArray];
    [sendArrays addObject:dictToNickName];

    
    [sendArrays addObject:dictCount];
    
    if (picDictionary != nil)
    {
        [sendArrays addObject:picDictionary];
    }
    /*
     kChatHistoryNickNameFromKey : kFormatNilString([self chatFromNickName:json]),
     kChatHistoryContentKey : kFormatNilString([self chatContent:json]),
     kChatHistoryFromUserIDKey : @([self chatFromUserID:json]),
     */
    
    TTMultiLineView *giftView = [[TTMultiLineView alloc] initWithSubViews:sendArrays];
    NSDictionary *dict = @{kChatHistoryModeKey: @(mode),
                           kChatHistoryNickNameFromKey : kFormatNilString(nickNameFrom),
                           kChatHistoryFromUserIDKey : @(useridFrom),
                           kChatHistoryNickNameToKey : kFormatNilString(nickNameTo),
                           kChatHistoryToUserIDKey : @(useridTo),
                           kChatHistoryViewKey : giftView,
                           kChatHistoryViewHeightKey : @(giftView.frame.size.height)};
    [self.chatHistoryPublicArray addObject:dict];
    
    if (mode == kActionGiftNotifyMode ||
        mode == kActionGiftNotifyFromMeMode ||
        mode == kActionGiftNotifyToMeMode)
    {
        // full screen gif animation.
        NSInteger giftCount = [self giftCount:json];
        NSInteger coinPrice = [self giftCoinPrice:json];
        NSString *gifUrlString = [self giftPicGif:[self giftID:json]];
        NSString *giftName = [self giftName:[self giftID:json]];
        
        if (giftCount * coinPrice >= kChatFullScreenGifMax)
        {
            if (self.giftGifCaches == nil)
            {
                NSMutableArray *ggc = [[NSMutableArray alloc] init];
                self.giftGifCaches = ggc;
            }
            
            // Extra Parameter.
            [json setValue:[self giftPicUrl:[self giftID:json]] forKey:@"pic_url"];
            [json setValue:giftName forKey:@"name"];
            
            NSMutableDictionary *gifDictionary = [[NSMutableDictionary alloc] init];
            [gifDictionary setValue:json forKey:@"chat.giftjson"];
            [gifDictionary setValue:gifUrlString forKey:@"chat.gifurl"];
            [self.giftGifCaches addObject:gifDictionary];
        }
    }
}

- (void)showSystemNotice:(NSDictionary *)json mode:(ChatRoomNotifyMode)mode
{
    // Notice Tip:
    NSDictionary *dictTip = [self chatText:kChatCommonSystemNotice size:kChatRoomFontSize color:kSystemNoticeTip];
    
    // Notice Content
    NSDictionary *dictContent = [self chatText:[self noticeContent:json] size:kChatRoomFontSize color:kSystemNoticeContent];
    
    NSMutableArray *chatHistory = [NSMutableArray arrayWithObjects:dictTip, dictContent, nil];
    
    TTMultiLineView *cellView = [[TTMultiLineView alloc] initWithSubViews:chatHistory];
    CGFloat cellViewHeight = cellView.frame.size.height;
    NSDictionary *dict = @{kChatHistoryViewKey: cellView,
                           kChatHistoryViewHeightKey : @(cellViewHeight)};
    [self.chatHistoryPublicArray addObject:dict];
}

- (void)hShowGiftMarquee:(NSDictionary *)json mode:(ChatRoomNotifyMode)mode
{
    // From
    NSDictionary *dictFromNickName = [self chatText:[self giftFromNickName:json] size:kChatRoomSingleLineSendFontSize color:kSendFeatherFrom];
    
    // Send
    NSDictionary *dictSend = [self chatText:kChatCommonSend size:kChatRoomSingleLineSendFontSize color:kSend];
    
    // To
    NSDictionary *dictToNickName = [self chatText:[self giftToNickName:json] size:kChatRoomSingleLineSendFontSize color:kSendFeatherFrom];
    
    // Pic
    NSDictionary *picDictionary = [self giftDictionary:[self giftPicUrl:[self giftID:json]]];
    
    // Count
    NSString *giftCountString = [NSString stringWithFormat:kChatCommonSendGiftCount, (long)[self giftCount:json]];
    NSDictionary *dictCount = [self chatText:giftCountString size:kChatRoomSingleLineSendFontSize color:kSendGiftMarqueeContent];
    NSMutableArray *sendArrays = [NSMutableArray arrayWithObjects:dictFromNickName, dictSend, nil];
    NSArray *starPicArray = [self combineStar];
    if ([self giftToNickName:json]==[self.currentRoomStar.nick_name stringByUnescapingFromHTML]) {
        [sendArrays addObjectsFromArray:starPicArray];
    }
    [sendArrays addObject:dictToNickName];
    [sendArrays addObject:picDictionary];
    [sendArrays addObject:dictCount];
    
    
    // join gift into cache before Execute Animations.
    TTSingleLineView *giftView = [[TTSingleLineView alloc] initWithSubViews:sendArrays];
//        TTSingleLineView *giftView = [TTSingleLineView singleLineView:sendArrays];
    giftView.backgroundColor = [UIColor colorWithWhite:0.4f alpha:0.4f];
    
    if (self.giftMarqueeCaches == nil)
    {
        NSMutableArray *gmc = [[NSMutableArray alloc] init];
        self.giftMarqueeCaches = gmc;
    }
    
    if (giftView) {
        [self.giftMarqueeCaches addObject:giftView];
    }
}

#pragma mark - Live Stauts part.
- (void)setLiveStatus:(NSDictionary *)json
{
    BOOL liveStatus = [self live:json];
    if (!liveStatus)
    {
        // Close Live.
        [self closeLive];
    }
    else
    {
        [self startLive];
    }
}

// just call me carefully.
- (void)closeLive
{
//    [self.mediaPlayer1 pause];
//    [self.uiManager.global setNoLiveVideoTip:self.playerContainer1];
    self.currentRoom.live = NO;
}

- (void)startLive
{
//    [self.uiManager.global removeNoLiveVideoTip:self.playerContainer1];
    self.currentRoom.live = YES;
    [self reconnectAll];
}

@end
