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

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    NSLog(@"%s",__func__);
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
//    NSLog(@"tabbar:%s",__func__);
    CGFloat width = kScreenW / 3.0;
    int index = 0;
    for(UIControl *control in self.tabBar.subviews){
        /** 如果control不是UIControl类的，则继续 */
        if ( ![control isKindOfClass:[UIControl class]] || [control isKindOfClass:[UIButton class] ] ) {
            continue;
        }
        //        NSLog(@"%@",control);
        CGRect frame = control.frame;
        frame.size.width = width;
        //        等于1是右边按钮
        frame.origin.x = index == 1 ? width *(index + 1) : width *index ;
        frame.origin.y =10;
        control.frame = frame;
        index ++;
    }

}




@end
