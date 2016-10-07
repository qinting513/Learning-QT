//
//  AppDelegate+Custom.m
//  QTGameLive
//
//  Created by Qinting on 16/4/16.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "AppDelegate+Custom.h"

@implementation AppDelegate (Custom)



-(void)setupGlobalConfig{
    /** 监听当前网络状态 */
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSLog(@"Reachabiity:%@",AFStringFromNetworkReachabilityStatus(status) ) ;
    }];
    /** 需要启动监听 */
    [[AFNetworkReachabilityManager sharedManager]startMonitoring];
    
}

-(AFNetworkReachabilityStatus )netStatus{
    return [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus;
}


-(BOOL)isHaveNetwork{
    switch (self.netStatus) {
        case AFNetworkReachabilityStatusUnknown:
        case AFNetworkReachabilityStatusNotReachable:
            return NO;
            break;
            
        case AFNetworkReachabilityStatusReachableViaWiFi:
        case AFNetworkReachabilityStatusReachableViaWWAN:
            return YES;
            break;
    }
}

@end
