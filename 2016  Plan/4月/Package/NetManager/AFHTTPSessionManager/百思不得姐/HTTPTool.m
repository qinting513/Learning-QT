//
//  HTTPTool.m
//  BaiSiBuDeJie
//
                        /*
                         *----------Dragon be here!----------*
                         * 　　　┏┓　　　┏┓
                         * 　　┏┛┻━━━┛┻┓
                         * 　　┃　　　　　　　┃
                         * 　　┃　　　━　　　┃
                         * 　　┃　┳┛　┗┳　┃
                         * 　　┃　　　　　　　┃
                         * 　　┃　　　┻　　　┃
                         * 　　┃　　　　　　　┃
                         * 　　┗━┓　　　┏━┛
                         * 　　　　┃　　　┃神兽保佑
                         * 　　　　┃　　　┃代码永无BUG！
                         * 　　　　┃　　　┗━━━┓
                         * 　　　　┃　　　　　　　┣┓
                         * 　　　　┃　　　　　　　┏┛
                         * 　　　　┗┓┓┏━┳┓┏┛
                         * 　　　　　┃┫┫　┃┫┫
                         * 　　　　　┗┻┛　┗┻┛
                           * ━━━━━神兽出没，杀死BUG━━━━━━*
                         *
                    
                         *
                         */


//  Created by Qinting on 16/5/17.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "HTTPTool.h"
#import <AFNetworking.h>

@implementation HTTPTool

/** 其实RequestSuccessBlock 的参数就跟下面GET方法的success的参数一样就可以，
       或者用到哪些就用哪些作为参数 
 */
+ (void)GET:(NSString *)url params:(NSDictionary *)params success:(RequestSuccessBlock)success failure:(RequestFailureBlock)failure{
                [[AFHTTPSessionManager manager] GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {

                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    MYLog(@"responseObject:%@",responseObject);
                    !success ? : success(responseObject);
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    !failure ? : failure(error);
                }];
}

+ (void)POST:(NSString *)url params:(NSDictionary *)params success:(RequestSuccessBlock)success failure:(RequestFailureBlock)failure {
          [[AFHTTPSessionManager manager] POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
          } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
              success(responseObject);
          } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
              failure(error);
          }];
}
@end
