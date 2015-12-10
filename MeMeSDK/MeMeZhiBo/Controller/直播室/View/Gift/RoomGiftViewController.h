//
//  RoomGiftViewController.h
//  memezhibo
//
//  Created by Xingai on 15/6/12.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "BaseViewController.h"
#import "TTShowScrollSegment.h"
#import "GiftListCell.h"
#import "BagGift.h"
#import "PSTCollectionView.h"
#import "GiftTextView.h"

@protocol RoomGitfDelegate <NSObject>

-(void)chargeFromDefaultAnnounceRoom;

-(void)giveIsOk;

@end


@interface RoomGiftViewController : BaseViewController<giftDelegate,UIActionSheetDelegate>
//UI
@property(nonatomic, strong) PSUICollectionView *giftsCV;
@property (weak, nonatomic) IBOutlet UILabel *loading;
@property (weak, nonatomic) IBOutlet UILabel *balanceLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *width;
@property (weak, nonatomic) IBOutlet UIView *balanceView;
@property (nonatomic, weak) id<RoomGitfDelegate>delegate;

@property (nonatomic, strong) TTShowScrollSegment *scrollSegment;
@property (nonatomic, strong) GiftListCell *tempCell;
@property (nonatomic, strong) GiftTextView *gifttextView;

// Gesture.
@property (nonatomic, strong) UISwipeGestureRecognizer *swipeLeft;
@property (nonatomic, strong) UISwipeGestureRecognizer *swipeRight;

@property (nonatomic, assign) NSInteger currentSelectedIndex;
@property (nonatomic, strong) NSMutableArray *giftCategories;

@property (nonatomic, strong) TTShowRoom *currentRoom;
@property (nonatomic, strong) NSMutableDictionary *giftsDictionary;
@property (nonatomic, strong) NSMutableArray *giftList;
@property (nonatomic, strong) NSMutableArray *totalGiftList;


// Current Gift
@property (nonatomic, assign) NSUInteger receiverID;
@property (nonatomic, strong) NSString *receiver;
@property (nonatomic, strong) TTShowGift *currentSelectedGift;
@property (nonatomic, assign) NSUInteger giftCount;
@property (nonatomic, strong) NSMutableArray *chatTargets;


- (TTShowGift *)currentGift:(NSIndexPath *)indexPath;
@end
