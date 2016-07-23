//
//  ViewController.m
//  ImageLoopDemo
//
//  Created by mac on 16/7/23.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ViewController.h"
#import "ZYImageLoopViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    ZYImageLoopViewController *loopViewController=  [[ZYImageLoopViewController alloc]initWithShowRect:CGRectMake(20, 20, 300, 300) images:@[]];
    [self.view addSubview:loopViewController.view];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
