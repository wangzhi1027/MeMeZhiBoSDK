//
//  PersonalHomePageViewController+Datasource.m
//  memezhibo
//
//  Created by Xingai on 15/7/8.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "PersonalHomePageViewController+Datasource.h"
#import "UIColor+Hex.h"


@implementation PersonalHomePageViewController (Datasource)

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imageList.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PersonalHomeCell *cell = (PersonalHomeCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"PersonalHomeCellID" forIndexPath:indexPath];
    //    cell.imageView.imageDelegate = self;
    cell.delegate = self;
    if (indexPath.row<self.imageList.count) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //更新UI操作
            //.....
            TTShowStarPhoto *starphoto = self.imageList[indexPath.row];
//            cell.messageLabel.text = [starphoto.title stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [[UIGlobalKit sharedInstance] setImageAnimationLoading:cell.imageView WithSource:starphoto._id];
            cell.djLabel.text = [NSString stringWithFormat:@"%ld",(long)starphoto.praise];
            UIPinchGestureRecognizer *pinchRecognizer = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(scaGesture:)];
            [pinchRecognizer setDelegate:self];
            [cell.imageView addGestureRecognizer:pinchRecognizer];
            cell.imageView.userInteractionEnabled = YES;
        });
        
    }
    
    return cell;
}

//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
//    UICollectionReusableView *reusableView = nil;
//    
//    if ([kind isEqualToString:CHTCollectionElementKindSectionHeader]) {
//        self.headView = [collectionView dequeueReusableSupplementaryViewOfKind:kind
//                                                          withReuseIdentifier:@"PersonalCollectionReusableView1"
//                                                                 forIndexPath:indexPath];
//        [[UIGlobalKit sharedInstance]setImageAnimationLoading:self.headView.bgImage.headImage WithSource:self.currentRoom.pic_url];
//        return self.headView;
//    } else if ([kind isEqualToString:CHTCollectionElementKindSectionFooter]) {
//        self.footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind
//                                                          withReuseIdentifier:@"PersonalCollectionReusableView2"
//                                                                 forIndexPath:indexPath];
//        return self.footerView;
//    }
//    
//    return reusableView;
//}

#pragma mark - CHTCollectionViewDelegateWaterfallLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.sizeArr.count>0) {
        return CGSizeMake((kScreenWidth-48)/2, [self.sizeArr[indexPath.row] floatValue]+58);
    }
    return  CGSizeMake((kScreenWidth-48)/2, (kScreenWidth-48)/2);
}

#pragma daImage
-(void)scaGesture:(id)sender {
    [self.view bringSubviewToFront:[(UIPinchGestureRecognizer*)sender view]];
    //当手指离开屏幕时,将lastscale设置为1.0
    if([(UIPinchGestureRecognizer*)sender state] == UIGestureRecognizerStateEnded) {
        lastScale = 1.0;
        return;
    }
    
    CGFloat scale = 1.0 - (lastScale - [(UIPinchGestureRecognizer*)sender scale]);
    CGAffineTransform currentTransform = [(UIPinchGestureRecognizer*)sender view].transform;
    CGAffineTransform newTransform = CGAffineTransformScale(currentTransform, scale, scale);
    [[(UIPinchGestureRecognizer*)sender view]setTransform:newTransform];
    lastScale = [(UIPinchGestureRecognizer*)sender scale];
}

#pragma mark - personalImageDelegate

-(void)imageClickWithCell:(UICollectionViewCell *)cell
{
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    PersonalHomeCell *personnalCell = (PersonalHomeCell*)cell;
    CGFloat width = personnalCell.imageView.frame.size.width;
    CGFloat height = personnalCell.imageView.frame.size.height;
    
    NSIndexPath *indexPath = [self.photoWallCollectionView indexPathForCell:cell];
    
    
    if (!self.bgView) {
        self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, kScreenWidth, kScreenHeight+20)];
        self.bgView.backgroundColor = kBlackColor;
        [self.view addSubview:self.bgView];
        
    
        if (!self.scroll) {
            self.scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight+20)];
            self.scroll.contentSize = CGSizeMake(kScreenWidth*self.imageList.count, kScreenHeight);
            self.scroll.pagingEnabled = YES;
            
            self.scroll.delegate = self;
            self.scroll.showsHorizontalScrollIndicator = NO;
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
            [self.scroll addGestureRecognizer:tapGesture];
            [self.bgView addSubview:self.scroll];
        }
        
        
        for (int i = 0; i<self.imageList.count; i++) {
            TTShowStarPhoto *starphoto = self.imageList[i];
            
            if (width/height>=kScreenWidth/kScreenHeight) {
                UIImageView *daImage = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth*i, kScreenHeight/2-kScreenWidth/((kScreenWidth-48)/2)*[self.sizeArr[i] floatValue]/2, kScreenWidth, kScreenWidth/((kScreenWidth-48)/2)*[self.sizeArr[i] floatValue])];
                
                [[UIGlobalKit sharedInstance]setImageAnimationLoading:daImage WithSource:starphoto._id];
                daImage.tag = kTempTag + i;
                [self.scroll addSubview:daImage];
            }else{
                
            }
        }
        
    }else{
        self.bgView.hidden = NO;
    }
    if (!self.daNav) {
        self.daNav = [[DaImageNavView alloc] init];
        self.daNav.frame = CGRectMake(0, -64, kScreenWidth, 64);
        self.daNav.delegate = self;
        [self.view addSubview:self.daNav];
        
        self.daTab = [[DaImageTabView alloc] init];
        self.daTab.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 64);
        [self.view addSubview:self.daTab];
    }
    self.scroll.contentOffset = CGPointMake(kScreenWidth*indexPath.row, 0);
}

