//
//  RoomVideoViewController+Delegate.m
//  memezhibo
//
//  Created by Xingai on 15/6/8.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "RoomVideoViewController+Delegate.h"
#import "RoomVideoViewController+Timer.h"
#import "RoomVideoViewController+Keyboard.h"
#import "TTShowRemote+System.h"
#import "TTShowRemote+Live.h"
#import "RoomVideoViewController+UserPanel.h"
#import "UITextField+Extend.h"
#import "RankListDetailsViewController.h"

@implementation RoomVideoViewController (Delegate)

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (self.empScroll==scrollView) {
        NSInteger page = scrollView.contentOffset.x/kScreenWidth+kTempTag;
        
        
        for (SegmentBtnView *seg in [self.segView subviews]) {
            if (seg.tag != page) {
                seg.segmentLabel.textColor = kWhiteColor;
            }
            else
            {
                seg.segmentLabel.textColor = kNavigationMainColor;
            }
            seg.image.hidden = YES;
        }
        __weak __typeof(self) weakSelf = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            @autoreleasepool
            {
                if (page==kTempTag&&self.chatHistoryPublicArray.count!=0) {
                    self.isMymessage = NO;
                    [weakSelf.messageTable reloadData];
                }
                if (page==(kTempTag+1)) {
                    self.isMymessage = YES;
                    [weakSelf.MyMessageTable reloadData];
                }
            }
        });
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.keyboard.textField resignFirstResponder];
    [self.giftController.gifttextView.giftNumberFild resignFirstResponder];
    if (self.messageTable == tableView) {
        [self.messageTable deselectRowAtIndexPath:indexPath animated:YES];
        if (indexPath.row >= self.chatHistoryPublicArray.count)
        {
            return;
        }
        
        [UIView animateWithDuration:0.5 animations:^{
            self.andWhoView.alpha = 0.0;
        }];
        
        NSDictionary *dictionary = [self.chatHistoryPublicArray objectAtIndex:indexPath.row];
        ChatRoomNotifyMode mode = [[dictionary valueForKey:kChatHistoryModeKey] unsignedIntegerValue];
        
        switch (mode)
        {
            case kActionRoomChangeMode:
                [self actionRoomChange:dictionary];
                break;
            case kActionMeRoomChangeMode:
                [self actionMeRoomChange:dictionary];
                break;
            case kRoomChatMeToAllMode:
                [self roomChatMeToAll:dictionary];
                break;
            case kRoomChatOneToAllMode:
                [self roomChatOneToAll:dictionary];
                break;
            case kRoomChatMeToOneMode:
                [self roomChatMeToOne:dictionary];
                break;
            case kRoomChatOneToOneMode:
                [self roomChatOneToOne:dictionary];
                break;
            case kRoomChatMeToOnePrivateMode:
                [self roomChatMeToOnePrivate:dictionary];
                break;
            case kRoomChatOneToOnePrivateMode:
                [self roomChatOneToOnePrivate:dictionary];
                break;
            case kRoomChatOneToMeMode:
                [self roomChatOneToMe:dictionary];
                break;
            case kRoomChatOneToMePrivateMode:
                [self roomChatOneToMePrivate:dictionary];
                break;
            case kActionGiftNotifyMode:
                [self roomChatOneToOne:dictionary];
                break;
            case kActionGiftNotifyFromMeMode:
                [self roomChatMeToOne:dictionary];
                break;
            case kActionGiftNotifyToMeMode:
                [self roomChatOneToMe:dictionary];
                break;
            case kActionGiftFeatherMode:
                [self roomChatOneToOne:dictionary];
                break;
            case kActionGiftFeatherFromMeMode:
                [self roomChatMeToOne:dictionary];
                break;
            case kActionMessageBroadcastMode:
                [self actionMessageBroadcast:dictionary];
                break;
            case kDefaultAnnounceChargeMode:
                [self chargeFromDefaultAnnounce];
                break;
            case kDefaultAnnounceOfficialWebsiteMode:
                [self enterOfficialWebFromDefaultAnnounce];
                break;
            default:
                break;
        }

    }
    
    if (self.MyMessageTable == tableView) {
        [self.MyMessageTable deselectRowAtIndexPath:indexPath animated:YES];
        
        
        
        if (indexPath.row >= self.chatHistroyPrivateArray.count)
        {
            return;
        }
        
        NSDictionary *dictionary = [self.chatHistroyPrivateArray objectAtIndex:indexPath.row];
        ChatRoomNotifyMode mode = [[dictionary valueForKey:kChatHistoryModeKey] unsignedIntegerValue];
        
        switch (mode)
        {
            case kActionRoomChangeMode:
                [self actionRoomChange:dictionary];
                break;
            case kActionMeRoomChangeMode:
                [self actionMeRoomChange:dictionary];
                break;
            case kRoomChatMeToAllMode:
                [self roomChatMeToAll:dictionary];
                break;
            case kRoomChatOneToAllMode:
                [self roomChatOneToAll:dictionary];
                break;
            case kRoomChatMeToOneMode:
                [self roomChatMeToOne:dictionary];
                break;
            case kRoomChatOneToOneMode:
                [self roomChatOneToOne:dictionary];
                break;
            case kRoomChatMeToOnePrivateMode:
                [self roomChatMeToOnePrivate:dictionary];
                break;
            case kRoomChatOneToOnePrivateMode:
                [self roomChatOneToOnePrivate:dictionary];
                break;
            case kRoomChatOneToMeMode:
                [self roomChatOneToMe:dictionary];
                break;
            case kRoomChatOneToMePrivateMode:
                [self roomChatOneToMePrivate:dictionary];
                break;
            case kActionGiftNotifyMode:
                [self roomChatOneToOne:dictionary];
                break;
            case kActionGiftNotifyFromMeMode:
                [self roomChatMeToOne:dictionary];
                break;
            case kActionGiftNotifyToMeMode:
                [self roomChatOneToMe:dictionary];
                break;
            case kActionGiftFeatherMode:
                [self roomChatOneToOne:dictionary];
                break;
            case kActionGiftFeatherFromMeMode:
                [self roomChatMeToOne:dictionary];
                break;
            case kActionMessageBroadcastMode:
                [self actionMessageBroadcast:dictionary];
                break;
            case kDefaultAnnounceChargeMode:
                [self chargeFromDefaultAnnounce];
                break;
            case kDefaultAnnounceOfficialWebsiteMode:
                [self enterOfficialWebFromDefaultAnnounce];
                break;
            default:
                break;
        }
    }

    
    if (self.giftrankingTable == tableView) {
        [self.giftrankingTable deselectRowAtIndexPath:indexPath animated:YES];
        switch (indexPath.section) {
            case 0:
            {
                RankListDetailsViewController *rankDetail = [[RankListDetailsViewController alloc] init];
                rankDetail.navTitle = @"粉丝";
                rankDetail.flag = 2;
                rankDetail.currentRoom = self.currentRoom;
                [[UIApplication sharedApplication] setStatusBarHidden:NO];
                
                [self.navigationController pushViewController:rankDetail animated:YES];
            }
                break;
            case 1:
            {
                if (indexPath.row < self.giftRankingList.count)
                {
                    TTShowAudience *audience = self.giftRankingList[indexPath.row];
                    
                    NSMutableDictionary *mDic = [NSMutableDictionary dictionaryWithCapacity:0];
                    [mDic setObject:@(audience._id) forKey:kChatHistoryUserIDKey];
                    [mDic setObject:@(audience._id) forKey:kChatHistoryVIPHiddingKey];
                    
                    
                    [self doSelectUserPanel:audience._id vipHiding:NO];
//                    [self showAudienceAction:audience];
                }
                
                [tableView deselectRowAtIndexPath:indexPath animated:YES];
            }
                break;
        }
    }
    
}

