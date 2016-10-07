//
//  QTTopicTool.h
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
                         *  http://my.oschina.net/AngusTing/blog?catalog=3487645
                         *  推荐博客 http://www.jianshu.com/users/1c034326279d/latest_articles
                         *
                         */

//  Created by Qinting on 16/5/21.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QTTopicParam.h"
#import "QTTopicResult.h"

@interface QTTopicTool : NSObject

typedef void(^QTTopicToolSuccess)(QTTopicResult *result);
typedef void(^QTTopicToolFailure)(NSError *error);

+ (void)topicGetDataWithParam:(QTTopicParam*)param success:(QTTopicToolSuccess)success failure:(QTTopicToolFailure)failure;

@end
