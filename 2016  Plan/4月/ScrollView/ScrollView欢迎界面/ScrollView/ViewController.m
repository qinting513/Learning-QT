//
//  ViewController.m
//  ScrollView
//
//  Created by Qinting on 16/4/19.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "ViewController.h"

#define kCount 8


@interface ViewController ()<UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIPageControl *pageController;

@end

@implementation ViewController

#pragma mark - 懒加载
-(UIScrollView *)scrollView
{
    if (!_scrollView) {
        CGFloat w = self.view.bounds.size.width;
        CGFloat h = self.view.bounds.size.height;
        
        _scrollView = [[UIScrollView alloc]init];
        
        /** 1.设置frame */
        _scrollView.frame = CGRectMake(0, 0,w,h);
        /** 2.设置contentSize  height＝＝0 说明禁止垂直方向滚动*/
        _scrollView.contentSize = CGSizeMake(kCount * w, 0);
        _scrollView.pagingEnabled = YES;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.delegate = self; //使用到代理方法了，要设置代理
        [self.view addSubview:_scrollView];
        
        /** 3.设置图片 注意图片并行排列，x的值改变 */
        for(int i =0; i<kCount; i++){
            UIImageView *imageView = [[UIImageView alloc]init];
            imageView.frame = CGRectMake(i * w, 0, w, h);
            imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"0%d.jpg",i+1]];
            [_scrollView addSubview:imageView];
        }
    }
    
    return _scrollView;
}

-(UIPageControl *)pageController{
    if (!_pageController) {
        _pageController = [[UIPageControl alloc]init];
        _pageController.frame = CGRectMake( (self.view.bounds.size.width - 200)*0.5, self.view.bounds.size.height - 30, 200, 5);
        // 一共显示多少个圆点（多少页）
        _pageController.numberOfPages = kCount;
        // 设置选中页的圆点颜色
        _pageController.currentPageIndicatorTintColor = [UIColor redColor];
        // 设置非选中页的圆点颜色
        _pageController.pageIndicatorTintColor = [UIColor whiteColor];
//        _pageController.enabled = NO;//设置不能点击
        [self.view addSubview:_pageController];
    }
    
    return _pageController;
}

#pragma  mark -  viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrollView.hidden = NO;
    self.pageController.hidden = NO;
}

#pragma  mark - 代理方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
   int index =  self.scrollView.contentOffset.x / self.view.bounds.size.width;
    // 设置页码
    self.pageController.currentPage = index ;
}

@end
