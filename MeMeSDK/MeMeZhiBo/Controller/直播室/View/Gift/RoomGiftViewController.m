//
//  RoomGiftViewController.m
//  memezhibo
//
//  Created by Xingai on 15/6/12.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "RoomGiftViewController.h"
#import "RoomGiftViewController+Datasource.h"
#import "RoomGiftViewController+Delegate.h"
#import "TTShowRemote+Gift.h"
#import "TTShowRemote+UserManager.h"
#import "NSBundle+SDK.h"

@interface RoomGiftViewController ()

@end

@implementation RoomGiftViewController

- (void)awakeFromNib {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self awakeFromNib];
    [self setupCategories];
    [self setupGiftsCV];
    [self setupGiftTextView];
    
    // Remote.
    [self retrieveGiftList];
    // Do any additional setup after loading the view from its nib.
}

-(void)setupGiftTextView
{
    self.gifttextView = [[GiftTextView alloc] init];
    self.gifttextView.delegate = self;
    self.gifttextView.backgroundColor = kRGB(78, 70, 73);
    self.gifttextView.frame = CGRectMake(0, 122+240*kRatio-50, kScreenWidth, 50);
    [self.view addSubview:self.gifttextView];

    self.balanceLabel.font = [UIFont boldSystemFontOfSize:14];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self.balanceView addGestureRecognizer:tapGesture];
}



- (void)setupGiftsCV
{
    self.giftCount = 1;
    self.receiverID = self.currentRoom._id;
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(80*kRatio, 80*kRatio);
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;

    flowLayout.scrollDirection = PSTCollectionViewScrollDirectionVertical;
    self.giftsCV = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 36, kScreenWidth, 240*kRatio) collectionViewLayout:flowLayout];
    self.giftsCV.dataSource = self;
    self.giftsCV.delegate = self;
    self.giftsCV.backgroundColor = kCommonBgColor;
    [self.giftsCV setShowsHorizontalScrollIndicator:NO];
    
    
    UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
    self.swipeLeft = leftSwipe;
    self.swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
    self.swipeRight = rightSwipe;
    self.swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    
    [self.giftsCV registerNib:[UINib nibWithNibName:@"GiftListCell" bundle:[NSBundle SDKResourcesBundle]] forCellWithReuseIdentifier:@"GiftlistCellID"];
    
    
    [self.giftsCV addGestureRecognizer:self.swipeLeft];
    [self.giftsCV addGestureRecognizer:self.swipeRight];
    
    [self.view addSubview:self.giftsCV];
}

#pragma mark - Gesture

- (void)swipe:(UISwipeGestureRecognizer *)sender
{
    if (sender == self.swipeLeft)
    {
        //        LOGINFO(@"Left");
        // Next
        if (self.scrollSegment.selectedIndex >= self.giftCategories.count)
        {
            return;
        }
        
        self.currentSelectedIndex++;
        self.scrollSegment.selectedIndex = self.currentSelectedIndex;
        [self.giftsCV reloadData];
    }
    else if (sender == self.swipeRight)
    {
        //        LOGINFO(@"Right");
        // Previous
        if (self.scrollSegment.selectedIndex <= 0)
        {
            return;
        }
        
        self.currentSelectedIndex--;
        self.scrollSegment.selectedIndex = self.currentSelectedIndex;
        [self.giftsCV reloadData];
    }
}

