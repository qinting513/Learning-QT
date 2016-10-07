//
//  AppDelegate.m
//  EaseDemo
//
//  Created by Qinting on 16/9/1.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "AppDelegate.h"
#import <EaseMob.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //registerSDKWithAppKey: 注册的AppKey，详细见下面注释。
    //apnsCertName: 推送证书名（不需要加后缀），详细见下面注释。
    [[EaseMob sharedInstance] registerSDKWithAppKey:@"77331283#teduitsns" apnsCertName:@"nil"];
    [[EaseMob sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];

//    if([[EaseMob sharedInstance].chatManager isLoggedIn]){
//        // 设置自动登录
//        [[EaseMob sharedInstance].chatManager setIsAutoLoginEnabled:YES];
//    }
    return YES;
}

// APP进入后台
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [[EaseMob sharedInstance] applicationDidEnterBackground:application];
}

// APP将要从后台返回
- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [[EaseMob sharedInstance] applicationWillEnterForeground:application];
}

// 申请处理时间
- (void)applicationWillTerminate:(UIApplication *)application
{
    [[EaseMob sharedInstance] applicationWillTerminate:application];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

@end
