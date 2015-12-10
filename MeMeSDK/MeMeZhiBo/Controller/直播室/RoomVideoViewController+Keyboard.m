//
//  RoomVideoViewController+Keyboard.m
//  memezhibo
//
//  Created by Xingai on 15/6/9.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "RoomVideoViewController+Keyboard.h"
#import "RoomGiftViewController+Delegate.h"
#import "RoomVideoViewController+Delegate.h"
#import "RoomVideoViewController+Chat.h"
#import "RoomVideoViewController+Remote.h"
#import "RoominfoHead.h"
#import "RoomVideoViewController+Timer.h"
#import "RoomVideoViewController+Video.h"
#import "RoomVideoViewController+Socket.h"
#import "RoomVideoViewController+Remote.h"
#import "RoomVideoViewController+Gift.h"


#define kUserLevel_0ChatContentLengthMax        (10)
#define kUserLevel_1ChatContentLengthMax        (50)
#define kUserLevel_2_3ChatContentLengthMax      (70)
#define kUserLevel_Greater4ChatContentLengthMax (100)

@implementation RoomVideoViewController (Keyboard)

#pragma mark - Notification

- (void)registerKeyboardNotification
{
    [kNotificationCenter addObserver:self selector:@selector(showKeyBoard:) name:UIKeyboardWillShowNotification object:nil];
    [kNotificationCenter addObserver:self selector:@selector(hideKeyBoard:) name:UIKeyboardWillHideNotification object:nil];
    [kNotificationCenter addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    [kNotificationCenter addObserver:self selector:@selector(updateUserInformation:) name:kNotificationUpdateUser object:nil];
    
    
    
    
    
}

- (void)unregisterKeyboardNotification
{
    [kNotificationCenter removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [kNotificationCenter removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [kNotificationCenter removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
    [kNotificationCenter removeObserver:self name:kNotificationUpdateUser object:nil];
}

#pragma mark - Event part.

- (void)updateUserInformation:(NSNotification *)notification
{
    [self retrieveUserInfo];
}

- (void)showKeyBoard:(NSNotification *)sender
{
    NSDictionary *info = [sender userInfo];
    CGSize kEndSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    if (self.GiftViewShow) {
        [UIView animateWithDuration:0.25f animations:^{
            self.giftController.gifttextView.frame = CGRectMake(0, self.giftController.view.frame.size.height-kEndSize.height-50, kScreenWidth, 50);
        }];
    }else{
    
        [UIView animateWithDuration:0.25 animations:^{
            self.keyboard.frame = CGRectMake(0, kScreenHeight-80-kEndSize.height, kScreenWidth, 80);
            self.emptyView.frame = CGRectMake(0, -36, kScreenWidth, kScreenHeight-self.keyboard.frame.origin.y+36);
            self.empScroll.frame = CGRectMake(0, 0, kScreenWidth, self.keyboard.frame.origin.y+36);
            self.messageTable.frame = CGRectMake(0, 36, kScreenWidth, self.keyboard.frame.origin.y);
            self.MyMessageTable.frame = CGRectMake(kScreenWidth, 36, kScreenWidth, self.keyboard.frame.origin.y);
            self.giftrankingTable.frame = CGRectMake(2*kScreenWidth, 36, kScreenWidth, self.keyboard.frame.origin.y);
            self.downBtn.frame = CGRectMake(kScreenWidth/2-26, self.keyboard.frame.origin.y-26, 53, 26);
            self.expressionKeyboard.frame = CGRectMake(0, kScreenHeight, kScreenWidth, kExpressionKeyboardHeght);
            self.downBtn.alpha = 1.0f;
            if (self.userPanel) {
                self.userPanel.view.alpha = 0.0f;
            }
        } completion:^(BOOL finished) {
            if (finished)
            {
                //            [self resetPopViewFrame];
            }
        }];
    }
}

- (void)hideKeyBoard:(NSNotification *)sender
{
    [UIView animateWithDuration:0.25 animations:^{
        self.keyboard.frame = CGRectMake(0, kScreenHeight-44, kScreenWidth, 80);
        self.emptyView.frame = CGRectMake(0, 240*kRatio, kScreenWidth, kScreenHeight-240*kRatio);
        self.empScroll.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight-240*kRatio-44);
        self.messageTable.frame = CGRectMake(0, 36.0f, kScreenWidth, kScreenHeight-44.0f-240*kRatio-36.0f);
        self.MyMessageTable.frame = CGRectMake(kScreenWidth, 36.0f, kScreenWidth, kScreenHeight-44.0f-240*kRatio-36.0f);
        self.giftrankingTable.frame = CGRectMake(kScreenWidth*2, 36.0f, kScreenWidth, kScreenHeight-44.0f-240*kRatio-36.0f);
        self.expressionKeyboard.frame = CGRectMake(0, kScreenHeight, kScreenWidth, kExpressionKeyboardHeght);
        self.downBtn.frame = CGRectMake(kScreenWidth/2-26, self.keyboard.frame.origin.y-26, 53, 26);
        self.downBtn.alpha = 0.0f;
        self.giftController.gifttextView.frame = CGRectMake(0, 122+240*kRatio-50, kScreenWidth, 50);
        
    }];
    
}

-(void)giveIsOk
{
//    self.giftTextView.giftNumberFild.text = @"";
    
    self.GiftViewShow = NO;
    if ([self.dataManager.global isUserlogin]!=1) {
        [self showLoginTipActionSheet];
        return;
    }
    
    [UIView animateWithDuration:0.5 animations:^{
        self.giftController.view.frame = CGRectMake(0.0f, kScreenHeight, kScreenWidth, 122+240*kRatio);
        
    }];
    
    [self.giftController.gifttextView.giftNumberFild resignFirstResponder];
}

-(void)keyboardWillChangeFrame:(NSNotification *)sender
{
    
}



#pragma textFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if (self.keyboard.textField==textField)
    {
        if (![self.keyboard.textField.text isEqual:@""]) {
            [self sendMessage:self.keyboard.textField.text];
        }else{
            [[UIGlobalKit sharedInstance] showMessage:@"请输入内容" in:self disappearAfter:0.5f];
        }
    }
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string

{
    
    NSString *text = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    
    if ([text isEqual:@""]) {
        [self.keyboard.sendBtn setBackgroundImage:[kImageNamed(@"赠送按钮未激活") stretchableImageWithLeftCapWidth:15 topCapHeight:15] forState:UIControlStateNormal];
    }else{
        [self.keyboard.sendBtn setBackgroundImage:[kImageNamed(@"赠送按钮激活@2x") stretchableImageWithLeftCapWidth:15 topCapHeight:15] forState:UIControlStateNormal];
    }

    return YES;
    
}

-(void)sendBtnDelegate:(id)sender
{
    [self.keyboard.textField resignFirstResponder];
    if (![self.keyboard.textField.text isEqual:@""]) {
        [self sendMessage:self.keyboard.textField.text];
    }
    [self hideKeyBoard:nil];
    if (self.andWhoView&&self.andWhoView.alpha) {
        [UIView animateWithDuration:0.5 animations:^{
            self.andWhoView.alpha = 0.0;
        }];
    }
}



- (void)sendMessage:(NSString *)content
{
    
    // Login Tips.
    if (!self.dataManager.global.isUserlogin)
    {
        [self showLoginTipActionSheet];
        return;
    }
    
    if (![self validLengthContent:content])
    {
//        [self clearContent];
//        [self hideKeyboardAfterChatting];
        return;
    }
    
    if (self.lastSendTime != nil)
    {
        TTShowUser *user = [TTShowUser unarchiveUser];
        Finance *finance = [[Finance alloc] initWithAttributes:user.finance];
        
        NSInteger userLevel= [self.dataManager wealthLevel:finance.coin_spend_total];
        
        if(userLevel < 3)
        {
            NSDate *curDate = [NSDate date];
            NSTimeInterval interval = [curDate timeIntervalSinceDate:self.lastSendTime];
            
            if(userLevel < 1)
            {
                if(interval < 30)
                {
                    [self.uiManager.global showMessage:@"布衣用户的发言间隔为30秒，请稍后再试！" in:self disappearAfter:2.0f];
                    return;
                }
            }else if(userLevel == 1)
            {
                if(interval < 10)
                {
                    [self.uiManager.global showMessage:@"一富用户的发言间隔为10秒，请稍后再试！" in:self disappearAfter:2.0f];
                    return;
                }
            }else if(userLevel == 2)
            {
                if(interval < 5)
                {
                    [self.uiManager.global showMessage:@"二富用户的发言间隔为5秒，请稍后再试！" in:self disappearAfter:2.0f];
                    return;
                }
            }
        }
        
    }
    
    self.lastSendTime = [NSDate date];
    
    
    content = [self filterSensitiveWords:content];
    
    // firstly check whether you are shut up?
    [self.dataManager.remote retrieveShutupTtl:self.currentRoom._id completion:^(NSInteger count, NSError *error) {
        if (error == nil)
        {
            if (count > 0)
            {
                [UIAlertView showInfoMessage:[NSString stringWithFormat:@"你已被禁言%ld秒", (long)count]];
                return;
            }
            else
            {
                if (self.socketIO != nil && [self.socketIO isConnected])
                {
                    if (self.mChatPrivateValue) {
                        NSString *nick_name = self.me.nick_name;
                        NSString *nick_nameTo = self.qqhD;
                        NSDictionary *dic = @{@"from":(@{@"nick_name":nick_name}),@"content":content,@"to":(@{@"nick_name":nick_nameTo})};
                        [self oneToOne:dic isFromMe:YES isToMe:NO isPrivate:self.mChatPrivateValue mode:kRoomChatMeToOnePrivateMode];
                        [self updateChatHistoryUI];
                    }
                    NSString *sendMessage = [NSDictionary getChatStringTarget:self.mChatTargetValue Private:self.mChatPrivateValue Content:content];
                    [self.socketIO sendMessage:sendMessage];
                }
                
                if (self.keyboard.textField != nil)
                {
                    [self.keyboard.textField setText:@""];
                    [self.keyboard.sendBtn setBackgroundImage:kImageNamed(@"赠送按钮未激活") forState:UIControlStateNormal];
                }
                
            }
        }
    }];
}

- (NSString *)filterSensitiveWords:(NSString *)content
{
    if (content) {
//        NSArray *sensitiveWords = [Cache getSensitiveWords];
//        if (sensitiveWords.count > 0) {
//            for (NSString *word in sensitiveWords) {
//                @autoreleasepool
//                {
//                    content = [content stringByReplacingOccurrencesOfString:word withString:@"**"];
//                }
//            }
//        }
        
        if (self.guanjianziList.count>0) {
            for (NSString *str in self.guanjianziList) {
                @autoreleasepool
                {
                    content = [content stringByReplacingOccurrencesOfString:str withString:@"**"];
                }
            }
        }
        
        if (self.guanjianziList1.count>0) {
            for (NSString *str in self.guanjianziList1) {
                @autoreleasepool
                {
                    content = [content stringByReplacingOccurrencesOfString:str withString:@"**"];
                }
            }
        }
    }
    return content;
}

// Limit chat content length.
- (BOOL)validLengthContent:(NSString *)content
{
    NSInteger length = content.length;
    NSInteger weatherLevel = [self.dataManager wealthLevel:[TTShowUser coin_spend_total]];
    BOOL isValidLength = YES;
    NSInteger lengthTip = 0;
    
    //    LOGINFO(@"content's length = %d level = %d", length, weatherLevel);
    
    if (weatherLevel == 0 && length > kUserLevel_0ChatContentLengthMax)
    {
        isValidLength = NO;
        lengthTip = kUserLevel_0ChatContentLengthMax;
    }
    else if (weatherLevel == 1 && length > kUserLevel_1ChatContentLengthMax)
    {
        isValidLength = NO;
        lengthTip = kUserLevel_1ChatContentLengthMax;
    }
    else if (weatherLevel >= 2 && weatherLevel <= 3 && length > kUserLevel_2_3ChatContentLengthMax)
    {
        isValidLength = NO;
        lengthTip = kUserLevel_2_3ChatContentLengthMax;
    }
    else if (weatherLevel >= 4 && length > kUserLevel_Greater4ChatContentLengthMax)
    {
        isValidLength = NO;
        lengthTip = kUserLevel_Greater4ChatContentLengthMax;
    }
    
    if (!isValidLength)
    {
        [UIAlertView showInfoMessage:[NSString stringWithFormat:@"聊天内容长度不能超过%ld", (long)lengthTip]];
    }
    
    return isValidLength;
}

-(void)ExpressionListShow:(id)sender
{
    if (self.keyboard.textField) {
        [self.keyboard.textField resignFirstResponder];
    }
    [UIView animateWithDuration:0.3 animations:^{
        
        self.keyboard.frame = CGRectMake(0, kScreenHeight-kExpressionKeyboardHeght-80, kScreenWidth, 80);
        self.emptyView.frame = CGRectMake(0, -36, kScreenWidth, kScreenHeight-self.keyboard.frame.origin.y+36);
        self.empScroll.frame = CGRectMake(0, 0, kScreenWidth, self.keyboard.frame.origin.y+36);
        self.messageTable.frame = CGRectMake(0, 36, kScreenWidth, self.keyboard.frame.origin.y);
        self.MyMessageTable.frame = CGRectMake(kScreenWidth, 36, kScreenWidth, self.keyboard.frame.origin.y);
        self.giftrankingTable.frame = CGRectMake(2*kScreenWidth, 36, kScreenWidth, self.keyboard.frame.origin.y);
        self.downBtn.frame = CGRectMake(kScreenWidth/2-26, self.keyboard.frame.origin.y-26, 53, 26);
        
        self.downBtn.alpha = 1.0f;
        self.expressionKeyboard.frame = CGRectMake(0, kScreenHeight-kExpressionKeyboardHeght, kScreenWidth, kExpressionKeyboardHeght);
    }];
}

-(void)giftLtstBtnClick:(id)sender
{
    // Login Tips.
    if (!self.dataManager.global.isUserlogin)
    {
        [self showLoginTipActionSheet];
        return;
    }
    
    [self giftListShow];
}

-(void)giftListShow
{
    [self.keyboard.textField resignFirstResponder];
    
    self.GiftViewShow = YES;
    //    [self.view addSubview:self.giftController.view];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.keyboard.frame = CGRectMake(0, kScreenHeight-44, kScreenWidth, 80);
        self.giftController.view.frame = CGRectMake(0.0f, kScreenHeight-(122+240*kRatio), kScreenWidth, 122+240*kRatio);
        self.emptyView.frame = CGRectMake(0, 240*kRatio, kScreenWidth, kScreenHeight-240*kRatio);
        self.empScroll.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight-240*kRatio-44);
        self.messageTable.frame = CGRectMake(0, 36.0f, kScreenWidth, kScreenHeight-44.0f-240*kRatio-36.0f);
        self.MyMessageTable.frame = CGRectMake(kScreenWidth, 36.0f, kScreenWidth, kScreenHeight-44.0f-240*kRatio-36.0f);
        self.giftrankingTable.frame = CGRectMake(kScreenWidth*2, 36.0f, kScreenWidth, kScreenHeight-44.0f-240*kRatio-36.0f);
        self.expressionKeyboard.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 240*kRatio);
        self.downBtn.frame = CGRectMake(kScreenWidth/2-26, self.keyboard.frame.origin.y-26, 53, 26);
        self.downBtn.alpha = 0.0f;
        if (self.userPanel) {
            self.userPanel.view.alpha = 0.0f;
        }
    }completion:^(BOOL finished) {
        finished ? self.giftListDisplay = YES : 0;
    }];
}

