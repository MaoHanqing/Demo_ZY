//
//  ZYFristViewController.m
//  xiaLaShuaXin
//
//  Created by mac on 15-5-21.
//  Copyright (c) 2015年 zhiyou. All rights reserved.
//

#import "ZYFristViewController.h"
#import "SVPullToRefresh.h"
@interface ZYFristViewController ()

@end

@implementation ZYFristViewController

-(void)viewWillAppear:(BOOL)animated

{
    [super viewWillAppear:animated];
    
//    进入页面 自动刷新
    
    [_table triggerPullToRefresh];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    numArr =[[NSMutableArray alloc]initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13" ,nil];
    
//    下拉刷新
    
    __block ZYFristViewController *blockSelf = self;
    [_table addPullToRefreshWithActionHandler:^{
       
        
        [blockSelf performSelector:@selector(jiaZai) withObject:blockSelf afterDelay:2];
    }];
    
    
    
//    [_table addPullToRefreshWithActionHandler:<#^(void)actionHandler#> position:<#(SVPullToRefreshPosition)#>]
    
//    上推 加载没显示出来的旧数据
    
    [_table addInfiniteScrollingWithActionHandler:^{
        
       [blockSelf performSelector:@selector(infinite) withObject:blockSelf afterDelay:2];
        
    }];
    
}

-(void)jiaZai
{
    NSLog(@"下拉刷新");
    
//    上拉刷新结束后会自动调用一次上推的方法
    
    [_table.pullToRefreshView stopAnimating];
}

-(void)infinite
{
    [numArr addObject:@"21"];
    [numArr addObject:@"20"];
    [numArr addObject:@"211"];
    [numArr addObject:@"2111"];
    [numArr addObject:@"222"];
    NSLog(@"加载没显示出来的旧数据");
    [_table.infiniteScrollingView stopAnimating];
    [_table reloadData];
}

#pragma mark----UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return numArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIndentifier =@"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    
    if (!cell)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    
    cell.textLabel.text=[numArr objectAtIndex:indexPath.row];
    
    return cell;
}

@end
