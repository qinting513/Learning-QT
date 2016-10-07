//
//  NSObject+Networking.m
//  QTGameLive
//
//  Created by Qinting on 16/4/17.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "NSObject+Networking.h"

@implementation NSObject (Networking)

+ (id)GET:(NSString*)path parameters:(NSDictionary*)parameters progress:( void(^)(NSProgress *downloadPropress) )downloadProgress  completionHandle:( void(^)(id responseObj, NSError *error) )completionHandle{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    /** 设置超时时间 */
    manager.requestSerializer.timeoutInterval = 30.0;
    /** 设置响应内容类型 */
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",
                                                         @"text/plain",@"text/json",@"text/javascript",@"application/json", nil];
    return [manager GET:path parameters:parameters progress:downloadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObject: %@",responseObject);
        completionHandle(responseObject,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error： %@",error);
        completionHandle(nil,error);
    }];
    
}


+ (id)POST:(NSString*)path parameters:(NSDictionary*)parameters progress:( void(^)(NSProgress *downloadPropress) )downloadProgress  completionHandle:( void(^)(id responseObj, NSError *error) )completionHandle{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    /** 设置超时时间 */
    manager.requestSerializer.timeoutInterval = 30.0;
    /** 设置响应内容类型 */
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",
                                                         @"text/plain",@"text/json",@"text/javascript",@"application/json", nil];
    return [manager POST:path parameters:parameters progress:downloadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        completionHandle(responseObject,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completionHandle(nil,error);
    }];
    
}

@end
