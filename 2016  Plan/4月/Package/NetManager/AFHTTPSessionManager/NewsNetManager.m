//
//  NewsNetManager.m
//  CarsHome
//
//  Created by Qinting on 16/7/15.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "NewsNetManager.h"

@implementation NewsNetManager

//通过type来区分 请求的地址
+ (void)getNewsList:(NewsListType)type lastTime:(NSString*)time page:(NSInteger)page completionHandle:(void(^)(id json, NSError *error))completionHandle
{
    //需要根据不同类型，设置对应的请求地址
    NSString *path = nil;
    //修改链接地址为 p%@  l%@, 对应 @(page),  time
    switch (type) {
        case NewsListTypeJiShu:
            path=[NSString stringWithFormat:@"http://app.api.autohome.com.cn/autov5.0.0/news/newslist-pm1-c0-nt102-p%@-s30-l%@.json", @(page), time];
            break;
        case NewsListTypeYouJi:
            path=[NSString stringWithFormat:@"http://app.api.autohome.com.cn/autov5.0.0/news/newslist-pm1-c0-nt100-p%@-s30-l%@.json", @(page), time];
            break;
        case NewsListTypeDaoGou:
            path=[NSString stringWithFormat:@"http://app.api.autohome.com.cn/autov5.0.0/news/newslist-pm1-c0-nt60-p%@-s30-l%@.json", @(page), time];
            break;
        case NewsListTypePingCe:
            path=[NSString stringWithFormat:@"http://app.api.autohome.com.cn/autov5.0.0/news/newslist-pm1-c0-nt3-p%@-s30-l%@.json", @(page), time];
            break;
        case NewsListTypeWenHua:
            path=[NSString stringWithFormat:@"http://app.api.autohome.com.cn/autov5.0.0/news/newslist-pm1-c0-nt97-p%@-s30-l%@.json", @(page), time];
            break;
        case NewsListTypeXinWen:
            path=[NSString stringWithFormat:@"http://app.api.autohome.com.cn/autov5.0.0/news/newslist-pm1-c0-nt1-p%@-s30-l%@.json", @(page), time];
            break;
        case NewsListTypeZuiXin:
            path=[NSString stringWithFormat:@"http://app.api.autohome.com.cn/autov5.0.0/news/newslist-pm1-c0-nt0-p%@-s30-l%@.json", @(page), time];
            break;
        case NewsListTypeYongChe:
            path=[NSString stringWithFormat:@"http://app.api.autohome.com.cn/autov5.0.0/news/newslist-pm1-c0-nt82-p%@-s30-l%@.json", @(page), time];
            break;
        case NewsListTypeHangQing:
            path=[NSString stringWithFormat:@"http://app.api.autohome.com.cn/autov5.0.0/news/newslist-pm1-c110100-nt2-p%@-s30-l%@.json", @(page), time];
            break;
        case NewsListTypeGaiZhuang:
            path=[NSString stringWithFormat:@"http://app.api.autohome.com.cn/autov5.0.0/news/newslist-pm1-c0-nt107-p%@-s30-l%@.json", @(page), time];
            break;
        default:
            break;
    }
    //只要请求下来的数据公用一个解析类，就可以合写
    [BaseNetManager GET:path parameters:nil success:^(id json) {
        NSLog(@"BaseNetManager json:%@",json);
        !completionHandle ? :   completionHandle([NewsModel parse:json],nil);
    } failure:^(NSError *error) {
               NSLog(@"BaseNetManager error:%@",error);
        !completionHandle ? :   completionHandle(nil,error);
    }];
    
}

@end
