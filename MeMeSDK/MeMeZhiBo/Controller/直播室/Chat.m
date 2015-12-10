//
//  Chat.m
//  memezhibo
//
//  Created by Xingai on 15/6/9.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "Chat.h"

@implementation Chat

- (void)handleReceivedMessage:(id)data
{
    [self abondonLoadingText];
    
    [self receiveMessage:data];
    
//    [self updateChatHistoryUI];
}

- (void)abondonLoadingText
{
    __weak __typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.25f animations:^{
//        if (weakSelf.chatHistoryTableView)
//        {
//            weakSelf.chatHistoryTableView.alpha = 1.0f;
//        }
//        
//        if (weakSelf.loadingText)
//        {
//            weakSelf.loadingText.alpha = 0.0f;
//        }
    } completion:^(BOOL finished) {
//        if (weakSelf.loadingText)
//        {
//            [weakSelf.loadingText removeFromSuperview];
//            weakSelf.loadingText = nil;
//        }
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
    
    
    if (self.chatHistoryArray == nil)
    {
        // init data container.
        
        NSMutableArray *publicArray = [[NSMutableArray alloc] init];
        NSMutableArray *privateArray = [[NSMutableArray alloc] init];
        self.chatHistoryPublicArray = publicArray;
        self.chatHistroyPrivateArray = privateArray;
        
//        // Default Public Message.
//        [self roomChatDefaultPublicAnnounce];
//        
//        // Default Private Message.
//        [self roomChatDefaultPrivateHistory];
        
        // Defaut Public Chat.
        self.chatHistoryArray = self.chatHistoryPublicArray;
    }
    else
    {
//        [self cutDownChatHistory];
    }
    
    // Parse Nofity Mode.
//    NSString *actionName = [self action:jsonData];
//    ChatRoomNotifyMode notifyMode;
//    
//    if ([actionName isEqualToString:kChatRoomSomeoneEnterAction])
//    {
//        NSString *myNickName = self.me.nick_name;
//        NSString *nickName = [self chatNickName:jsonData];
//        if ([nickName isEqualToString:myNickName]
//            || [self.dataManager.defaults isMeFromChatNick:nickName])
//        {
//            notifyMode = kActionMeRoomChangeMode;
//        }
//        else
//        {
//            notifyMode = kActionRoomChangeMode;
//        }
//    }
//    else if ([actionName isEqualToString:kChatRoomStarAction])
//    {
//        notifyMode = kActionRoomStarMode;
//    }
//    else if ([actionName isEqualToString:kChatRoomAdminListAction])
//    {
//        notifyMode = kActionRoomAdminListMode;
//    }
//    else if ([actionName isEqualToString:kChatRoomKickAction])
//    {
//        NSString *myNickName = self.me.nick_name;
//        NSString *nickName = [self chatNickName:jsonData];
//        if ([nickName isEqualToString:myNickName]
//            || [self.dataManager.defaults isMeFromChatNick:nickName])
//        {
//            notifyMode = kActionManageMeKickMode;
//        }
//        else
//        {
//            notifyMode = kActionManageKickMode;
//        }
//    }
//    else if ([actionName isEqualToString:kChatRoomShutupAction])
//    {
//        NSString *myNickName = self.me.nick_name;
//        NSString *nickName = [self chatNickName:jsonData];
//        if ([nickName isEqualToString:myNickName]
//            || [self.dataManager.defaults isMeFromChatNick:nickName])
//        {
//            notifyMode = kActionManageMeShutupMode;
//        }
//        else
//        {
//            notifyMode = kActionManageShutupMode;
//        }
//    }
//    else if ([actionName isEqualToString:kChatRoomBroadcastAction])
//    {
//        notifyMode = kActionMessageBroadcastMode;
//    }
//    else if ([actionName isEqualToString:kChatRoomUserInfoAction])
//    {
//        notifyMode = kActionUserInfoMode;
//    }
//    else if ([actionName isEqualToString:kChatRoomLiveRankAction])
//    {
//        notifyMode = kActionLiveRankMode;
//    }
//    else if ([actionName isEqualToString:kChatRoomGiftNotifyAction])
//    {
//        NSString *myNickName = self.me.nick_name;
//        NSString *nickNameFrom = [self giftFromNickName:jsonData];
//        NSString *nickNameTo = [self giftToNickName:jsonData];
//        if ([nickNameFrom isEqualToString:myNickName]
//            || [self.dataManager.defaults isMeFromChatNick:nickNameFrom])
//        {
//            notifyMode = kActionGiftNotifyFromMeMode;
//        }
//        else if ([nickNameTo isEqualToString:myNickName]
//                 || [self.dataManager.defaults isMeFromChatNick:nickNameTo])
//        {
//            notifyMode = kActionGiftNotifyToMeMode;
//        }
//        else
//        {
//            notifyMode = kActionGiftNotifyMode;
//        }
//    }
//    else if ([actionName isEqualToString:kChatRoomGiftFeatherAction])
//    {
//        NSString *myNickName = self.me.nick_name;
//        NSString *nickNameFrom = [self featherFromNickName:jsonData];
//        if ([nickNameFrom isEqualToString:myNickName]
//            || [self.dataManager.defaults isMeFromChatNick:nickNameFrom])
//        {
//            notifyMode = kActionGiftFeatherFromMeMode;
//        }
//        else
//        {
//            notifyMode = kActionGiftFeatherMode;
//        }
//    }
//    else if ([actionName isEqualToString:kChatRoomSystemNotice])
//    {
//        notifyMode = kActionSystemNoticeMode;
//    }
//    else if ([actionName isEqualToString:kChatRoomGiftMarquee])
//    {
//        notifyMode = kActionGiftMarqueeMode;
//    }
//    else if ([actionName isEqualToString:kChatRoomLiveStatusAction])
//    {
//        notifyMode = kActionLiveStatusMode;
//    }
//    else if ([actionName isEqualToString:kChatRoomSofaListAction])
//    {
//        notifyMode = kActionSofaListMode;
//    }
//    else if ([actionName isEqualToString:kChatRoomPuzzleBeginAction])
//    {
//        notifyMode = kActionPuzzleBeginMode;
//    }
//    else if ([actionName isEqualToString:kChatRoomPuzzleWinAction])
//    {
//        notifyMode = kActionPuzzleWinMode;
//    }
//    else
//    {
//        // Chat Content
//        NSString *chatContent = [self chatContent:jsonData];
//        
//        notifyMode = kChatNofityModeNone;
//        
//        if (![chatContent isEqualToString:@""] && chatContent != nil)
//        {
//            NSString *nickNameFrom = [self chatFromNickName:jsonData];
//            NSString *nickNameTo = [self chatToNickName:jsonData];
//            NSString *myNickName = self.me.nick_name;
//            BOOL privateConversation = [self chatIsPrivate:jsonData];
//            
//            if (![nickNameFrom isEqualToString:@""] && nickNameFrom != nil)
//            {
//                // 'To' field is valid?
//                if (![nickNameTo isEqualToString:@""] && nickNameTo != nil)
//                {
//                    // is Me to Some One?
//                    if ([nickNameFrom isEqualToString:myNickName]
//                        || [self.dataManager.defaults isMeFromChatNick:nickNameFrom])
//                    {
//                        // private conversation?
//                        if (privateConversation)
//                        {
//                            notifyMode = kRoomChatMeToOnePrivateMode;
//                        }
//                        else
//                        {
//                            notifyMode = kRoomChatMeToOneMode;
//                        }
//                    }
//                    else if ([nickNameTo isEqualToString:myNickName]
//                             || [self.dataManager.defaults isMeFromChatNick:nickNameTo])
//                    {
//                        // private conversation?
//                        if (privateConversation)
//                        {
//                            notifyMode = kRoomChatOneToMePrivateMode;
//                        }
//                        else
//                        {
//                            notifyMode = kRoomChatOneToMeMode;
//                        }
//                    }
//                    else
//                    {
//                        // private conversation?
//                        if (privateConversation)
//                        {
//                            notifyMode = kRoomChatOneToOnePrivateMode;
//                        }
//                        else
//                        {
//                            notifyMode = kRoomChatOneToOneMode;
//                        }
//                    }
//                }
//                else
//                {
//                    // is Me to All?
//                    if ([nickNameFrom isEqualToString:myNickName]
//                        || [self.dataManager.defaults isMeFromChatNick:nickNameFrom])
//                    {
//                        notifyMode = kRoomChatMeToAllMode;
//                    }
//                    else
//                    {
//                        notifyMode = kRoomChatOneToAllMode;
//                    }
//                }
//            }
//        }
//        else
//        {
//            LOGINFO(@"jsonData = %@", jsonData);
//        }
//    }
//    
//    // Switch To Responding Notify Mode
//    [self switchToWhichNotifyMode:notifyMode withJson:jsonData];
}

//- (void)switchToWhichNotifyMode:(ChatRoomNotifyMode)notifyMode withJson:(NSDictionary *)json
//{
//    switch (notifyMode)
//    {
//            /******************************************
//             ************ Action Part.*****************
//             ******************************************/
//        case kChatNofityModeNone:
//            [self chatNofityModeNone:json];
//            break;
//        case kActionRoomChangeMode:
//            [self actionRoomChangeMode:json];
//            break;
//        case kActionMeRoomChangeMode:
//            [self actionMeRoomChangeMode:json];
//            break;
//        case kActionRoomStarMode:
//            [self actionRoomStarMode:json];
//            break;
//        case kActionManageKickMode:
//            [self actionManageKickMode:json];
//            break;
//        case kActionManageMeKickMode:
//            [self actionManageMeKickMode:json];
//            break;
//        case kActionManageShutupMode:
//            [self actionManageShutupMode:json];
//            break;
//        case kActionManageMeShutupMode:
//            [self actionManageMeShutupMode:json];
//            break;
//        case kActionMessageBroadcastMode:
//            [self actionMessageBroadcastMode:json];
//            break;
//        case kActionUserInfoMode:
//            [self actionUserInfoMode:json];
//            break;
//        case kActionLiveRankMode:
//            [self actionLiveRankMode:json];
//            break;
//        case kActionGiftNotifyMode:
//            [self actionGiftNotifyMode:json];
//            break;
//        case kActionGiftNotifyFromMeMode:
//            [self actionGiftFromMeNotifyMode:json];
//            break;
//        case kActionGiftNotifyToMeMode:
//            [self actionGiftToMeNotifyMode:json];
//            break;
//        case kActionGiftFeatherMode:
//            [self actionGiftFeatherMode:json];
//            break;
//        case kActionGiftFeatherFromMeMode:
//            [self actionGiftFeatherFromMeMode:json];
//            break;
//        case kActionSystemNoticeMode:
//            [self actionSystemNoticeMode:json];
//            break;
//        case kActionGiftMarqueeMode:
//            [self actionGiftMarqueeMode:json];
//            break;
//        case kActionLiveStatusMode:
//            [self actionLiveStatusMode:json];
//            break;
//        case kActionSofaListMode:
//            [self actionSofaListMode:json];
//            break;
//        case kActionPuzzleBeginMode:
//            [self actionPuzzleBeginMode:json];
//            break;
//        case kActionPuzzleWinMode:
//            [self actionPuzzleWinMode:json];
//            break;
//            /******************************************
//             ************ Chat Part.*******************
//             ******************************************/
//        case kRoomChatMeToAllMode:
//            [self roomChatMeToAllMode:json];
//            break;
//        case kRoomChatMeToOneMode:
//            [self roomChatMeToOneMode:json];
//            break;
//        case kRoomChatMeToOnePrivateMode:
//            [self roomChatMeToOnePrivateMode:json];
//            break;
//        case kRoomChatOneToAllMode:
//            [self roomChatOneToAllMode:json];
//            break;
//        case kRoomChatOneToOneMode:
//            [self roomChatOneToOneMode:json];
//            break;
//        case kRoomChatOneToOnePrivateMode:
//            [self roomChatOneToOnePrivateMode:json];
//            break;
//        case kRoomChatOneToMeMode:
//            [self roomChatOneToMeMode:json];
//            break;
//        case kRoomChatOneToMePrivateMode:
//            [self roomChatOneToMePrivateMode:json];
//            break;
//        default:
//            [self chatNofityModeNone:json];
//            break;
//    }
//}


@end