-(void)AndWho:(id)sender
{
    if (!self.andWhoView) {
        self.andWhoView = [[AndWhoListView alloc] init];
        self.andWhoView.delegate = self;
        self.andWhoView.frame = CGRectMake(40, self.keyboard.frame.origin.y-44*(self.chatTargets.count+1), 200, 44*(self.chatTargets.count+1)-1);
        
        self.andWhoView.andWhoList = self.chatTargets;
        [self.andWhoView reloadTable];
        
        [self.view addSubview:self.andWhoView];
    }else{
        self.andWhoView.frame = CGRectMake(40, self.keyboard.frame.origin.y-44*(self.chatTargets.count+1), 200, 44*(self.chatTargets.count+1)-1);
        self.andWhoView.andWhoListTable.frame = CGRectMake(0, 0, 200, 44*(self.chatTargets.count+1)-1);
        self.andWhoView.andWhoList = self.chatTargets;
        [self.andWhoView.andWhoListTable reloadData];
        if (self.andWhoView.alpha) {
            [UIView animateWithDuration:0.5 animations:^{
                self.andWhoView.alpha = 0.0;
            }];
        }else{
            [UIView animateWithDuration:0.5 animations:^{
                if (self.userPanel) {
                    self.userPanel.view.alpha = 0.0f;
                }
                self.andWhoView.alpha = 1.0;
            }];
        }
    }
}

