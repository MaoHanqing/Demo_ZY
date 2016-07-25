//
//  ZYImageLoopViewController.h
//  ImageLoopDemo
//
//  Created by mac on 16/7/23.
//  Copyright © 2016年 mac. All rights reserved.
//
typedef enum  {
    threeShowViewPage=0,
    mostShowViewPage,
    other,
} showViewMode;
#import <UIKit/UIKit.h>


@interface ZYImageLoopViewController : UIViewController
-(instancetype)initWithShowRect:(CGRect)showRect images:(NSArray *)images;
@property (assign,nonatomic) showViewMode showViewType;
@end
