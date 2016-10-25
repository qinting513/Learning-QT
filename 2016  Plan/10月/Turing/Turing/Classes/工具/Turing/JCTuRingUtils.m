//
//  JCTuRingUtils.m
//  图灵机器人
//
//  Created by Guo.JC on 16/8/31.
//  Copyright © 2016年 Guo.JC. All rights reserved.
//

#import "JCTuRingUtils.h"

static NSString *TURING_KEY = @"4e95b3e5a15f407290939c20eaa7bcce";

@implementation JCTuRingUtils
+(void)sendMessegeToTuringWith:(NSString *)text andComplete:(BLOCK)callback
{
    NSString *turingAPI = @"http://www.tuling123.com/openapi/api";
    NSDictionary *paramsDic = @{@"key":TURING_KEY,@"info":text};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    /*设置响应序列化，用于整理网络获取回来的数据*/
    [manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
    /*POST请求*/
    [manager POST:turingAPI parameters:paramsDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        NSString *text = dic[@"text"];
        NSLog(@"请求成功，数据为：%@",dic);
        callback(text);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败");
    }];
}
@end
