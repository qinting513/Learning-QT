//
//  OtherViewController.m
//  Demo1_导航控制器
//
//  Created by tarena on 15/11/12.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import "OtherViewController.h"

@interface OtherViewController ()

@end

@implementation OtherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //设置导航栏显示或隐藏
    [self.navigationController setNavigationBarHidden:!self.navigationController.navigationBarHidden animated:YES];
}




@end
