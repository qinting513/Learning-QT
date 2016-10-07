//
//  DataManager.m
//  WeiboDemo
//
//  Created by Qinting on 16/7/20.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "DataManager.h"
#import "Weibo.h"
#import "WeiboFrame.h"

@implementation DataManager


+(NSArray *)loadData
{
    NSMutableArray *mutableArr = [NSMutableArray array];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"weiboData" ofType:@"plist"];
    NSArray * arr = [NSArray arrayWithContentsOfFile:path];
    
    for (NSDictionary *dict  in arr) {
        /** 字典 ——> 模型  方式1: weiboWithDict方法，然后自己写那么赋值方法  */
//        Weibo *weibo = [Weibo weiboWithDict:dict];
        
         /** 字典 ——> 模型  方式2: kvc  但要求属性名与key要一一对应 */
        Weibo *weibo = [[Weibo alloc]init];
        [weibo setValuesForKeysWithDictionary:dict];
        
        
        WeiboFrame *f = [[WeiboFrame alloc]init];
        /** 调用Set方法，传入模型属性后即可根据模型内容计算出cell上每个控件的frame */
        f.weibo = weibo;
        [mutableArr addObject:f ];
    }
    return mutableArr;
}

@end
