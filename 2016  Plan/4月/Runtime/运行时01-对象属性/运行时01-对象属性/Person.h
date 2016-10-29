//
//  Person.h
//  运行时01-对象属性
//
//  Created by Qinting on 2016/10/29.
//  Copyright © 2016年 QT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject
@property (nonatomic,strong) NSString  *name;
@property (nonatomic,assign) NSInteger age;
@property (nonatomic,assign) float height;
@property (nonatomic,strong) NSArray  *songs;
@end

