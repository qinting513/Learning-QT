//
//  Person.h
//  链式与函数式编程
//
//  Created by Qinting on 2016/10/29.
//  Copyright © 2016年 QT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

-(void)run1;
-(void)eat1;


-(Person*)run2;
-(Person *)eat2;

-(Person*(^)())run3;
-(Person*(^)())eat3;

-(Person*(^)(double distance))run4;
-(Person*(^)(NSString *food))eat4;
@end
