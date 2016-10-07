//
//  Dish.h
//  菜谱大全
//
//  Created by tarena on 16/4/12.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Dish : NSObject
@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSArray *burden;
@property (nonatomic, copy)NSString *imtro;
@property (nonatomic, copy)NSString *ingredients;
@property (nonatomic, copy)NSString *albums;
//如果出现了可变数组 通常会在对象初始化时让数组初始化
@property (nonatomic, strong)NSMutableArray *steps;
@end