- (void)retrieveGiftList
{
    
    self.loading.alpha = 1.0f;
    self.giftsCV.alpha = 0.0f;
    [self.dataManager.remote retrieveGiftListWithCompeletion:^(NSArray *array1, NSArray *array2, NSError *error) {
        
        if (error == nil && [array1 count] > 0 && [array2 count] > 0)
        {
            [self.totalGiftList removeAllObjects];
            [self.totalGiftList addObjectsFromArray:array1];
            [self.totalGiftList addObjectsFromArray:array2];
            
            NSMutableArray *gcg = [NSMutableArray arrayWithArray:array1];
            self.giftCategories = gcg;
            
            
            NSMutableArray *gl = [[NSMutableArray alloc] initWithCapacity:0];
            if (array2.count > 0) {
                for (NSDictionary *dict in array2) {
                    @autoreleasepool
                    {
                        TTShowGift *gift = [[TTShowGift alloc] initWithAttributes:dict];
                        if (gift.sale) {
                            [gl addObject:dict];
                        }
                    }
                }
            }
            self.giftList = gl;
            
            NSMutableDictionary *gd = [NSMutableDictionary dictionaryWithCapacity:0];
            self.giftsDictionary = gd;
            
            // Here Thanks Apple: provide NSPredicate & NSSortDescriptor , it's amazing.
            NSMutableArray *categories = [NSMutableArray arrayWithCapacity:0];
            for (NSDictionary *categoryDict in self.giftCategories)
            {
                @autoreleasepool
                {
                    TTShowGiftCategory *category = [[TTShowGiftCategory alloc] initWithAttributes:categoryDict];
                    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.category_id = %d", category._id];
                    NSArray *c = [self.giftList filteredArrayUsingPredicate:predicate];
                    
                    // Gift Sorted By Order.
                    NSSortDescriptor *sortByOrder = [NSSortDescriptor sortDescriptorWithKey:@"order" ascending:YES];
                    NSArray *resultArray = [c sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortByOrder]];
                    
                    [self.giftsDictionary setValue:resultArray forKey:[NSString stringWithFormat:@"%lu", (unsigned long)category._id]];
                    
                    [categories addObject:category.name];
                }
            }
            
            [categories addObject:@"背包"];
            NSMutableArray *bagGifts = [[NSMutableArray alloc] initWithCapacity:0];
            BagGift *bagGift = [[TMCache sharedCache] objectForKey:CACHE_BAG];
            
            
            if (bagGift && bagGift.bag.count > 0) {
                for (NSString *key in bagGift.bag) {
                    @autoreleasepool
                    {
                        NSInteger count = [[bagGift.bag objectForKey:key] intValue];
                        for (NSDictionary *dict in gl) {
                            @autoreleasepool
                            {
                                TTShowGift *gift = [[TTShowGift alloc] initWithAttributes:dict];
                                if (gift._id == [key integerValue]) {
                                    gift.count = count;
                                    if (gift.count!=0) {
                                        [bagGifts addObject:gift];
                                    }
                                    break;
                                }
                            }
                        }
                    }
                }
            }
            [self.giftsDictionary setValue:bagGifts forKey:@"背包"];
            [self.scrollSegment setItems:categories];
            [self.scrollSegment setSelectedIndex:0];

            // loading disappear.
            [UIView animateWithDuration:0.25f animations:^{
                self.loading.alpha = 0.0f;
                self.giftsCV.alpha = 1.0f;
            } completion:^(BOOL finished) {
                if (self.giftsCV)
                {
                    [self.giftsCV reloadData];
                }
                if (self.loading)
                {
                    [self.loading removeFromSuperview];
                    self.loading = nil;
                }
            }];
        }
    }];
}

#pragma mark - Get TTShowGift From NSArray & NSDictionary.

- (TTShowGift *)currentGift:(NSIndexPath *)indexPath
{
    if (self.currentSelectedIndex >= self.giftsDictionary.count) {
        return nil;
    }
    NSArray *gifts;
    if (self.currentSelectedIndex == self.giftsDictionary.count - 1) {
        gifts = [self.giftsDictionary valueForKey:@"背包"];
    } else {
        if (self.currentSelectedIndex >= self.giftCategories.count) {
            return nil;
        }
        NSDictionary *giftCategoryDict = self.giftCategories[self.currentSelectedIndex];
        TTShowGiftCategory *giftCategory = [[TTShowGiftCategory alloc] initWithAttributes:giftCategoryDict];
        gifts = [self.giftsDictionary valueForKey:[NSString stringWithFormat:@"%lu", (unsigned long)giftCategory._id]];
    }
    if (indexPath.row >= [gifts count])
    {
        return nil;
    }
    NSDictionary *giftDict = gifts[indexPath.row];
    TTShowGift *gift = [[TTShowGift alloc] initWithAttributes:giftDict];
    
    return gift;
}

