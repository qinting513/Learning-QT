//
//  RecommendTool.m
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

#import "RecommendTool.h"
#import "HTTPTool.h"


@implementation RecommendTool
+ (void) recommendCategoryWithParam:(RecommendCategoriesParam *)param success:(RecommendCategorySuccessBlock)successBlock failure:(RecommendCategoryFailureBlock)failureBlock{
    
    [HTTPTool GET:MainURL params:param.mj_keyValues  success:^(id json) {
        /** 空合运算符：successBlock不是空的时候则执行后面的
         mj_objectWithKeyValues 将网络请求回来的json进行模型转换
         */
        !successBlock ? :  successBlock([RecommendCategoriesResult mj_objectWithKeyValues:json]);
    } failure:failureBlock];
}

+ (void) recommendUsersWithParam:(RecommendUsersParam *)param success:(RecommendUsersSuccessBlock)successBlock failure:(RecommendUsersFailureBlock)failureBlock{
[HTTPTool GET:MainURL params:param.mj_keyValues success:^(id json) {
    
    !successBlock ? : successBlock([RecommendUsersResult mj_objectWithKeyValues:json]);
    
} failure:failureBlock];
}

@end
