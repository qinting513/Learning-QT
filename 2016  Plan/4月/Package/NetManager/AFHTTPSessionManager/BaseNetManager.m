//
//  BaseNetManager.m
//  CarsHome
//
//  Created by Qinting on 16/7/15.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "BaseNetManager.h"

static AFHTTPSessionManager *_manager = nil;
@implementation BaseNetManager
+(AFHTTPSessionManager*)sharedManager{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [AFHTTPSessionManager manager];
        _manager.requestSerializer.timeoutInterval = 30; //超时时间
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"text/html", @"text/plain", @"text/json", @"text/javascript", @"application/json"]];
    });
    return _manager;
}

+ (void)GET:(NSString *)url parameters:(NSDictionary *)params success:(ResquestSuccessBlock)success failure:(ResquestFailureBlock)failure
{
    
    
        [ [self sharedManager] GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"responseObject:  %@",responseObject);
            !success ? :  success(responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            !failure ? :  failure(error);
        }];
}

+ (void)POST:(NSString *)url parameters:(NSDictionary *)params success:(ResquestSuccessBlock)success failure:(ResquestFailureBlock)failure
{
        [ [self sharedManager] POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            !success ?: success(responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            !failure ?: failure(error);
        }];
}

@end
