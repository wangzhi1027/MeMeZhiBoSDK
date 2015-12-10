//
//  RoomVideoViewController+UserPanel.m
//  memezhibo
//
//  Created by Xingai on 15/6/15.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "RoomVideoViewController+UserPanel.h"
#import "RoomVideoViewController+Delegate.h"
#import "RoomVideoViewController+Gift.h"
#import "RoomVideoViewController+Keyboard.h"
#import "RoomVideoViewController+ChatField.h"
#import "TTShowRemote+Live.h"

@implementation RoomVideoViewController (UserPanel)

- (void)doSelectUserPanel:(NSInteger)userID vipHiding:(BOOL)isVipHidding
{
    if (isVipHidding) {
        return;
    }
    if (!self.dataManager.global.isUserlogin)
    {
        [self showLoginTipActionSheet];
        return;
    }
    
    [self setupUserPanel];
    
    self.userPanel.userID = userID;
    [self.userPanel retrieveUserInfo];
}

- (void)setupUserPanel
{
    if (!self.bgView) {
        self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        self.bgView.backgroundColor = kRGB(88, 80, 80);
        self.bgView.alpha = 0.98;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bgViewhandleTap:)];
        [self.bgView addGestureRecognizer:tapGesture];
        [self.view addSubview:self.bgView];
        
    }else{
        self.bgView.hidden = NO;
    }
    if (!self.userPanel) {
        self.userPanel = [[UserPanelViewController alloc] init];
        self.userPanel.delegate = self;
        self.userPanel.view.frame = CGRectMake(kScreenWidth/2-130, kScreenHeight/2-145, 260, 287);
        [self.view addSubview:self.userPanel.view];
    } else {
        [UIView animateWithDuration:0.5 animations:^{
            self.userPanel.view.alpha = 0.9;
            [self.keyboard.textField resignFirstResponder];
        }];
    }
    
    if (!self.outBtn) {
        self.outBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.outBtn.frame = CGRectMake(kScreenWidth/2-13, self.userPanel.view.frame.origin.y+self.userPanel.view.frame.size.height+60, 26, 26);
        [self.outBtn setImage:kImageNamed(@"我的_关闭未按下") forState:UIControlStateNormal];
        [self.outBtn addTarget:self action:@selector(outBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.bgView addSubview:self.outBtn];
    }else{
        self.outBtn.hidden = NO;
        self.outBtn.frame = CGRectMake(kScreenWidth/2-13, self.userPanel.view.frame.origin.y+self.userPanel.view.frame.size.height+60, 26, 26);
    }
}

#pragma mark - UserPanelDelegate

- (void)userpaneldidSelectRowAtIndexPath:(NSIndexPath *)indexPath user:(TTShowUser *)user
{
    self.bgView.hidden = YES;
    switch (indexPath.row)
    {
        case 0:
        {
            // public chat.
            self.mChatPrivateValue = NO;
            self.keyboard.whisperBtn.selected = self.mChatPrivateValue;
            // Chat To Whom?
            TTShowChatTarget *target = [TTShowChatTarget dictionaryWithCapacity:0];
            [target setValue:user.nick_name forKey:kChatTargetNickNameKey];
            [target setValue:@(user._id) forKey:kChatTargetIDKey];
            [self joinChatTargets:target];
        }
            break;
        case 1:
        {
            if (![self meCanPrivateChat]) {
                return;
            }
            self.mChatPrivateValue = YES;
            self.keyboard.whisperBtn.selected = self.mChatPrivateValue;
            
            // Chat To Whom with private method?
            TTShowChatTarget *target = [TTShowChatTarget dictionaryWithCapacity:0];
            [target setValue:user.nick_name forKey:kChatTargetNickNameKey];
            [target setValue:@(user._id) forKey:kChatTargetIDKey];
            [self joinChatTargets:target];
            
            self.qqhD = user.nick_name;
        }
            break;
        case 2:
        {
            TTShowChatTarget *target = [TTShowChatTarget dictionaryWithCapacity:0];
            [target setValue:user.nick_name forKey:kChatTargetNickNameKey];
            [target setValue:@(user._id) forKey:kChatTargetIDKey];
            
            // gift receives's count has max value.
            [self filterChatTargets:target];
            
            // Show Gift List View.
            [self setupGiftReceiverID:user._id];
            [self setupGiftReceiver:user.nick_name];

            self.giftController.chatTargets = self.chatTargets;

            [self giftListShow];
            
        }
            break;
        case 3:
        {
            if (user._id == self.currentRoomStar._id || [self roomOneIsAdmin:user._id] || self.currentAudience.vip == 1)
            {
                [UIAlertView showInfoMessage:@"权限不足"];
                return;
            }
            
            
            self.currentAudience = nil;
            self.currentAudience = [[TTShowAudience alloc] initWithUser:user];
            
            [self showAudienceActionSheet];
        }
            break;
        case 4:
        {
            if (user._id == self.currentRoomStar._id || [self roomOneIsAdmin:user._id] || self.currentAudience.vip == 1)
            {
                [UIAlertView showInfoMessage:@"权限不足"];
                return;
            }
            
            
            self.currentAudience = nil;
            self.currentAudience = [[TTShowAudience alloc] initWithUser:user];
            
            [self cancelShutupOneAudience];
        }
            break;
        default:
            break;
    }
    
    [UIView animateWithDuration:0.5 animations:^{
        self.userPanel.view.alpha = 0.0;
        [self.keyboard.textField resignFirstResponder];
    }];
}

