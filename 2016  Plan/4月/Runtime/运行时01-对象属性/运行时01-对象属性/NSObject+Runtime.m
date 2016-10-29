//
//  NSObject+Runtime.m
//  运行时01-对象属性
//
//  Created by Qinting on 2016/10/29.
//  Copyright © 2016年 QT. All rights reserved.
//

#import "NSObject+Runtime.h"

@implementation NSObject (Runtime)

+(NSArray *)qt_objProperties{
    //  提高效率 如果有值 则直接返回
    // 动态获取 属性
    NSArray *ptyList = objc_getAssociatedObject(self, kPropertyList);
    if(ptyList != nil){
        return ptyList;
    }
    
    NSMutableArray *arr = [NSMutableArray array];
    /** 参数：1.要获取的类
             2.类属性的个数指针
        返回值：所有属性的数组，C语言中，数组名字就是指向第一个元素的地址
     */
    unsigned int count = 0 ;
    objc_property_t *proList =  class_copyPropertyList(self, &count);
    for(unsigned int i = 0; i<count;i++){
        objc_property_t property = proList[i];
        const char *name = property_getName(property);
//        const char *type = property_getAttributes(property);
//        NSLog(@"%s == %s",name,type);
        NSString *ocName = [[NSString alloc]initWithCString:name encoding:NSUTF8StringEncoding];
        [arr addObject:ocName];
    }
    free(proList);
    // 动态添加属性 set方法
    /** 参数 ： 1.对象 self ，OC中class也是一个特殊的对象 
        2.动态添加属性的key 3.动态添加的属性的值，对象的引用策略 */
    objc_setAssociatedObject(self, kPropertyList, arr,  OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    /** 通过ivar 方式的 */
//    unsigned int count = 0 ;
//    Ivar *ivars = class_copyIvarList(self, &count);
//    NSLog(@"count:%d",count);
//    for(unsigned int i =0; i<count; i++){
//        Ivar ivar = ivars[i];
//        const char *name = ivar_getName(ivar);
//        const char *type = ivar_getTypeEncoding(ivar);
//        NSLog(@"%s == %s",name,type);
//    }
    return  ptyList;
}

const char *kPropertyList = "kPropertyList";
/** 字典转模型的核心算法 但没考虑到嵌套等，需更复杂*/
+(instancetype)qt_objWithDict:(NSDictionary*)dict{
  
    
    id object = [[self alloc]init];
    //使用字典设置对象信息
    NSArray *proList = [self qt_objProperties];
    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
//        NSLog(@"key %@ == value :%@",key,obj);
        if ([proList containsObject:key]) {
            [object setValue:obj forKey:key];
        }
    }];
    
    return object;
}


@end
