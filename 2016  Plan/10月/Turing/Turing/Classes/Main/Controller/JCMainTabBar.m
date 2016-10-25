//
//  MainTabBar.m
//  天气助手
//
//  Created by Guo.JC on 16/8/27.
//  Copyright © 2016年 Guo.JC. All rights reserved.
//

#import "JCMainTabBar.h"

@interface JCMainTabBar ()

@end

@implementation JCMainTabBar

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTabBar];
    self.tabBar.tintColor = kMainColor;
}


-(void)setupTabBar
{
    [self setupVCTabbar:[JCBluetoothTest new] andImage:@"device_d" andSelectImage:@"device_d_selec" andTitle:@"蓝牙"];
    [self setupVCTabbar:[JCTuringVC new] andImage:@"turing" andSelectImage:@"turing_selec" andTitle:@"图灵"];
    [self setupVCTabbar:[JCWeatherVC new] andImage:@"weather" andSelectImage:@"weather_selec"  andTitle:@"天气"];
    [self setupVCTabbar:[JCMapVC new] andImage:@"map_a" andSelectImage:@"map_a_selec" andTitle:@"线路"];
    [self setupVCTabbar:[JCMeVC new] andImage:@"me_b" andSelectImage:@"me_b_selec" andTitle:@"我"];
}

-(void)setupVCTabbar:(UIViewController*)view andImage:(NSString*)image andSelectImage:(NSString *)selectImage andTitle:(NSString*)title
{
    //    if ([title isEqualToString:@"图灵"]) {
    //        UIImage * normalImage = [[UIImage imageNamed:@"tabbar_TR003"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //        UIImage * selectImage = [[UIImage imageNamed:@"tabbar_TR003"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //
    //        view.tabBarItem.title = title;
    //        view.tabBarItem.image = normalImage;
    //        view.tabBarItem.selectedImage = selectImage;
    //        [self addChildViewController:[[MainNavi alloc] initWithRootViewController:view]];
    //    }
    //    else{
    view.title = title;
    view.tabBarItem.title = title;
    view.tabBarItem.image = [UIImage imageNamed:image];
    view.tabBarItem.selectedImage = [UIImage imageNamed:selectImage];
    [self addChildViewController:[[JCMainNavi alloc] initWithRootViewController:view]];
    //    }
}


-(void)dealloc
{
    NSLog(@"释放——MAIN_TAB_BAR");
}

#pragma mark 横竖屏相关
//询问是否支持旋转
- (BOOL)shouldAutorotate
{
    //    获取导航控制器 是否支持
    return self.selectedViewController.shouldAutorotate;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return self.selectedViewController.supportedInterfaceOrientations;
}

@end
