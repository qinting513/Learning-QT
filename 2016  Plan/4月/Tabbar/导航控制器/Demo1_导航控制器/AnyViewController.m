//
//  AnyViewController.m
//  Demo1_导航控制器
//
//  Created by tarena on 15/11/12.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import "AnyViewController.h"

@interface AnyViewController ()

@end

@implementation AnyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"这是另一个流程";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(goback:)];
    // 设置导航栏的背景色
    self.navigationController.navigationBar.barTintColor = [UIColor purpleColor];
    // 在有导航的前提下
    // 如果需要修改状态栏的色系为白色系
    // 则需要设置导航栏的色系风格为深色系
    // 然后，系统发现导航栏是深色的了，就自动把状态栏给
    // 改成浅色的了
    self.navigationController.navigationBar.barStyle =UIBarStyleBlack;
    //设置bar的左右渲染颜色为白色
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
  
}


-(void)goback:(UIBarButtonItem *)item
{
    [self.navigationController  dismissViewControllerAnimated:YES completion:nil];
}

@end
