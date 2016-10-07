//
//  RecommendTool.h
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
                         */

//  Created by Qinting on 16/5/17.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RecommendCategoriesParam.h"
#import "RecommendCategoriesResult.h"
#import "RecommendUsersParam.h"
#import "RecommendUsersResult.h"


typedef  void(^RecommendCategorySuccessBlock)(RecommendCategoriesResult *result);
typedef  void(^RecommendCategoryFailureBlock)(NSError *error);

typedef void(^RecommendUsersSuccessBlock)( RecommendUsersResult *result);
typedef void(^RecommendUsersFailureBlock)(NSError *error);

@interface RecommendTool : NSObject

+ (void) recommendCategoryWithParam:(RecommendCategoriesParam *)param success:(RecommendCategorySuccessBlock)successBlock failure:(RecommendCategoryFailureBlock)failureBlock;

+ (void) recommendUsersWithParam:(RecommendUsersParam *)param success:(RecommendUsersSuccessBlock)successBlock failure:(RecommendUsersFailureBlock)failureBlock;

@end
