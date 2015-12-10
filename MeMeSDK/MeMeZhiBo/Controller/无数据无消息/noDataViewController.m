//
//  noDataViewController.m
//  memezhibo
//
//  Created by Xingai on 15/7/2.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "noDataViewController.h"

@interface noDataViewController ()

@end

@implementation noDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self.view addGestureRecognizer:tapGesture];
}

- (void)handleTap:(UITapGestureRecognizer *)sender
{
    [self.delegate checkNetWork];
}

-(void)setupView
{
    self.noFavoImage.hidden = YES;
    self.noMessageImage.hidden = YES;
    self.noNetworkImage.hidden = YES;
    self.noFavoLabel.hidden = YES;
}

-(void)setupImage:(NSInteger)flag
{
    switch (flag) {
        case 0:
        {
            self.noDataLabel.text = @"Hi，您还没有关注过主播哦～";
            self.noFavoImage.hidden = NO;
            self.noFavoLabel.hidden = NO;
            self.noNetworkImage.hidden = YES;
            self.noMessageImage.hidden = YES;
        }
            break;
        case 1:
        {
            self.noDataLabel.text = @"Hi，您暂没有消息哦～";
            self.noMessageImage.hidden = NO;
            self.noFavoLabel.hidden = YES;
            self.noFavoImage.hidden = YES;
            self.noNetworkImage.hidden = YES;
        }
            break;
        case 2:
        {
            self.noDataLabel.text = @"Hi，请检查您的网络连接！";
            self.noMessageImage.hidden = YES;
            self.noFavoLabel.hidden = YES;
            self.noFavoImage.hidden = YES;
            self.noNetworkImage.hidden = NO;
        }
            break;
        case 3:
        {
            self.noDataLabel.text = @"Hi，您还没有管理过主播哦～";
            self.noFavoImage.hidden = NO;
            self.noFavoLabel.hidden = YES;
            self.noNetworkImage.hidden = YES;
            self.noMessageImage.hidden = YES;
        }
            break;
        case 4:
        {
            self.noDataLabel.text = @"Hi，没有相关的主播或房间哦～";
            self.noFavoImage.hidden = NO;
            self.noFavoLabel.hidden = YES;
            self.noNetworkImage.hidden = YES;
            self.noMessageImage.hidden = YES;
        }
            break;
        case 5:
        {
            self.noDataLabel.text = @"Hi，请登录后再进行操作哦～";
            self.noFavoImage.hidden = NO;
            self.noFavoLabel.hidden = YES;
            self.noNetworkImage.hidden = YES;
            self.noMessageImage.hidden = YES;
        }
            break;
        case 6:
        {
            self.noDataLabel.text = @"Hi，您还没有观看过主播哦～";
            self.noFavoImage.hidden = NO;
            self.noFavoLabel.hidden = YES;
            self.noNetworkImage.hidden = YES;
            self.noMessageImage.hidden = YES;
        }
            break;
        default:
            break;
    }
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
