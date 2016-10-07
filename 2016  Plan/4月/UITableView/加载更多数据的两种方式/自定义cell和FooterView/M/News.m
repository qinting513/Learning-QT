//
//  News.m
//  Demo03_自定义单元格
//
//  Created by xiaoz on 15/9/15.
//  Copyright (c) 2015年 xiaoz. All rights reserved.
//

#import "News.h"

@implementation News

+ (NSMutableArray *)demoData
{
    // 声明一个空白的可变数组
    NSMutableArray *allNews = [NSMutableArray array];
    
    // 1.读取plist数据到数组中
    // 生成plist文件的完整路径
    //[NSBundle mainBundle] 当前工程的主文件夹
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"news" ofType:@"plist"];
    NSLog(@"filePath %@", filePath);
    //把一个绝对路径下的 文件 转换为一个数组
    NSArray *plistArray = [NSArray arrayWithContentsOfFile:filePath];
    // 2.遍历数组中的每一个字典
    for (NSDictionary *dict in plistArray) {
        //数组中的每一个dict就是一个新闻news的对象
        //目标：将字典变模型
        News *news = [[News alloc]init];
        //通过字典中key找到对应属性赋值 注意：字典的key和类中的属性名称一定要一致  使用的是KVC技术
        [news setValuesForKeysWithDictionary:dict];
        
        [allNews addObject:news];
    }
    return allNews;
}
@end






