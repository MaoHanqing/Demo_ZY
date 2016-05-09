//
//  ZYFristViewController.h
//  xiaLaShuaXin
//
//  Created by mac on 15-5-21.
//  Copyright (c) 2015年 zhiyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYFristViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UITableView *_table;
    
    NSMutableArray *numArr;
}
@end