-(void)daImageBack
{
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    self.isNavOn = NO;
    self.bgView.hidden = YES;
    [UIView animateWithDuration:0.5 animations:^{
        self.daNav.frame = CGRectMake(0, -64, kScreenWidth, 64);
        self.daTab.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 64);
        
    }];
}

// Gesture event.
- (void)handleTap:(UITapGestureRecognizer *)sender
{
    self.isNavOn = !self.isNavOn;
    
    if (self.isNavOn) {
        [UIView animateWithDuration:0.5 animations:^{
            self.daNav.frame = CGRectMake(0, 0, kScreenWidth, 64);
            self.daTab.frame = CGRectMake(0, kScreenHeight-64, kScreenWidth, 64);
        }];
    }else{
        [UIView animateWithDuration:0.5 animations:^{
            self.daNav.frame = CGRectMake(0, -64, kScreenWidth, 64);
            self.daTab.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 64);
        }];
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (self.scroll==scrollView) {
        NSInteger page = scrollView.contentOffset.x/kScreenWidth;
        
        TTShowStarPhoto *starphoto = self.imageList[page];
        self.daTab.nameLabel.text = [starphoto.title stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        long long int timeStamp = [DataGlobalKit filterTimeStampWithInteger:starphoto.timestamp];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeStamp];
        self.daTab.timeLabel.text = [date dateTimeString];
        self.daTab.numLabel.text = [NSString stringWithFormat:@"%ld",(long)starphoto.praise];
    } else if (scrollView == self.bgScrollView) {
        NSInteger page = scrollView.contentOffset.x / kScreenWidth;
        switch (page) {
            case 0:
            {
                [self.anchorHeaderView.photoWallBtn setTitleColor:[UIColor colorWithHexString:@"#FFC107" alpha:1.0] forState:UIControlStateNormal];
                [self.anchorHeaderView.profileBtn setTitleColor:[UIColor colorWithHexString:@"#333333" alpha:1.0] forState:UIControlStateNormal];
                break;
            }
            case 1:
            {
                [self.anchorHeaderView.photoWallBtn setTitleColor:[UIColor colorWithHexString:@"#333333" alpha:1.0] forState:UIControlStateNormal];
                [self.anchorHeaderView.profileBtn setTitleColor:[UIColor colorWithHexString:@"#FFC107" alpha:1.0] forState:UIControlStateNormal];
                break;
            }
            default:
                break;
        }
    }
}

//讨厌警告
-(id)diskImageDataBySearchingAllPathsForKey:(id)key
{
    return nil;
};


