//
//  AppDelegate+Custom.h
//  QTGameLive
//
//  Created by Qinting on 16/4/16.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "AppDelegate.h"
#import <AFNetworkReachabilityManager.h>

@interface AppDelegate (Custom)

/** 当前是否有网络 */
@property (nonatomic,readonly,getter=isHaveNetwork) BOOL haveNetwork;

/** 无网络，未知，Wi-Fi，手机2G，3G，4G */
@property (nonatomic,readonly) AFNetworkReachabilityStatus netStatus;

-(void)setupGlobalConfig;

@end
