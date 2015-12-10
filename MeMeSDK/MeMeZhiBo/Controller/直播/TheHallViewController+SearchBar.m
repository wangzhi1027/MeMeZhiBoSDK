//
//  TheHallViewController+SearchBar.m
//  memezhibo
//
//  Created by Xingai on 15/6/1.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "TheHallViewController+SearchBar.h"
#import "TheHallViewController+Table.h"


@implementation TheHallViewController (SearchBar)

-(void)setSearchBarView
{
    self.ShadowView = [[UIView alloc] initWithFrame:CGRectMake(0, kNavigationBarHeight, kScreenWidth, kScreenHeight-kNavigationBarHeight)];
    self.ShadowView.backgroundColor = kRGB(80, 72, 75);
    self.ShadowView.alpha = 0.95;
    self.ShadowView.hidden = YES;
    

    [self.view addSubview:self.ShadowView];
    
    
    
    self.search = [[SearchBar alloc] init];
    self.search.frame = CGRectMake(0.0f, -64.0f, kScreenWidth, 64.0f);
    self.search.delegate = self;
    self.search.field.delegate = self;
    self.search.field.keyboardAppearance=UIKeyboardAppearanceAlert;
    self.search.backgroundColor = kNavigationMainColor;
    [self.view addSubview:self.search];
}

-(void)cancelView
{
    if (self.noDataView) {
        self.noDataView.view.hidden = YES;
    }
    self.curRoomShowMode = kRoomShowDefaultMode;
    [self reloadTable];
    
    [self.search.field resignFirstResponder];
    self.ShadowView.hidden = YES;
    self.search.field.text = @"";
    self.search.clearBtn.hidden = YES;
    self.keywords = @"";
    self.search.ResultLabel.text = @"";
    [UIView animateWithDuration:0.5 animations:^{
        self.search.frame = CGRectMake(0.0f, -64.0f, kScreenWidth, 64.0f);
    }];
}

-(void)reloadTable
{
    self.curSortType = self.tempFlag;
    switch (self.tempFlag) {
        case kRoomSortDefault:
        {
            self.HitToLoveTableView.hidden = YES;
            self.mainTableView.hidden = NO;
            [self retrieveHitToLoveList:NO];
            [self retrieveRoomList:NO];
            [self remoteWallpaper];
            self.curRoomShowMode = kRoomShowDefaultMode;
        }
            break;
        case kRoomSortHot:
        {
            self.HitToLoveTableView.hidden = NO;
            self.mainTableView.hidden = YES;
            [self retrieveHitToLoveList:NO];
            self.curRoomShowMode = kRoomShowSearchMode;
        }
            break;
        case 2:
        {
            self.mainTableView.hidden = YES;
            self.HitToLoveTableView.hidden = YES;
            self.xiaoWoTableView.hidden = NO;
            [self retrieveXiaowo:NO];
            if (self.isAnchor) {
                [self retrieveMyXiaowoInfo];
            }
            self.curRoomShowMode = kRoomShowSearchMode;
        }
            break;
    }

}

-(void)cancelButton
{
    
//    [self reloadTable];
    self.search.field.text = @"";
    self.keywords = @"";
    self.search.ResultLabel.text = @"";
    self.search.clearBtn.hidden = YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([textField.text isEqual:@""]) {
        textField.placeholder = @"";
    }
    else
    {
        textField.placeholder = @"输入主播昵称关键字或房间号";
    }
    
    self.keywords = self.search.field.text;
    kMainSetCurrentPageNumber(1);
    [self.search.field resignFirstResponder];
    self.ShadowView.hidden = YES;
    self.mainTableView.hidden = YES;
    self.HitToLoveTableView.hidden = NO;
    self.curSortType = 1;
    
    [self retrieveHitToLoveList:NO];
    return YES;
}

- (BOOL)textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    self.search.clearBtn.hidden = NO;
    return YES;
}


@end
