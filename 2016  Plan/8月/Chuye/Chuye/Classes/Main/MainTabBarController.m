//
//  MainTabBarController.m
//  Chuye
//
//  Created by Qinting on 16/8/19.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "MainTabBarController.h"
#import "QTTabBar.h"
#import "HomeBaseViewController.h"
#import "MeViewController.h"

@interface MainTabBarController ()

@end

@implementation MainTabBarController

+(void)initialize{
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSForegroundColorAttributeName] = [UIColor greenColor];
    [[UITabBarItem appearance] setTitleTextAttributes:attr forState:UIControlStateNormal];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
  
    /** 苹果的私有api，需要kvc设置 */
    [self setValue:[[QTTabBar alloc]init] forKeyPath:@"tabBar"];
    
}




@end
