//
//  TheHallViewController.h
//  memezhibo
//
//  Created by Xingai on 15/5/22.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AnchorTableViewCell.h"
#import "CaveolaeTableViewCell.h"
#import "TTShowXiaowoList.h"
#import "AllAnchorTableViewCell.h"
#import "TTShowRoom.h"
#import "LoadMore.h"
#import "SearchBar.h"
#import "RoomSheachView.h"


typedef NS_ENUM(NSInteger, TheHallViewSection)
{
    kZhuboSection = 0,
    kXiaowoSection,
    kMainSection,
};

#ifndef __MWCell_LoadMore_Footer__
#define __MWCell_LoadMore_Footer__
#endif

typedef NS_ENUM(NSInteger, RoomSortType)
{
    kRoomSortDefault = 0,
    kRoomSortHot,
    kRoomSortOpenTime,
    kRoomSortGrade,
    kRoomSortSignTime,
    kRoomSortLove,
    kRoomSortTypeMax
};

typedef NS_ENUM(NSInteger, RoomShowMode)
{
    kRoomShowDefaultMode = 0,
    kRoomShowSearchMode,
    kRoomShowModeMax
};

typedef NS_ENUM(NSInteger, RoomTableViewTag)
{
    kRoomTheHallTableViewTag = 1000,
    kRoomHitToLoveTableViewTag,
    kRoomXiaowoTableViewTag,
    kRoomSearchTableViewTag,
    kRoomTableViewTagMax
};

typedef NS_ENUM(NSInteger, MainActionSheetTag)
{
    kMainActionSheetLoginTip = 1000,
    kMainActionSheetMax
};

typedef NS_ENUM(NSInteger, MainLoginItem)
{
    kMainLoginItemLogin = 0,
    kMainLoginItemCancel,
    kMainLoginItemMax
};


// get
#define kMainIsHasNoData [[isHasNoDataArray objectAtIndex:self.curRoomShowMode] boolValue]
#define kMainIsloadingMore [[isloadingMoreArray objectAtIndex:self.curRoomShowMode] boolValue]
#define kMainCurrentPageNumber [[currentPageNumberArray objectAtIndex:self.curRoomShowMode] unsignedIntegerValue]

// set
#define kMainSetIsHasNoData(value) [isHasNoDataArray replaceObjectAtIndex:self.curRoomShowMode withObject:@(value)]
#define kMainSetIsloadingMore(value) [isloadingMoreArray replaceObjectAtIndex:self.curRoomShowMode withObject:@(value)]
#define kMainSetCurrentPageNumber(value) [currentPageNumberArray replaceObjectAtIndex:self.curRoomShowMode withObject:@(value)]


@interface TheHallViewController : BaseViewController<UIScrollViewDelegate>
{
    // muti page in different section.
    NSMutableArray *currentPageNumberArray;
    NSMutableArray *isloadingMoreArray;
    NSMutableArray *isHasNoDataArray;
}

@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, strong) UITableView *HitToLoveTableView;
@property (nonatomic, strong) UITableView *xiaoWoTableView;
@property (nonatomic, strong) UIScrollView *mainScroll;
@property (nonatomic, strong) RoomSheachView *roomSheachView;

@property (nonatomic, strong) UIRefreshControl *systemRefreshView1;
@property (nonatomic, strong) UIRefreshControl *systemRefreshView2;
@property (nonatomic, strong) UIRefreshControl *systemRefreshView3;
@property (nonatomic, assign) NSInteger curSegType;
@property (nonatomic, strong) NSMutableArray *tempArray;

@property (nonatomic, strong) NSMutableArray *commendationList;
@property (nonatomic, strong) NSMutableArray *xinrenList;
@property (nonatomic, strong) NSMutableArray *roomList;
@property (nonatomic, strong) TTShowXiaowoInfo *currentXiaowoInfo;
@property (nonatomic, strong) NSMutableArray *xiaoWoList;
//@property (nonatomic, strong) NSMutableArray *hitToLoveList;
@property (nonatomic, assign) BOOL hasNoData;
@property (nonatomic, assign) BOOL isLoadingMore;
@property (nonatomic, assign) BOOL loadFinished;
@property (nonatomic, assign) BOOL isLoading;

@property (strong, nonatomic) UIButton *rightButton;
@property (strong, nonatomic) UIButton *leftButton;
@property (strong, nonatomic) NSMutableArray *imageList;
@property (nonatomic, assign) RoomSortType curSortType;
@property (nonatomic, assign) RoomShowMode curRoomShowMode;
@property (nonatomic, strong) LoadMore *loadMore1;
@property (nonatomic, strong) LoadMore *loadMore2;
@property (nonatomic, strong) LoadMore *loadMore3;
@property (nonatomic, assign) BOOL loadingData;
@property (nonatomic, assign) BOOL hasTouchTable;
@property (nonatomic, assign) CGFloat historyOffsetY;
@property (nonatomic, strong) SearchBar *search;
@property (nonatomic, strong) UIView *ShadowView;
@property (nonatomic, strong) NSString *keywords;
@property (nonatomic, assign) NSInteger page;
//@property(nonatomic, weak)NSTimer *timer;
@property (strong, nonatomic) UIPageControl *pageControl;

@property (nonatomic, weak) AnchorTableViewCell *curSelectedCell1;
@property (nonatomic, weak) CaveolaeTableViewCell *curSelectedCell2;
@property (nonatomic, weak) AllAnchorTableViewCell *curSelectedCell3;

@property (nonatomic, assign) NSInteger flag;
@property (nonatomic, assign) NSInteger segmentFlag;

@property (nonatomic, assign) NSInteger tempFlag;
@property (nonatomic, assign) BOOL isAnchor;
- (void)remoteWallpaper;

- (void)retrieveRoomList:(BOOL)loadMore;
-(void)retrieveHitToLoveList:(BOOL)loadMore;
-(void)retrieveFavorStar;
- (void)retrieveXiaowo:(BOOL)loadMore;
- (void)hideControls;
- (void)showControls;
-(void)retrieveMyXiaowoInfo;

@end