#pragma mark - public part.

- (void)showChatTargetActionSheet:(NSString *)from To:(NSString *)to
{
    UIActionSheet *as = [[UIActionSheet alloc] initWithTitle:@"用户信息" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:from, to, nil];
    as.tag = kChatActionSheetChooseTarget;
    [as showInView:self.navigationController.view];
}

- (void)showLoginTipActionSheet
{
    UIActionSheet *as = [[UIActionSheet alloc] initWithTitle:@"请登录后操作" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"登录", nil];
    as.tag = kChatActionSheetLoginTip;
    [as showInView:self.navigationController.view];
}

- (void)showReportActionSheet
{

    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.isHideNavigation = !self.isHideNavigation;
    
    if (!self.bgView) {
        self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        self.bgView.backgroundColor = kRGB(88, 80, 80);
        self.bgView.alpha = 0.9;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bgViewhandleTap:)];
        [self.bgView addGestureRecognizer:tapGesture];
        [self.view addSubview:self.bgView];
    }else{
        self.bgView.hidden = NO;
    }
    if (!self.alertView) {
        
        self.alertView = [[ReportAlertview alloc] init];
        self.alertView.delegate = self;
        self.alertView.frame = CGRectMake(kScreenWidth/2-130, kScreenHeight/2-60, 260, 120);
        [self.view addSubview:self.alertView];
    }else{
        self.alertView.hidden = NO;
    }
    
}

