//
//  HTTPTool.h
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

#import <Foundation/Foundation.h>

typedef void(^RequestSuccessBlock)(id json);
typedef void(^RequestFailureBlock)(NSError *error);


@interface HTTPTool : NSObject

/** 对AFHTTPSessionManager的GET封装 */
+ (void)GET:(NSString *)url params:(NSDictionary *)params success:(RequestSuccessBlock)success failure:(RequestFailureBlock)failure;

/** 对AFHTTPSessionManager的POST封装 */
+ (void)POST:(NSString *)url params:(NSDictionary *)params success:(RequestSuccessBlock)success failure:(RequestFailureBlock)failure;

@end



