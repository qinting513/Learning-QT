//
//  Person.h
//  UnitTestDemo
//
//  Created by Qinting on 2016/11/17.
//  Copyright © 2016年 QT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject
@property (nonatomic,strong) NSString  *name;
@property (nonatomic,assign) NSInteger  age;

+(instancetype)personWithDict:(NSDictionary*)dict;

@end
