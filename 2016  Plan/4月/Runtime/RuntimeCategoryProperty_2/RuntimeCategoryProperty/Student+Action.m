//
//  Student+Action.m
//  RuntimeCategoryProperty
//
//  Created by Qinting on 16/4/9.
//  Copyright © 2016年 Qinting. All rights reserved.
//

//使用OC的底层 C来解决OC的分类不能加属性的特性
#import <objc/runtime.h>

#import "Student+Action.h"

@implementation Student (Action)

/** 通过runtime函数 重写setter 和 getter 方法  
 Associated 结交 联合
 */

-(NSString *)name{
     //_cmd 当前方法的指针地址
    return objc_getAssociatedObject(self, _cmd);
}

-(void)setName:(NSString *)name{
       //把name属性绑定到self的@selecor(name)方法的指针的地址key上
    /** 该函数需要四个参数：源对象，关键字，关联的对象和一个关联策略  
     *关键字是一个void类型的指针。每一个关联的关键字必须是唯一的。通常都是会采用静态变量来作为关键字。
     *关联策略表明了相关的对象是通过赋值，保留引用还是复制的方式进行关联的；还有这种关联是原子的还是非原子的。这里的关联策略和声明属性时的很类似。这种关联策略是通过使用预先定义好的常量来表示的。
     */
//    objc_setAssociatedObject(<#id object#>, <#const void *key#>, <#id value#>, <#objc_AssociationPolicy policy#>)
    objc_setAssociatedObject(self, @selector(name), name, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(void)sayHello{
    NSLog(@"hello %@",self.name);
}

@end
