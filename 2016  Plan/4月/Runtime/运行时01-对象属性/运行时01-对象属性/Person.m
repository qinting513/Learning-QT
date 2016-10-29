//
//  Person.m
//  运行时01-对象属性
//
//  Created by Qinting on 2016/10/29.
//  Copyright © 2016年 QT. All rights reserved.
//

#import "Person.h"

@implementation Person
-(NSString *)description{
    NSArray *keys = @[@"name",@"age",@"height",@"songs"];
    //模型转字典
    return [self dictionaryWithValuesForKeys:keys].description;
}
@end
