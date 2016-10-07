//
//  AppDelegate.m
//  MakeTheBestOfThing
//
//  Created by Qinting on 16/3/27.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "AppDelegate+System.h"
#import <MLTransition.h>

const void *netStatusKey = &netStatusKey;
@implementation AppDelegate (System)

- (void)setupGlobalConfig{
    //电池条显示菊花,监测网络活动
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    //网络状态监测
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSLog(@"Reachability: %@", AFStringFromNetworkReachabilityStatus(status));
    }];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    //自定义左上角返回按钮, 导致右划返回失效
    [MLTransition validatePanPackWithMLTransitionGestureRecognizerType:MLTransitionGestureRecognizerTypeScreenEdgePan];
    
    [DDLog addLogger:[DDASLLogger sharedInstance]];
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    [[DDTTYLogger sharedInstance] setColorsEnabled:YES];
    
    [self setupGlobalUI];
}

- (void)setupGlobalUI{
    //为了让电池条呈现白色
    [UINavigationBar appearance].barStyle = UIBarStyleBlack;
    [UINavigationBar appearance].translucent = NO;
    [UINavigationBar appearance].barTintColor = kNaviBarBGColor;
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:20]}];
    [UIBarButtonItem appearance].tintColor = [UIColor whiteColor];
    
    [UITabBar appearance].translucent = NO;
    [UITabBar appearance].barTintColor = kRGBA(237, 236, 235, 1.0);
    self.window.tintColor = kNaviBarBGColor;
    
}

- (BOOL)isOnLine{
    switch (self.netReachStatus) {
        case AFNetworkReachabilityStatusUnknown:
        case AFNetworkReachabilityStatusNotReachable: {
            return NO;
            break;
        }
        case AFNetworkReachabilityStatusReachableViaWWAN:
        case AFNetworkReachabilityStatusReachableViaWiFi: {
            return YES;
            break;
        }
    }
}

- (AFNetworkReachabilityStatus)netReachStatus{
    return [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus;
}

// App进入后台
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [[EMClient sharedClient] applicationDidEnterBackground:application];
}

// App将要从后台返回
- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [[EMClient sharedClient] applicationWillEnterForeground:application];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
}
@end
