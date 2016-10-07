//
//  DiscoveryUtils.m
//  Chuye
//
//  Created by Qinting on 16/8/18.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "DiscoveryUtils.h"

@implementation DiscoveryUtils
+(id)GET:(NSString *)url  completionHandler:(void (^)( Discovery* discovery, NSError *myError))completionHandler
{
    return  [self  GET:url parameters:nil progress:nil completionHandler:^(id model, NSError *error) {
        !completionHandler ?: completionHandler([Discovery parse:model],error);
    }];
}

+(id)GETUsers:(NSString *)url  completionHandler:(void (^)( DiscoveryUsers* discoveryUsers, NSError *myError))completionHandler
{
    return  [self  GET:url parameters:nil progress:nil completionHandler:^(id model, NSError *error) {
        !completionHandler ?: completionHandler([DiscoveryUsers parse:model],error);
    }];

}
@end
