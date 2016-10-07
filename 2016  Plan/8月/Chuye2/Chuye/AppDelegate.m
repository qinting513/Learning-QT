//
//  AppDelegate.m
//  Chuye
//
//  Created by Qinting on 16/8/16.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "AppDelegate.h"
#import "WelcomeViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate

-(UIWindow *)window{
    if(!_window){
        _window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
        [_window makeKeyAndVisible];
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        _window.rootViewController = [sb instantiateInitialViewController];
    }
    return _window;
}

-(UIWindow *)welcomeWindow{
    if (!_welcomeWindow) {
        _welcomeWindow = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _welcomeWindow.hidden = NO;
               //窗口的层级关系, 数值越大, 则显示在上层 默认是0
        _welcomeWindow.windowLevel = 1;
        _welcomeWindow.rootViewController = [[WelcomeViewController alloc]init];
    }
    return _welcomeWindow;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    NSDictionary *info = [NSBundle mainBundle].infoDictionary;
    NSString *version = info[@"CFBundleShortVersionString"];
    NSString *readVersion = [[NSUserDefaults standardUserDefaults] objectForKey:@"ReadVersion"];
    if([readVersion isEqualToString:version]){
        [self window];
    }else{
        [self welcomeWindow];
        [self window];
    }
    return YES;
}


- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    NSLog(@"sourceApplication:%@--%@",url.absoluteString,sourceApplication);
    NSString *urlString = url.absoluteString;
    // YourApp://aaa?backScheme=MyApp
    NSRange range  = [urlString rangeOfString:@"backScheme="];
    if (range.length > 0) {
        NSInteger fromIndex = range.length + range.location;
        NSString *backScheme = [urlString substringFromIndex:fromIndex];
        NSLog(@"%@",backScheme);
//        self.backScheme = backScheme;
    }
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
