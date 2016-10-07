//
//  DiscoveryUtils.h
//  Chuye
//
               

//  Created by Qinting on 16/8/18.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Discovery.h"
#import "DiscoveryUsers.h"

@interface DiscoveryUtils : NSObject
+(id)GET:(NSString *)url  completionHandler:(void (^)( Discovery* discovery, NSError *myError))completionHandler;
+(id)GETUsers:(NSString *)url  completionHandler:(void (^)( DiscoveryUsers* discoveryUsers, NSError *myError))completionHandler;
@end
