//
//  MainNavi.m
//  天气助手
//
//  Created by Guo.JC on 16/8/27.
//  Copyright © 2016年 Guo.JC. All rights reserved.
//

#import "JCMainNavi.h"

@interface JCMainNavi ()

@end

@implementation JCMainNavi

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.barTintColor = kMainColor;
    //设置title颜色
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor blackColor]};//中间title文字颜色
    self.navigationBar.tintColor = [UIColor whiteColor];//导航栏按键颜色
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//设置状态栏（运行商 电量）为白色
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (BOOL)shouldAutorotate
{
    //询问最终显示的页面是否支持
    return [self.viewControllers.lastObject shouldAutorotate];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return [self.viewControllers.lastObject supportedInterfaceOrientations];
}

@end
