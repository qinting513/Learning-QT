//
//  NSObject+Extension.h
//  02-了解-网页开发
//
//  Created by xiaomage on 15/7/16.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Extension)
- (id)performSelector:(SEL)selector withObjects:(NSArray *)objects;
@end