-(void)Whisper:(BOOL)selected
{
    if (![self meCanPrivateChat]) {
        return;
    }
    if (self.mChatTargetValue==nil) {
        [UIAlertView showInfoMessage:[NSString stringWithFormat:@"不可以对所有人说悄悄话哦！"]];
        return;
    }
    
    self.keyboard.whisperBtn.selected = !self.keyboard.whisperBtn.selected;
    self.mChatPrivateValue = self.keyboard.whisperBtn.selected;
}

-(void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [UIView animateWithDuration:0.5 animations:^{
        self.andWhoView.alpha = 0.0;
    }];
    [self.andWhoView.andWhoListTable deselectRowAtIndexPath:indexPath animated:YES];
    
    if (!self.dataManager.global.isUserlogin)
    {
        [self showLoginTipActionSheet];
        return;
    }
    
    
    if (indexPath.row < self.chatTargets.count)
    {
        self.mChatTargetValue = self.chatTargets[indexPath.row];
        
        self.keyboard.textField.placeholder = [self.chatTargets[indexPath.row] valueForKey:kChatTargetNickNameKey];
        
        self.qqhD = [self.chatTargets[indexPath.row] valueForKey:kChatTargetNickNameKey];
        
        
    }
    else
    {
        // Set chat target title.
        self.mChatTargetValue = nil;
        self.keyboard.textField.placeholder = [NSString stringWithFormat:@"%@%@%@", kChatCommonWordTo, kChatCommonAll, kChatCommonWordSay];
    }

}

