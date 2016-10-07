//
//  RecommendUsersParam.h
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

//  Created by Qinting on 16/5/17.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecommendUsersParam : NSObject

/** a = list */
@property (nonatomic,strong) NSString  *a;

/** c = subscribe */
@property (nonatomic,strong) NSString *c;

/** 要查询的推荐的标签 */
@property (nonatomic,strong)  NSString* category_id;

@property (nonatomic,strong) NSNumber *page;


@end