- (void)setupCategories
{
    // Gift Category
    self.scrollSegment = (TTShowScrollSegment *)[self viewFromNib:@"TTShowScrollSegment" withOrigin:CGPointMake(0.0f, 0.0f)];
    
    self.scrollSegment.frame = CGRectMake(0, -1, kScreenWidth, 36);
    self.scrollSegment.normalBgStr = @"";
    
//    self.scrollSegment.selectedBgStr = @"";

//    [self.scrollSegment setNormalImagesInset:UIEdgeInsetsMake(1.0f, 0.0f, 1.0f, 0.0f)];
//    [self.scrollSegment setSelectedImagesInset:UIEdgeInsetsMake(0.0f, 6.0f, 0.0f, 6.0f)];
    self.scrollSegment.delegate = self;
    [self.view addSubview:self.scrollSegment];
    
    self.totalGiftList = [[NSMutableArray alloc] init];
}

-(void)giftClick:(id)sender
{
    [self sendGift];
}

#pragma mark - set part.
- (void)sendGift
{
    
    [self.delegate giveIsOk];
    // get gift cout.
    self.giftCount = [self.gifttextView.giftNumberFild.text integerValue];
    
    if (self.giftCount == 0)
    {
        self.giftCount = 1;
    }
    
    if (self.currentSelectedGift == nil || self.currentSelectedGift._id == 0) {
        [UIAlertView showInfoMessage:@"请先选取礼物"];
        return;
    }
    
    
    if (self.receiverID == 0) {
        // default send to star.
        self.receiverID = [[self.chatTargets[0] valueForKey:kChatTargetIDKey] unsignedIntegerValue];
    }
    
    self.gifttextView.giftNumberFild.text = @"";
    
    BagGift *bag = [[TMCache sharedCache] objectForKey:CACHE_BAG];
    if (bag && bag.bag.count > 0) {
        for (NSString *giftId in bag.bag) {
            NSInteger count = [[bag.bag valueForKey:giftId] intValue];
            if (self.currentSelectedGift._id == [giftId intValue] && count >= self.giftCount) {
                [self.dataManager.remote sendBagGift:self.currentRoom._id giftId:self.currentSelectedGift._id userId:self.receiverID count:self.giftCount successBlock:^(NSDictionary *dict) {
                    if (count == self.giftCount) {
                        [bag.bag removeObjectForKey:giftId];
                    } else {
                        NSInteger leftCount = count - self.giftCount;
                        [bag.bag setObject:[[NSNumber alloc]initWithInteger:leftCount] forKey:giftId];
                    }
                    [[TMCache sharedCache] setObject:bag forKey:CACHE_BAG block:nil];
                    NSMutableArray *gifts = [self.giftsDictionary valueForKey:@"背包"];
                    if (gifts.count > 0) {
                        for (NSMutableDictionary *giftDict in gifts) {
                            @autoreleasepool
                            {
                                NSInteger gift_id = [[giftDict valueForKey:@"_id"] intValue];
                                if (gift_id == [giftId intValue]) {
                                    NSInteger leftCount = count - self.giftCount;
                                    if (leftCount == 0) {
                                        [gifts removeObject:giftDict];
                                    } else {
                                        [giftDict setValue:[[NSNumber alloc]initWithInteger:leftCount] forKey:@"count"];
                                    }
                                    [self.giftsCV reloadData];
                                    break;
                                }
                            }
                        }
                    }
                    
                    
                    self.dataManager.filter.lastGiftSendCount = self.giftCount;
                    [kNotificationCenter postNotificationName:kNotificationSendGiftSuccess object:nil];
                    [self.uiManager.global showMessage:@"赠送成功" in:self disappearAfter:0.8f];
                    
                    
                    [self.dataManager.remote updateUserInfo:self.me.access_token completion:^(TTShowUser *user, NSError *error) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            
                            [self.dataManager updateUser];
                            
                            [kNotificationCenter postNotificationName:kNotificationUpdateUser object:nil];
                            [self recordFirstSendGift];
                        });
                    }];
                } failBlock:^(NSError *error) {
                    if ([self.dataManager.global balanceNotEnoughWithCode:[error code]])
                    {
                        [self showChargeTip];
                    }
                    else
                    {
                        [UIAlertView showErrorMessage:[error localizedDescription]];
                    }
                }];
                return;
            }
        }
    }
    
    if ([self.currentSelectedGift.name isEqualToString:@"财神"]) {
        [self.dataManager.remote sendFortune:self.currentRoom._id count:self.giftCount successBlock:^(NSDictionary *dict) {
            self.dataManager.filter.lastGiftSendCount = self.giftCount;
            [kNotificationCenter postNotificationName:kNotificationSendGiftSuccess object:nil];
            [self.uiManager.global showMessage:@"赠送成功" in:self disappearAfter:0.8f];
            
            
            [self.dataManager.remote updateUserInfo:self.me.access_token completion:^(TTShowUser *user, NSError *error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [self.dataManager updateUser];
                    
                    [kNotificationCenter postNotificationName:kNotificationUpdateUser object:nil];
                    [self recordFirstSendGift];
                });
            }];
        } failBlock:^(NSError *error) {
            if ([self.dataManager.global balanceNotEnoughWithCode:[error code]])
            {
                [self showChargeTip];
            }
            else
            {
                [UIAlertView showErrorMessage:[error localizedDescription]];
            }
        }];
    } else {
        NSMutableDictionary *paramDictionary = [[NSMutableDictionary alloc] initWithCapacity:0];
        [paramDictionary setValue:@(self.currentRoom._id) forKey:@"room_id"];
        [paramDictionary setValue:@(self.currentSelectedGift._id) forKey:@"gift_id"];
        [paramDictionary setValue:@(self.giftCount) forKey:@"count"];
        [paramDictionary setValue:@(self.receiverID) forKey:@"user_id"];
        
        [self.dataManager.remote _sendGiftWithParam:paramDictionary completion:^(BOOL success, NSError *error) {
            if (success)
            {
                // record count of sending gift in the last time.
                self.dataManager.filter.lastGiftSendCount = self.giftCount;
                
                // Close panel
                [kNotificationCenter postNotificationName:kNotificationSendGiftSuccess object:nil];
                [self.uiManager.global showMessage:@"赠送成功" in:self disappearAfter:0.8f];
                
                
                // Update User Consuming Information.
                [self.dataManager.remote updateUserInfo:self.me.access_token completion:^(TTShowUser *user, NSError *error) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        // update user in data manager.
                        [self.dataManager updateUser];
                        
                        // Update user information
                        [kNotificationCenter postNotificationName:kNotificationUpdateUser object:nil];
                        // Record task.
                        [self recordFirstSendGift];
                    });
                }];
            }
            else
            {
                if ([self.dataManager.global balanceNotEnoughWithCode:[error code]])
                {
                    [self showChargeTip];
                }
                else
                {
                    [UIAlertView showErrorMessage:[error localizedDescription]];
                }
            }
        }];
    }
}

- (void)showLoginTipActionSheet
{
    UIActionSheet *as = [[UIActionSheet alloc] initWithTitle:@"请登录后操作" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"登录", nil];
    [as showInView:self.navigationController.view];
}

- (void)handleTap:(UITapGestureRecognizer *)sender
{
    [self.delegate chargeFromDefaultAnnounceRoom];
}

- (void)recordFirstSendGift
{
    // Recode First Send Gift.
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self.dataManager.filter setFirstSendGift:YES];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
