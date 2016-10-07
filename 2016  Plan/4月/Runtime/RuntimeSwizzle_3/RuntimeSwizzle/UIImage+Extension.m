//
//  UIImage+Extension.m
//  RuntimeSwizzle
//
//  Created by Qinting on 16/4/9.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "UIImage+Extension.h"
#import <objc/runtime.h>

@implementation UIImage (Extension)

/**
 *  只要分类被装载到内存中，就会调用1次
 */
+(void)load{
//首先获得方法
//    Method otherMethod = class_getClassMethod([UIImage class], @selector(imageWithNamed:));
//    Method originMethod = class_getClassMethod([UIImage class], @selector(imageNamed:));
//    
//    //再交换
//    method_exchangeImplementations(otherMethod, originMethod);
    
    [self swizzleClassMethod:[UIImage class] originSelector:@selector(imageNamed:) otherSelector:@selector(imageWithNamed:)];

}

+ (UIImage*)imageWithNamed:(NSString *)name{
   
    NSLog(@"currentDevice systemVersion：%@",[UIDevice currentDevice].systemVersion);
    
    BOOL isIOS7 = [[UIDevice currentDevice].systemVersion floatValue] >= 7.0;
    
    UIImage *image = nil;
    if (isIOS7 ) {
      NSString *newName = [name stringByAppendingString:@"_os7"];
        /** 
            在这里一定要用imageWithNamed方法 否则死循环
            当在ViewDidLoad中调用imageNamed时，程序跑到imageWithNamed即此方法中，
            然后下面一句执行imageWithNamed 时，就跳到了系统的imageNamed，就不循环了
         */
        image = [UIImage imageWithNamed:newName];
    }
    
    if (image == nil) {
        image = [UIImage imageWithNamed:name];
    }
    
    return image;
}



/** 交换2个 类方法 的封装 */
+ (void)swizzleClassMethod:(Class)class originSelector:(SEL)originSelector otherSelector:(SEL)otherSelector
{
    Method otherMehtod = class_getClassMethod(class, otherSelector);
    Method originMehtod = class_getClassMethod(class, originSelector);
    // 交换2个方法的实现
    method_exchangeImplementations(otherMehtod, originMehtod);
}

/** 交换2个 实例方法  的封装 */
+ (void)swizzleInstanceMethod:(Class)class originSelector:(SEL)originSelector otherSelector:(SEL)otherSelector
{
    Method otherMehtod = class_getInstanceMethod(class, otherSelector);
    Method originMehtod = class_getInstanceMethod(class, originSelector);
    // 交换2个方法的实现
    method_exchangeImplementations(otherMehtod, originMehtod);
}


//  数组越界，添加nil对象到数组中等问题的解决办法
//@implementation NSArray(Extension)
//+ (void)load
//{
//    [self swizzleInstanceMethod:NSClassFromString(@"__NSArrayI") originSelector:@selector(objectAtIndex:) otherSelector:@selector(hm_objectAtIndex:)];
//}
//
//- (id)hm_objectAtIndex:(NSUInteger)index
//{
//    if (index < self.count) {
//        return [self hm_objectAtIndex:index];
//    } else {
//        return nil;
//    }
//}
//
//@end
//
//@implementation NSMutableArray(Extension)
//+ (void)load
//{
//    [self swizzleInstanceMethod:NSClassFromString(@"__NSArrayM") originSelector:@selector(addObject:) otherSelector:@selector(hm_addObject:)];
//    [self swizzleInstanceMethod:NSClassFromString(@"__NSArrayM") originSelector:@selector(objectAtIndex:) otherSelector:@selector(hm_objectAtIndex:)];
//}
//
//- (void)hm_addObject:(id)object
//{
//    if (object != nil) {
//        [self hm_addObject:object];
//    }
//}
//
//- (id)hm_objectAtIndex:(NSUInteger)index
//{
//    if (index < self.count) {
//        return [self hm_objectAtIndex:index];
//    } else {
//        return nil;
//    }
//}
//@end

@end
