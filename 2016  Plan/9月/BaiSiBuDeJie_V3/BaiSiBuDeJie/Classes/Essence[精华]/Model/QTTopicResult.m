//
//  QTTopicResult.m
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

#import "QTTopicResult.h"
#import "QTTopic.h"

@implementation QTTopicResult

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"page":@"info.page",
                    @"count":@"info.count",
                    @"maxtime":@"info.maxtime"  };
}

+ (NSDictionary*)mj_objectClassInArray{
    return @{ @"list" : [QTTopic class] };
}

@end
