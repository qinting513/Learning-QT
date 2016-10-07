//
//  ViewController.m
//  HeaderView
//
//  Created by Qinting on 16/4/20.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "ViewController.h"
#import "HeaderView.h"

@interface ViewController ()<HeaderViewDelegate>

@property (nonatomic,strong)   HeaderView *headerView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /** 测试 */
    
//    NSArray *imageArray = @[@"01.jpg",@"02.jpg",@"03.jpg",@"04.jpg",@"05.jpg",@"06.jpg",@"07.jpg",@"08.jpg"];
//    _headerView = [[HeaderView alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 80) imageArray:imageArray];
//    
    
    NSArray *textArray = @[@"头条",@"娱乐",@"热点",@"体育",@"财经",@"科技",@"汽车",@"旅游",@"时尚",@"房产",@"图片",@"重播",@"轻松一刻",@"军事",@"历史",@"家居",@"游戏",@"健康"];

    _headerView = [[HeaderView alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 40) textArray:textArray];
    _headerView.delegate = self;
    _headerView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_headerView];
}

-(void)headerView:(HeaderView *)headerView clickButtonAtIndex:(NSInteger)index
{
    NSLog(@"点击了第%ld个",index);
}

@end