-(void)headImageClick:(id)sender
{
    [self.keyboard.textField resignFirstResponder];
    // Login Tips.
    if (!self.dataManager.global.isUserlogin)
    {
        [self showLoginTipActionSheet];
        return;
    }
    if (self.userPanel) {
        [UIView animateWithDuration:0.5 animations:^{
            self.userPanel.view.alpha = 0.0;
        }];
        
    }
    if (self.andWhoView.alpha) {
        [UIView animateWithDuration:0.5 animations:^{
            self.andWhoView.alpha = 0.0;
        }];
    }
    
    
    [self.keyboard.textField resignFirstResponder];
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
    
    if (!self.infoView) {
        self.infoView = [[RoomMyinfoViewController alloc] init];
        self.infoView.view.frame = CGRectMake(kScreenWidth/2-130, kScreenHeight/2-144, 260, 242);
        [self.view addSubview:self.infoView.view];
        self.infoView.view.layer.masksToBounds = YES;
        self.infoView.view.layer.cornerRadius = 5;
        self.infoView.delegate = self;

        if (!self.outBtn) {
            self.outBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            self.outBtn.frame = CGRectMake(kScreenWidth/2-13, self.infoView.view.frame.origin.y+self.infoView.view.frame.size.height+60, 26, 26);
            [self.outBtn setImage:kImageNamed(@"我的_关闭未按下") forState:UIControlStateNormal];
            [self.outBtn addTarget:self action:@selector(outBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.bgView addSubview:self.outBtn];
        }else{
            self.outBtn.hidden = NO;
            self.outBtn.frame = CGRectMake(kScreenWidth/2-13, self.infoView.view.frame.origin.y+self.infoView.view.frame.size.height+60, 26, 26);
        }
        

    }else{
        
        self.infoView.view.hidden = NO;
        [self infoViewUpData];
        self.outBtn.hidden = NO;
        self.outBtn.frame = CGRectMake(kScreenWidth/2-13, self.infoView.view.frame.origin.y+self.infoView.view.frame.size.height+60, 26, 26);
    }
}

-(void)bgViewhandleTap:(UIGestureRecognizer*)sender
{
    self.userPanel.view.alpha = 0.0;
    self.alertView.hidden= YES;
    [self.infoView.field resignFirstResponder];
    self.infoView.isModify = NO;
    self.bgView.hidden = YES;
    self.infoView.view.hidden = YES;
    self.outBtn.hidden = YES;
}

-(void)outBtnClick:(id)sender
{
    self.userPanel.view.alpha = 0.0;
    [self.infoView.field resignFirstResponder];
    self.infoView.isModify = NO;
    self.bgView.hidden = YES;
    self.infoView.view.hidden = YES;
    self.outBtn.hidden = YES;
}

-(void)MyIndoDidSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            [self chargeFromDefaultAnnounceRoom];
        }
            break;
        case 1:
        {
            if (kScreenWidth<375) {
                self.infoView.view.frame = CGRectMake(kScreenWidth/2-130, kScreenHeight/2-144, 260, 132);
            }else{
                self.infoView.view.frame = CGRectMake(kScreenWidth/2-130, kScreenHeight/2-66, 260, 132);
            }
            self.infoView.titles = @[@"我的昵称",@"修改昵称",@"我的修改"];
            self.infoView.isModify = YES;
            self.infoView.myInfoTable.tableHeaderView = nil;
            [self.infoView.myInfoTable reloadData];
            self.outBtn.frame = CGRectMake(kScreenWidth/2-13, self.infoView.view.frame.origin.y-60, 26, 26);
        }
            break;
        case 2:
        {
            if (!self.guanzhu) {
                self.guanzhu = [[GuanzhuViewController alloc] init];
                self.guanzhu.flag = 3;
                self.guanzhu.navTitle = @"房间";
                self.guanzhu.delegate = self;
            }
            NavigationController *nav = [[NavigationController alloc] initWithRootViewController:self.guanzhu];
            self.infoView.isModify = NO;
            self.bgView.hidden = YES;
            self.infoView.view.hidden = YES;
            self.outBtn.hidden = YES;
            
            //flag=1  代表关注
            [[UIApplication sharedApplication] setStatusBarHidden:NO];
            
            [self presentViewController:nav animated:YES completion:nil];
        }
            break;
        case 4:
        {
//            [self presentModalViewController:[UMFeedback feedbackModalViewController]animated:YES];
        }
            break;
        case 3:
        {
            [[UIApplication sharedApplication] endReceivingRemoteControlEvents];
            [self.uiManager exitDimiss:self];
        }
            break;
        default:
            break;
    }
}

