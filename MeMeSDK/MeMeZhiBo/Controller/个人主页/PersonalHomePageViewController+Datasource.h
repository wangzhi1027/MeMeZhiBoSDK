//
//  PersonalHomePageViewController+Datasource.h
//  memezhibo
//
//  Created by Xingai on 15/7/8.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "PersonalHomePageViewController.h"

@interface PersonalHomePageViewController (Datasource)<UICollectionViewDataSource,personalImageDelegate,daNavDelegate,UIGestureRecognizerDelegate,UICollectionViewDelegate, CHTCollectionViewDelegateWaterfallLayout>

-(CGSize)downloadImageSizeWithURL:(id)imageURL;
-(CGSize)downloadPNGImageSizeWithRequest:(NSMutableURLRequest*)request;
-(CGSize)downloadGIFImageSizeWithRequest:(NSMutableURLRequest*)request;
-(CGSize)downloadJPGImageSizeWithRequest:(NSMutableURLRequest*)request;

@end
