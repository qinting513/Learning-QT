//
//  NSObject+Runtime.h
//  运行时01-对象属性
//
//  Created by Qinting on 2016/10/29.
//  Copyright © 2016年 QT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface NSObject (Runtime)
/** 获取属性列表 */
+(NSArray *)qt_objProperties;
/** 字典转模型 */
+(instancetype)qt_objWithDict:(NSDictionary*)dict;
@end
