//
//  Student+Action.h
//  RuntimeCategoryProperty
//
//  Created by Qinting on 16/4/9.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "Student.h"

@interface Student (Action)

-(void)sayHello;

/** 在分类中添加属性 */
@property (nonatomic,copy) NSString *name;

@end
