//
//  NSObject+Extension.m
//  02-了解-网页开发
//
//  Created by xiaomage on 15/7/16.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "NSObject+Extension.h"

@implementation NSObject (Extension)
- (id)performSelector:(SEL)selector withObjects:(NSArray *)objects
{
    // 方法签名(方法的描述)
    NSMethodSignature *signature = [[self class] instanceMethodSignatureForSelector:selector];
    if (signature == nil) {
        //        @throw [NSException exceptionWithName:@"牛逼的错误" reason:@"方法找不到" userInfo:nil];
        [NSException raise:@"牛逼的错误" format:@"%@方法找不到", NSStringFromSelector(selector)];
    }
    
    // NSInvocation : 利用一个NSInvocation对象包装一次方法调用（方法调用者、方法名、方法参数、方法返回值）
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    invocation.target = self;
    invocation.selector = selector;
    
    // 设置参数
    NSInteger paramsCount = signature.numberOfArguments - 2; // 除self、_cmd以外的参数个数
    paramsCount = MIN(paramsCount, objects.count);
    for (NSInteger i = 0; i < paramsCount; i++) {
        id object = objects[i];
        if ([object isKindOfClass:[NSNull class]]) continue;
        [invocation setArgument:&object atIndex:i + 2];
    }
    
    // 调用方法
    [invocation invoke];
    
    // 获取返回值
    id returnValue = nil;
    if (signature.methodReturnLength) { // 有返回值类型，才去获得返回值
        [invocation getReturnValue:&returnValue];
    }
    
    return returnValue;
}
@end
