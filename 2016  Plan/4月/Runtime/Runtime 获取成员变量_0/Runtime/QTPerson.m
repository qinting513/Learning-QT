//
//  QTPerson.m
//  Runtime
//
//  Created by Qinting on 16/4/9.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "QTPerson.h"
#import <objc/runtime.h>

@implementation QTPerson

 /** 归档，需遵守NSCoding协议 */
- (void)encodeWithCoder:(NSCoder *)encoder
{
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([QTPerson class], &count);
    for (int i = 0; i<count; i++) {
        // 取得i位置的成员变量
        Ivar ivar = ivars[i];
        
        const char *name = ivar_getName(ivar);
        NSString *key = [NSString stringWithUTF8String:name];
        //先取得成员变量 再encodeObject
        [encoder encodeObject:[self valueForKeyPath:key] forKey:key];
    }
}

- (id)initWithCoder:(NSCoder *)aDecoder {
        if (self = [super init]) {
            
            self.name =  [aDecoder decodeObjectForKey:@"name"];
            self.age = [[aDecoder decodeObjectForKey:@"age"] intValue];
        }
        return self;
        
    }
    




@end
