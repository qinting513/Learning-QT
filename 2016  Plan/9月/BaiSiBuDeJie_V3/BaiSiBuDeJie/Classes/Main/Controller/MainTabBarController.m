//
//  MainTabBarController.m
//  BaiSiBuDeJie
//
//  Created by Qinting on 16/5/16.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "MainTabBarController.h"
#import "QTEssenceViewController.h"
#import "FriendTrendsViewController.h"
#import "QTMeTableViewController.h"
#import "QTNewViewController.h"

#import "QTTabBar.h"
#import "BaseNavigationController.h"


@interface MainTabBarController ()

@end

@implementation MainTabBarController

+ (void)initialize{
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    [[UITabBarItem appearance] setTitleTextAttributes:attr forState:UIControlStateNormal];
    
    [[UITabBar appearance] setBackgroundImage:[UIImage imageNamed:@"tabbar-light"]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /** 苹果的私有api，需要kvc设置 */
    [self setValue:[[QTTabBar alloc]init] forKeyPath:@"tabBar"];
    
    [self setupTabBar];
}

- (void)setupTabBar {
    
    [self setupViewController:[[QTEssenceViewController alloc]init] title:@"精华" image:@"tabBar_essence_icon" selectedIamgeName:@"tabBar_essence_click_icon"];
    
        [self setupViewController:[[QTNewViewController alloc]init] title:@"新贴" image:@"tabBar_new_icon" selectedIamgeName:@"tabBar_new_click_icon"];
    
        [self setupViewController:[[FriendTrendsViewController alloc]init] title:@"关注" image:@"tabBar_friendTrends_icon"selectedIamgeName:@"tabBar_friendTrends_click_icon"];
    
        [self setupViewController:[[QTMeTableViewController  alloc]init] title:@"我的" image:@"tabBar_me_icon" selectedIamgeName:@"tabBar_me_click_icon"];
}

- (void)setupViewController:(UIViewController *)vc title:(NSString *)title image:(NSString *)imageName selectedIamgeName:(NSString *)selectedImageName{
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:imageName];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImageName];

    [self addChildViewController:[[BaseNavigationController alloc] initWithRootViewController:vc]];
}


@end
