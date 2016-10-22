//
//  AppDelegate+EaseMob.m
//  ITSNS
//
//  Created by tarena on 16/9/2.
//  Copyright © 2016年 Ivan. All rights reserved.
//

#import "AppDelegate+EaseMob.h"

@implementation AppDelegate (EaseMob)

-(void)easemobInitWithApplication:(UIApplication *)application andOptions:(NSDictionary *)launchOptions{
    
    [[EaseMob sharedInstance] registerSDKWithAppKey:@"77331283#teduitsns" apnsCertName:nil];
    [[EaseMob sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
    
    
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


@end
