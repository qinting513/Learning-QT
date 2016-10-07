//
//  CategoryModel.m
//  QTGameLive
//
//  Created by Qinting on 16/4/17.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "CategoryModel.h"

@implementation CategoryModel

//重写方法，来配置修改的属性名
+ (NSDictionary*)modelCustomPropertyMapper{

    return @{
             @"ID":@"id",
             @"firstLetter": @"first_letter",
             @"属性名":@"key"  //这一行没有对应的 但也不会出错
             };

}

@end
