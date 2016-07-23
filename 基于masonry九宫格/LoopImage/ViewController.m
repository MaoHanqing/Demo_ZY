//
//  ViewController.m
//  LoopImage
//
//  Created by mac on 16/7/22.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
@interface ViewController ()
{
    UIView *lastView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CGFloat screenWidth=[[UIScreen mainScreen] bounds].size.width;
    CGFloat gap=20;
    CGFloat width=(screenWidth-4*gap)/3;
    
    for (int i=0; i<9; i++) {
        
        UIView *view=[[UIView alloc]init];
        view.backgroundColor=[UIColor redColor];
        [self.view addSubview:view];
        if(!lastView){
            //确定第一个视图的frame 可以用约束或者设置
            view.frame=CGRectMake(gap, 100, width, width);
            //记录上一个视图
            lastView=view;
            continue;
        }
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(width);
            make.height.mas_equalTo(width);
                //每行第一个的约束
            if (i%3==0) {
            make.top.equalTo(lastView.mas_bottom).with.offset(gap);
            make.right.equalTo(lastView.mas_left).with.offset(-(gap*2+width));
            }else{
             //其它视图约束
            make.top.equalTo(lastView.mas_top).with.offset(0);
            make.left.equalTo(lastView.mas_right).with.offset(gap);
                }
            }];
    
        //记录上一个视图
        lastView=view;
        
    }
    
}
//禁止横竖屏
-(BOOL)shouldAutorotate{
    return NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