-(CGSize)downloadImageSizeWithURL:(id)imageURL
{
    NSURL* URL = nil;
    if([imageURL isKindOfClass:[NSURL class]]){
        URL = imageURL;
    }
    if([imageURL isKindOfClass:[NSString class]]){
        URL = [NSURL URLWithString:imageURL];
    }
    if(URL == nil)
        return CGSizeZero;
    NSString* absoluteString = URL.absoluteString;
#ifdef dispatch_main_sync_safe
    if([[MMSDImageCache sharedImageCache] diskImageExistsWithKey:absoluteString])
    {
        UIImage* image = [[MMSDImageCache sharedImageCache] imageFromMemoryCacheForKey:absoluteString];
        if(!image)
        {
            NSData* data = [[MMSDImageCache sharedImageCache] performSelector:@selector(diskImageDataBySearchingAllPathsForKey:) withObject:URL.absoluteString];
            image = [UIImage imageWithData:data];
        }
        if(!image)
        {
            return image.size;
        }
    }
#endif
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:URL];
    NSString* pathExtendsion = [URL.pathExtension lowercaseString];
    CGSize size = CGSizeZero;
    if([pathExtendsion isEqualToString:@"png"]){
        size =  [self downloadPNGImageSizeWithRequest:request];
    }
    else if([pathExtendsion isEqual:@"gif"])
    {
        size =  [self downloadGIFImageSizeWithRequest:request];
    }
    else{
        size = [self downloadJPGImageSizeWithRequest:request];
    }
    if(CGSizeEqualToSize(CGSizeZero, size))
    {
        NSData* data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:URL] returningResponse:nil error:nil];
        UIImage* image = [UIImage imageWithData:data];
        if(image)
        {
#ifdef dispatch_main_sync_safe
            [[MMSDImageCache sharedImageCache] storeImage:image recalculateFromImage:YES imageData:data forKey:URL.absoluteString toDisk:YES];
#endif
            size = image.size;
        }
    }
    return size;
}
-(CGSize)downloadPNGImageSizeWithRequest:(NSMutableURLRequest*)request
{
    [request setValue:@"bytes=16-23" forHTTPHeaderField:@"Range"];
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if(data.length == 8)
    {
        int w1 = 0, w2 = 0, w3 = 0, w4 = 0;
        [data getBytes:&w1 range:NSMakeRange(0, 1)];
        [data getBytes:&w2 range:NSMakeRange(1, 1)];
        [data getBytes:&w3 range:NSMakeRange(2, 1)];
        [data getBytes:&w4 range:NSMakeRange(3, 1)];
        int w = (w1 << 24) + (w2 << 16) + (w3 << 8) + w4;
        int h1 = 0, h2 = 0, h3 = 0, h4 = 0;
        [data getBytes:&h1 range:NSMakeRange(4, 1)];
        [data getBytes:&h2 range:NSMakeRange(5, 1)];
        [data getBytes:&h3 range:NSMakeRange(6, 1)];
        [data getBytes:&h4 range:NSMakeRange(7, 1)];
        int h = (h1 << 24) + (h2 << 16) + (h3 << 8) + h4;
        
        return CGSizeMake(w, h);
    }
    
    return CGSizeZero;
}
-(CGSize)downloadGIFImageSizeWithRequest:(NSMutableURLRequest*)request
{
    [request setValue:@"bytes=6-9" forHTTPHeaderField:@"Range"];
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if(data.length == 4)
    {
        short w1 = 0, w2 = 0;
        [data getBytes:&w1 range:NSMakeRange(0, 1)];
        [data getBytes:&w2 range:NSMakeRange(1, 1)];
        short w = w1 + (w2 << 8);
        short h1 = 0, h2 = 0;
        [data getBytes:&h1 range:NSMakeRange(2, 1)];
        [data getBytes:&h2 range:NSMakeRange(3, 1)];
        short h = h1 + (h2 << 8);
        return CGSizeMake(w, h);
    }
    return CGSizeZero;
}
-(CGSize)downloadJPGImageSizeWithRequest:(NSMutableURLRequest*)request
{
    [request setValue:@"bytes=0-209" forHTTPHeaderField:@"Range"];
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if ([data length] <= 0x58) {
        return CGSizeZero;
    }
    if ([data length] < 210) {// 肯定只有一个DQT字段
        short w1 = 0, w2 = 0;
        [data getBytes:&w1 range:NSMakeRange(0x60, 0x1)];
        [data getBytes:&w2 range:NSMakeRange(0x61, 0x1)];
        short w = (w1 << 8) + w2;
        short h1 = 0, h2 = 0;
        [data getBytes:&h1 range:NSMakeRange(0x5e, 0x1)];
        [data getBytes:&h2 range:NSMakeRange(0x5f, 0x1)];
        short h = (h1 << 8) + h2;
        return CGSizeMake(w, h);
    } else {
        short word = 0x0;
        [data getBytes:&word range:NSMakeRange(0x15, 0x1)];
        if (word == 0xdb) {
            [data getBytes:&word range:NSMakeRange(0x5a, 0x1)];
            if (word == 0xdb) {// 两个DQT字段
                short w1 = 0, w2 = 0;
                [data getBytes:&w1 range:NSMakeRange(0xa5, 0x1)];
                [data getBytes:&w2 range:NSMakeRange(0xa6, 0x1)];
                short w = (w1 << 8) + w2;
                short h1 = 0, h2 = 0;
                [data getBytes:&h1 range:NSMakeRange(0xa3, 0x1)];
                [data getBytes:&h2 range:NSMakeRange(0xa4, 0x1)];
                short h = (h1 << 8) + h2;
                return CGSizeMake(w, h);
            } else {// 一个DQT字段
                short w1 = 0, w2 = 0;
                [data getBytes:&w1 range:NSMakeRange(0x60, 0x1)];
                [data getBytes:&w2 range:NSMakeRange(0x61, 0x1)];
                short w = (w1 << 8) + w2;
                short h1 = 0, h2 = 0;
                [data getBytes:&h1 range:NSMakeRange(0x5e, 0x1)];
                [data getBytes:&h2 range:NSMakeRange(0x5f, 0x1)];
                short h = (h1 << 8) + h2;
                return CGSizeMake(w, h);
            }
        } else {
            return CGSizeMake(136, 160);
        }
    }
}
@end
