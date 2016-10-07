//
//  NSObject+Networking.h
//  QTGameLive
//
//  Created by Qinting on 16/4/17.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

@interface NSObject (Networking)

+ (id)GET:(NSString*)path parameters:(NSDictionary*)parameters progress:( void(^)(NSProgress *downloadPropress) )downloadProgress  completionHandle:( void(^)(id responseObj, NSError *error) )completionHandle;

+ (id)POST:(NSString*)path parameters:(NSDictionary*)parameters progress:( void(^)(NSProgress *downloadPropress) )downloadProgress  completionHandle:( void(^)(id responseObj, NSError *error) )completionHandle;
@end
