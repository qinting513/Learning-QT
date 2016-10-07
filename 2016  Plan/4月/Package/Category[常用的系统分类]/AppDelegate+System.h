 //
//  AppDelegate.m
//  MakeTheBestOfThing
//
//  Created by Qinting on 16/3/27.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "AppDelegate.h"
#import <AFNetworkActivityIndicatorManager.h>
#import <AFNetworkReachabilityManager.h>

@interface AppDelegate (System)

- (void)setupGlobalConfig;

@property (nonatomic, readonly) AFNetworkReachabilityStatus netReachStatus;
@property (nonatomic, getter=isOnLine, readonly) BOOL onLine;

@end
