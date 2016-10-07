//
//  BaseNetManager.h
//  CarsHome
//
               

//  Created by Qinting on 16/7/15.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ResquestSuccessBlock)(id json);
typedef void(^ResquestFailureBlock)(NSError *error);

@interface BaseNetManager : NSObject


+ (void)GET:(NSString *)url parameters:(NSDictionary *)params success:(ResquestSuccessBlock)success failure:(ResquestFailureBlock)failure;

+ (void)POST:(NSString *)url parameters:(NSDictionary *)params success:(ResquestSuccessBlock)success failure:(ResquestFailureBlock)failure;

@end
