//
//  ZYImageLoopViewController.m
//  ImageLoopDemo
//
//  Created by mac on 16/7/23.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ZYImageLoopViewController.h"

@interface ZYImageLoopViewController ()<UIScrollViewDelegate>
{
    NSArray *_images;
    CGFloat _showWidth;
    CGFloat _showHeight;
    NSInteger _imagesCount;
    NSInteger _perPage;
    NSMutableArray *_showViews;
    CGRect _showRect;
    NSInteger showViewPages;
}
@end

@implementation ZYImageLoopViewController

-(instancetype)initWithShowRect:(CGRect)showRect images:(NSArray *)images{
    self =[super init];
    if (self) {
        //初始化滚动区域的尺寸及图片
        _images=images;
        _showWidth=showRect.size.width;
        _showHeight=showRect.size.height;
        _showRect=showRect;
        _imagesCount=images.count;
        _perPage=0;
        _showViewType=threeShowViewPage;
    }
    return self;
}
-(void)loadView{
    //初始化滑动区域
    UIScrollView *scrollView=[[UIScrollView alloc]initWithFrame:_showRect];
    scrollView.contentSize=CGSizeMake(_showWidth*3, _showHeight);
    scrollView.delegate=self;
    //取消弹性
    scrollView.bounces=NO;
    //分页滑动
    scrollView.pagingEnabled=YES;
    //替换self.view
    self.view=scrollView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _showViews =[[NSMutableArray alloc]init];
    
    showViewPages=(_showViewType==threeShowViewPage?3:_imagesCount+2);
    
    
    for (int i=0; i<showViewPages; i++) {
        UIImageView *showView=[[UIImageView alloc]initWithFrame:CGRectMake(_showWidth*i, 0, _showWidth, _showHeight)];
        //图片取出值
        _perPage=[self imagesIndexWithNumber:((i%_imagesCount)-1)];
        //设置图片
        [self showViewSetImageWith:showView imageIndex:_perPage];
        [self.view addSubview:showView];
        [_showViews addObject:showView];
    }
    //偏移到中间
    ((UIScrollView *)self.view).contentOffset=CGPointMake(_showWidth, 0);
    
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
#warning  代理方法不执行
    //判断左划右滑
    NSInteger pageAdd=(scrollView.contentOffset.x>_showWidth) ? 1 : -1 ;
    
   
    switch (_showViewType) {
        case threeShowViewPage:{
            
          
             _perPage =[self imagesIndexWithNumber:_perPage]+pageAdd;
            __block NSInteger page;
            __weak typeof(self) weakSelf;
            //重置ShowView Image
            [_images enumerateObjectsUsingBlock:^(UIImageView*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                //图片取出值
                page= [weakSelf imagesIndexWithNumber:(_perPage+idx)];
                //设置图片
                [weakSelf showViewSetImageWith:obj imageIndex:page];
            }];
            
            //减速完毕替换图片
            [scrollView setContentOffset:CGPointMake(_showWidth, 0) animated:NO];
            
            break;
        }
        case mostShowViewPage:{
        
            if (_perPage==0 &&_perPage==(showViewPages-1)) {
                
                _perPage =[self imagesIndexWithNumber:(_perPage+pageAdd*2)];
                
                //减速完毕替换图片
                [scrollView setContentOffset:CGPointMake(_perPage *_showWidth, 0) animated:NO];
            }
            
            break;
        }
        default:
            break;
    }
    
   
}

-(void)showViewSetImageWith:(UIImageView*)showView imageIndex:(NSInteger)index{
    
    id image=_images[index];
    //根据不同值选择合适的赋值方式
    if ([image isKindOfClass:[NSString class]]) {
        
        showView.image=[UIImage imageNamed:image];
        
    }else if ([image isKindOfClass:[UIImage class]]){
        
        showView.image=image;
        
    }else{
        
        NSLog(@"ZYImageLoop，images内数据类型不为Nsstring 和UIImage");
    }
}

-(NSInteger)imagesIndexWithNumber:(NSInteger)Number{
        //保证数组内取值不超出范围
    return (Number+_imagesCount)%_imagesCount;
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
