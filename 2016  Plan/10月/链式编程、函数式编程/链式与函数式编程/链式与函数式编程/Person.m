//
//  Person.m
//  链式与函数式编程
//
//  Created by Qinting on 2016/10/29.
//  Copyright © 2016年 QT. All rights reserved.
//

#import "Person.h"

@implementation Person


-(void)run1{
    NSLog(@"run1");
}
-(void)eat1{
    NSLog(@"eat1");
}


-(Person*)run2{
    NSLog(@"run2");
    return self;
}
-(Person *)eat2{
NSLog(@"eat2");
    return self;
}

-(Person*(^)())run3
{
    return ^{
        NSLog(@"run3");
        return  self;
    };
}

-(Person*(^)())eat3{
    
    Person*(^block)() = ^{
        NSLog(@"eat3");
        return self;
    };
    return block;
}

-(Person*(^)(double distance))run4{
    Person*(^block)( double) = ^ (double distance ){
        NSLog(@"run4 : %lf",distance);
        return self;
    };
    return block;
}

-(Person*(^)(NSString *food))eat4
{
  return  ^ (NSString *food ){
        NSLog(@"eat4 : %@",food);
        return self;
    };
    
}

@end
