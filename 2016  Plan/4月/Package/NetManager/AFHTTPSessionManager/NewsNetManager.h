//
//  NewsNetManager.h
//  CarsHome
//


//  Created by Qinting on 16/7/15.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BaseNetManager.h"
#import "NewsModel.h"

typedef NS_ENUM(NSUInteger ,NewsListType)
{
    NewsListTypeZuiXin, //最新
    NewsListTypeXinWen,//新闻
    NewsListTypePingCe,//评测
    NewsListTypeDaoGou,//导购
    NewsListTypeHangQing,//行情
    NewsListTypeYongChe,//用车
    NewsListTypeJiShu, //技术
    NewsListTypeWenHua,//文化
    NewsListTypeGaiZhuang,//改装
    NewsListTypeYouJi,//游记
};


@interface NewsNetManager : BaseNetManager

//通过type来区分 请求的地址
+ (void)getNewsList:(NewsListType)type lastTime:(NSString*)time page:(NSInteger)page completionHandle:(void(^)(id json, NSError *error))completionHandle;

@end