- (void)showAudienceActionSheet
{
    UIActionSheet *as = [[UIActionSheet alloc] initWithTitle:@"管理观众列表" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"禁言", nil];
    as.tag = kChatActionSheetAudience;
    [as showInView:self.navigationController.view];
}

- (void)showShutupTimeActionSheet
{
    if (!self.currentAudience)
    {
        return;
    }
    
    NSString *title = [NSString stringWithFormat:@"对 %@ 禁言", self.currentAudience.nick_name];
    UIActionSheet *as = [[UIActionSheet alloc] initWithTitle:title delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"5分钟", @"1小时", @"12小时", nil];
    as.tag = kChatActionSheetShutup;
    [as showInView:self.navigationController.view];
}

- (void)report:(NSInteger)type
{
    NSString *contact = [NSString stringWithFormat:@"ID:%lu", (unsigned long)self.me._id];
    NSString *content = [NSString stringWithFormat:@"Star ID:%lu %@",
                         (unsigned long)self.currentRoomStar._id,
                         type == kChatReportItem0 ? @"含色情或政治等非法内容" : @"与低俗擦边"];
    
    [self.dataManager.remote _sendSuggestion:contact content:content completion:^(BOOL success, NSError *error) {
        if (success && error == nil)
        {
            [UIAlertView showInfoMessage:@"举报成功"];
        }
    }];
}

- (void)didTouchExpressionView:(TTExpressionKeyboard*)expressionView touchedExpression:(NSString*)string flag:(NSInteger)flag
{
    if (flag>=72&&self.me.vip!=2) {
        [UIAlertView showInfoMessage:@"您还不是紫色VIP,请到网页版么么进行购买哦！"];
        return;
    }
    self.keyboard.textField.text = [NSString stringWithFormat:@"%@%@",self.keyboard.textField.text,string];
}

- (void)didDeleteExpressionView:(TTExpressionKeyboard*)expressionView
{
    [self.keyboard.textField deleteBackwardForExpression];
}

- (void)showAudienceAction:(TTShowAudience *)audience
{
    // Login Tips.
    if (!self.dataManager.global.isUserlogin)
    {
        [self showLoginTipActionSheet];
        return;
    }
    
    //
    
    if (audience == nil)
    {
        return;
    }
    
    self.currentAudience = audience;
    
    [self showAudienceActionSheet];
}

- (void)shutupOneAudience
{
    if (!self.currentAudience)
    {
        return;
    }
    if(self.currentAudience.vip == 1){
        [UIAlertView showInfoMessage:@"权限不足"];
        return;
    }
    
    
    [self.dataManager.remote _manageOrderShutup:self.curShutupMinute
                                        toUser:self.currentAudience._id
                                        inRoom:self.currentRoom._id
                                    completion:^(BOOL success, NSError *error) {
                                        if (!error)
                                        {
                                            [self.uiManager.global showMessage:@"禁言成功" in:self disappearAfter:0.8f];
                                        }
                                        else
                                        {
                                            [UIAlertView showInfoMessage:[error localizedDescription]];
                                        }
                                    }];
}



- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (actionSheet.tag)
    {
        case kChatActionSheetChooseTarget:
        {
            switch (buttonIndex)
            {
                case kChatTargetTypeFrom:
                    // From
                    [self addChatFromPerson:self.chatTargetDict];
                    break;
                case kChatTargetTypeTo:
                    // To
                    [self addChatToPerson:self.chatTargetDict];
                    break;
                default:
                    break;
            }
        }
            break;
        case kChatActionSheetLoginTip:
        {
            switch (buttonIndex)
            {
                case kChatLoginTipLogin:
                {
                    //TODO...暂时屏蔽登陆页面
                    /*
                    MoreLogInViewController *more = [[MoreLogInViewController alloc] init];
                    more.flag = 2;
                    [[UIApplication sharedApplication] setStatusBarHidden:NO];
                    
                    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:more];
                    
                    [[UIApplication sharedApplication] endReceivingRemoteControlEvents];

                    [self presentViewController:nav animated:YES completion:^{
                        
                    }];
                     */
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
        case kChatActionSheetReport:
        {
            if (buttonIndex != kChatReportItemCancel)
            {
                [self report:buttonIndex];
            }
        }
            break;
        case kChatActionSheetAudience:
        {
            switch (buttonIndex)
            {
                case kAudienceShutupASItem:
                {
                    [self showShutupTimeActionSheet];
                }
                    break;
                case kAudienceCancelASItem:
                    
                    break;
                    
                default:
                    break;
            }
        }
            break;
            
        case kChatActionSheetShutup:
        {
            switch (buttonIndex)
            {
                case kShutup5MinutesASItem:
                case kShutup1HourASItem:
                case kShutup12HoursASItem:
                {
                    if (buttonIndex < self.shutupMinutes.count)
                    {
                        self.curShutupMinute = [self.shutupMinutes[buttonIndex] integerValue];
                        [self shutupOneAudience];
                    }
                }
                    break;
                case kShutupCancelASItem:
                    
                    break;
                    
                default:
                    break;
            }
        }
            break;
        default:
            break;
    }
}

#pragma mark - event part.

- (void)addChatFromPerson:(NSDictionary *)dict
{
    // show user panel.
    NSUInteger userID = [[dict valueForKey:kChatHistoryFromUserIDKey] unsignedIntegerValue];
    BOOL isVipHidding = [[dict valueForKey:kChatHistoryVIPHiddingKey] boolValue];
    [self doSelectUserPanel:userID vipHiding:isVipHidding];
}

- (void)addChatToPerson:(NSDictionary *)dict
{
    // show user panel.
    NSUInteger userID = [[dict valueForKey:kChatHistoryToUserIDKey] unsignedIntegerValue];
    BOOL isVipHidding = [[dict valueForKey:kChatHistoryVIPHiddingKey] boolValue];
    [self doSelectUserPanel:userID vipHiding:isVipHidding];
}

- (void)addChatRoomChangePersion:(NSDictionary *)dict
{
    // show user panel.
    NSUInteger userID = [[dict valueForKey:kChatHistoryUserIDKey] unsignedIntegerValue];
    BOOL isVipHidding = [[dict valueForKey:kChatHistoryVIPHiddingKey] boolValue];
    [self doSelectUserPanel:userID vipHiding:isVipHidding];
}


- (void)actionRoomChange:(NSDictionary *)dict
{
    [self addChatRoomChangePersion:dict];
}

- (void)actionMeRoomChange:(NSDictionary *)dict
{
    [UIAlertView showInfoMessage:@"不能对自己聊天"];
}

- (void)roomChatMeToAll:(NSDictionary *)dict
{
    [UIAlertView showInfoMessage:@"不能对自己聊天"];
}

- (void)roomChatOneToAll:(NSDictionary *)dict
{
    [self addChatFromPerson:dict];
}

- (void)roomChatMeToOne:(NSDictionary *)dict
{
    [self addChatToPerson:dict];
}

- (void)roomChatMeToOnePrivate:(NSDictionary *)dict
{
    [self addChatToPerson:dict];
}

- (void)roomChatOneToMe:(NSDictionary *)dict
{
    [self addChatFromPerson:dict];
}

- (void)roomChatOneToMePrivate:(NSDictionary *)dict
{
    [self addChatFromPerson:dict];
}

- (void)roomChatOneToOne:(NSDictionary *)dict
{
    self.chatTargetDict = dict;
    
    NSString *nickNameFromText = [dict valueForKey:kChatHistoryNickNameFromKey];
    NSString *nickNameToText = [dict valueForKey:kChatHistoryNickNameToKey];
    
//        UIActionSheet *as = [[UIActionSheet alloc] initWithTitle:@"聊天" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:nickNameFromText, nickNameToText, nil];
//        as.tag = kChatActionSheetChooseTarget;
//        [as showInView:self.navigationController.view];
    
    [self showChatTargetActionSheet:nickNameFromText To:nickNameToText];
    
}

- (void)roomChatOneToOnePrivate:(NSDictionary *)dict
{
    self.chatTargetDict = dict;
    
    NSString *nickNameFromText = [dict valueForKey:kChatHistoryNickNameFromKey];
    NSString *nickNameToText = [dict valueForKey:kChatHistoryNickNameToKey];
    
    //    UIActionSheet *as = [[UIActionSheet alloc] initWithTitle:@"聊天" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:nickNameFromText, nickNameToText, nil];
    //    as.tag = kChatActionSheetChooseTarget;
    //    [as showInView:self.navigationController.view];
    [self showChatTargetActionSheet:nickNameFromText To:nickNameToText];
}

- (void)actionMessageBroadcast:(NSDictionary *)dict
{
    
}

-(void)chargeFromDefaultAnnounceRoom
{
    [self chargeFromDefaultAnnounce];
}

- (void)chargeFromDefaultAnnounce
{
    if (!self.dataManager.global.isUserlogin)
    {
        [self showLoginTipActionSheet];
    } else {
        [self.uiManager showChargeUI:self];
    }
}

- (void)enterOfficialWebFromDefaultAnnounce
{
}

#pragma ReportAlertviewDelegate
-(void)cancel
{
    self.alertView.hidden= YES;
    self.bgView.hidden = YES;
}

-(void)Dial
{
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",@"021-54392351"];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];
}

@end
