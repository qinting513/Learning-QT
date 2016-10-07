//
//  NSObject+ViewModel.m
//  TRProject
//
//  Created by tarena on 16/2/18.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "NSObject+ViewModel.h"
//通过运行时,解决Category不能定义属性的弱点
#import <objc/runtime.h>
@implementation NSObject (ViewModel)
//通过运行时, 动态绑定实现属性的setter方法
- (void)setDataTask:(NSURLSessionDataTask *)dataTask{
    //参数4:属性的内存管理方式
    objc_setAssociatedObject(self, @selector(dataTask), dataTask, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSURLSessionDataTask *)dataTask{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)getDataWithRequestMode:(RequestMode)requestMode completionHandler:(void (^)(NSError *))completionHandler{}

- (void)resumeTask{
    [self.dataTask resume];
}
- (void)cancelTask{
    [self.dataTask cancel];
}
- (void)suspendTask{
    [self.dataTask suspend];
}
@end