-(void)ModifyDidSelect
{

    [self infoViewUpData];
}

-(void)infoViewUpData
{
    self.infoView.view.frame = CGRectMake(kScreenWidth/2-130, kScreenHeight/2-144, 260, 242);
    self.infoView.titles = @[@"充值柠檬",@"修改昵称",@"我的关注",@"退出房间"];
    self.infoView.isModify = NO;
    RoominfoHead *infohead = [[RoominfoHead alloc] init];
    infohead.backgroundColor = kRGB(52, 46, 48);
    infohead.frame = CGRectMake(0, 0, 260, 69);
    [[UIGlobalKit sharedInstance] setImageAnimationLoading:infohead.headImage WithSource:self.me.pic];

    infohead.nameLabel.text = [self.me.nick_name stringByUnescapingFromHTML];
    //用户等级
    Finance *finance = [[Finance alloc] initWithAttributes:self.me.finance];
    
    NSInteger userLevel= [self.dataManager wealthLevel:finance.coin_spend_total];
    
    NSString *weatherLevlString = [[DataGlobalKit sharedInstance] wealthImageString:userLevel];
    infohead.levelImage.image = [UIImage sd_animatedGIFNamed:weatherLevlString];
    
    
    //    [infohead setLevelImage:self.me.wealthLevel];
//    [infohead setMyVipImageType:self.me.vip];
    [infohead setVipImageType:self.me.vip];
    self.infoView.myInfoTable.tableHeaderView = infohead;
    [self.infoView.myInfoTable reloadData];
}

- (BOOL)meCanPrivateChat
{
    NSInteger wealthLevel = [self.dataManager wealthLevel:[TTShowUser coin_spend_total]];
    if (wealthLevel < 3)
    {
        [UIAlertView showInfoMessage:[NSString stringWithFormat:@"财富等级低于%d富不能私聊!", 3]];
        return NO;
    }
    return YES;
}

-(void)guanzhuVideoBack:(TTShowRoom*)room
{
    self.closeSocketIOWhenDisappear = YES;
    [self closeSockIO];
    [self.mediaPlayer1 pause];
    [self releaseAll];

    
    self.currentRoom = room;
    [self restart];
}

-(void)restart
{
    
    
    if (self.currentRoom.live) {
        [self setupMediaPath];
        
        [self setupPlayerContainer];
        [self setupLoading];
    }
    else
    {
        [self setupLoadingTo];
    }
    
    [self retrieveRoomStar];
    
    [self setupSocketIO];
    
    [self setupEmptyContainer];
    
    [self setupSegment];
    
    [self setupKeyboardView];
    
    [self setupTableView];
    
    [self setupGiftrankingTable];
    
    [self setupGiftListView];
    
    [self setupExpressionKeyboard];
}

@end
