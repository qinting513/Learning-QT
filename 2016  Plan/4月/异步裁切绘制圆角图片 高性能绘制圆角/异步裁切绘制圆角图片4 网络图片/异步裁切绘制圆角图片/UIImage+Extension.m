//
//  UIImage+Extension.m
//  异步裁切绘制圆角图片
//
//  Created by Qinting on 2016/10/30.
//  Copyright © 2016年 QT. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)

/** 如何回调： block 
    block最多的应用场景就是异步执行完成之后，通过参数回调 通知调用方结果。
 */
-(void)qt_circleImageWithSize:(CGSize)size
       fillColor:(UIColor *)fillColor
      completion:(void(^)(UIImage *image))completion {
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
//        NSTimeInterval start = CACurrentMediaTime();
        
        //1.利用绘图，建立上下文  YES 表示不透明 0 表示不缩放
        UIGraphicsBeginImageContextWithOptions(size, YES, 0);
        
        //2.利用贝塞尔路径 裁切
        CGRect rect = CGRectMake(0, 0, size.width, size.height);
        
        //2.1先填充 后裁切 才有效
        if (fillColor == nil) {
            [[UIColor whiteColor] setFill];
        }else{
            [fillColor setFill];
        }
        UIRectFill(rect);
        
        // 2.2绘制长高相等的椭圆
        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rect];
        // 2.3 裁切
        [path addClip];
        
        //    //先填充 后裁切 才有效
        //    [fillColor setFill];
        //    UIRectFill(rect);
        
        //3.绘制图像
        [self drawInRect:rect];

        //4.取得图片
        UIImage *resultImg = UIGraphicsGetImageFromCurrentImageContext();
        
        //5.关闭上下文
        UIGraphicsEndImageContext(); 
        
//        NSLog(@"==== %f",CACurrentMediaTime() - start);
       
        // 6.完成回调
        dispatch_async(dispatch_get_main_queue(), ^{
//            completion(resultImg);
            // 空合运算符  一定要判断block是否存在 否则崩溃
            !completion ?: completion(resultImg);
        });
    });
}


@end
