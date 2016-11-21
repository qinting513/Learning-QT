//
//  Person.m
//  UnitTestDemo
//
//  Created by Qinting on 2016/11/17.
//  Copyright © 2016年 QT. All rights reserved.
//

#import "Person.h"

@implementation Person

+(instancetype)personWithDict:(NSDictionary*)dict
{
// 用self 方便子类基层
    Person* obj = [[self alloc]init];
    
    [obj setValuesForKeysWithDictionary:dict];
    
//    obj.age ++;
    
    if (obj.age <=0 || obj.age >=130) {
        obj.age = 0;
    }
    
    return obj;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{

}

@end