//恢复禁言
- (void)cancelShutupOneAudience
{
    if (!self.currentAudience)
    {
        return;
    }
    if(self.currentAudience.vip == 1){
        [UIAlertView showInfoMessage:@"权限不足"];
        return;
    }
    
    [self.dataManager.remote _manageOrderRecoverUser:self.currentAudience._id
                                             inRoom:self.currentRoom._id
                                         completion:^(BOOL success, NSError *error) {
                                             if (!error)
                                             {
                                                 [self.uiManager.global showMessage:@"恢复禁言成功" in:self disappearAfter:0.8f];
                                             }
                                             else
                                             {
                                                 [UIAlertView showInfoMessage:[error localizedDescription]];
                                             }
                                         }];
}

//添加@对象
- (void)joinChatTargets:(TTShowChatTarget *)target
{
    // existed?
    for (TTShowChatTarget *t in self.chatTargets)
    {
        if ([t isEqualToDictionary:target])
        {
            // set as current chat target.
            self.mChatTargetValue = target;
            //            [self.chatTargetButton setTitle:[target valueForKey:kChatTargetNickNameKey] forState:UIControlStateNormal];
            self.keyboard.textField.placeholder = [NSString stringWithFormat:@"%@%@%@", self.mChatPrivateValue ? kChatCommonWordWhisper : kChatCommonWordTo, [target valueForKey:kChatTargetNickNameKey], kChatCommonWordSay];
            return;
        }
    }
    
    [self filterChatTargets:target];

    self.mChatTargetValue = target;
    
    self.keyboard.textField.placeholder = [NSString stringWithFormat:@"%@%@%@", self.mChatPrivateValue ? kChatCommonWordWhisper : kChatCommonWordTo, [target valueForKey:kChatTargetNickNameKey], kChatCommonWordSay];
}

- (void)filterChatTargets:(TTShowChatTarget *)target
{
    if (!target || !self.chatTargets)
    {
        return;
    }
    
    if (self.chatTargets.count > 4)
    {
        // Because first one is default(room star). remove from second element.
        [self.chatTargets removeObjectAtIndex:4];
    }
    
    BOOL existTarget = NO;
    for (TTShowChatTarget *t in self.chatTargets)
    {
        NSInteger targetID = [[t valueForKey:kChatTargetIDKey] integerValue];
        NSInteger willTargetID = [[target valueForKey:kChatTargetIDKey] integerValue];
        if (targetID == willTargetID)
        {
            existTarget = YES;
            break;
        }
    }
    
    if (!existTarget)
    {
        [self.chatTargets addObject:target];
    }
}


@end
