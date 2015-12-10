//
//  AndWhoListView.m
//  memezhibo
//
//  Created by Xingai on 15/6/16.
//  Copyright (c) 2015年 Xingaiwangluo. All rights reserved.
//

#import "AndWhoListView.h"
#import "AndWhoCell.h"
#import "NSBundle+SDK.h"

@implementation AndWhoListView

-(id)init
{
    if (self = [super init])
    {
        self = [[[NSBundle SDKResourcesBundle]loadNibNamed:@"AndWhoListView" owner:self options:nil] lastObject];
        
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 8;
        
        UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) style:UITableViewStylePlain];
        self.andWhoListTable = table;
        self.andWhoListTable.dataSource = self;
        self.andWhoListTable.delegate = self;
        self.andWhoListTable.backgroundColor = kCommonBgColor;
        
        [self addSubview:self.andWhoListTable];
    }
    
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.andWhoList.count+1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AndWhoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AndWhoCellID"];
    if (cell == nil)
    {
        cell = [[[NSBundle SDKResourcesBundle] loadNibNamed:@"AndWhoCell" owner:self options:nil] lastObject];
    }
    
    if (indexPath.row < self.andWhoList.count) {
        cell.nick_name.text = [self.andWhoList[indexPath.row] valueForKey:kChatTargetNickNameKey];
    }
    else
    {
        cell.nick_name.text = @"所有人";
    }
    
    return cell;
}

-(void)reloadTable
{
    self.alpha = 0.0;
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 1.0;
    }];
    self.andWhoListTable.frame = CGRectMake(0, 0, self.frame.size.width, 44*(self.andWhoList.count+1));
    self.andWhoListTable.contentSize = CGSizeMake(self.frame.size.width,44*(self.andWhoList.count));
    [self.andWhoListTable reloadData];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.delegate didSelectRowAtIndexPath:indexPath];
}

@end
