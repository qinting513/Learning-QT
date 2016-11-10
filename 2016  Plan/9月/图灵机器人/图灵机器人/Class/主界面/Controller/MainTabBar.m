//
//  MainTabBar.m
//  天气助手
//
//  Created by Guo.JC on 16/8/27.
//  Copyright © 2016年 Guo.JC. All rights reserved.
//

#import "MainTabBar.h"

@interface MainTabBar ()

@end

@implementation MainTabBar

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupTabBar];
}


-(void)setupTabBar
{
    
    [self setupVCTabbar:[MainViewController new] andImage:@"home" andSelectImage:@"home" andTitle:@"图灵"];
    [self setupVCTabbar:[WeatherViewController new] andImage:@"tab_weather" andSelectImage:@"tab_weather_selected"  andTitle:@"天气"];
    [self setupVCTabbar:[TimeViewController new] andImage:@"tab_live" andSelectImage:@"tab_live_selected" andTitle:@"时景"];
    [self setupVCTabbar:[MeViewController new] andImage:@"tab_me" andSelectImage:@"tab_me_selected" andTitle:@"我"];
}

-(void)setupVCTabbar:(UIViewController*)view andImage:(NSString*)image andSelectImage:(NSString *)selectImage andTitle:(NSString*)title
{
    if ([title isEqualToString:@"图灵"]) {
//        UIImage * normalImage = [[UIImage imageNamed:@"home"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//        UIImage * selectImage = [[UIImage imageNamed:@"home"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

        UIImage * normalImage = [[UIImage imageNamed:@"home"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIImage * selectImage = [UIImage imageNamed:@"home"];
        view.tabBarItem.title = title;
        view.tabBarItem.image = normalImage;
        view.tabBarItem.selectedImage = selectImage;
        [self addChildViewController:[[MainNavi alloc] initWithRootViewController:view]];
    }
    else{
        view.tabBarItem.title = title;
        view.tabBarItem.image = [UIImage imageNamed:image];
        view.tabBarItem.selectedImage = [UIImage imageNamed:selectImage];
        [self addChildViewController:[[MainNavi alloc] initWithRootViewController:view]];
    }
}


-(void)dealloc
{
    NSLog(@"释放——MAIN_TAB_BAR");
}

@end
