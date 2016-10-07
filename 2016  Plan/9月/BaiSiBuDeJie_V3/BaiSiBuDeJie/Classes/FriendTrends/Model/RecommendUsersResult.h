//
//  RecommendUsersResult.h
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

@class RecommendUsersResultList;
@interface RecommendUsersResult : NSObject

@property (nonatomic, strong) NSArray<RecommendUsersResultList *> *list;

@property (nonatomic, assign) NSInteger total_page;

@property (nonatomic, assign) int  total;

@property (nonatomic, assign) NSInteger next_page;

@end

@interface RecommendUsersResultList : NSObject

@property (nonatomic, copy) NSString *introduction;

@property (nonatomic, copy) NSString *uid;

@property (nonatomic, copy) NSString *header;

@property (nonatomic, assign) NSInteger gender;

@property (nonatomic, assign) NSInteger is_follow;

@property (nonatomic, copy) NSString *fans_count;

@property (nonatomic, assign) NSInteger tiezi_count;

@property (nonatomic, copy) NSString *screen_name;

@end

