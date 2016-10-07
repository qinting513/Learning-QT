//
//  CategoryModel.h
//  QTGameLive
//
//  Created by Qinting on 16/4/17.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import <Foundation/Foundation.h>
/** 
 解析规则：
 1.遇到字典则新建类
 2.修改不规则命名
 */

/** 使用YYKit 可以不用重写setValue forUndefineKey方法,在pch引入头文件了 */

/** 根是数组的情况 */
@interface CategoryModel : NSObject

//first_letter >> firstLetter
@property (nonatomic, copy) NSString *firstLetter;

@property (nonatomic, assign) NSInteger prompt;

@property (nonatomic, copy) NSString *slug;

//id >> ID
@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, copy) NSString *image;

@property (nonatomic, copy) NSString *thumb;

@property (nonatomic, copy) NSString *name;


@end
