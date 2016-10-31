//
//  UIImageView+Ex.m
//  异步裁切绘制圆角图片
//
//  Created by Qinting on 2016/10/31.
//  Copyright © 2016年 QT. All rights reserved.
//

#import "UIImageView+Ex.h"

@implementation UIImageView (Ex)

-(void)qt_addCircleWithLineWidth:(CGFloat)lineWidth strokeColor:(UIColor*)strokeColor;{
    
        CAShapeLayer *solidLine =  [CAShapeLayer layer];
        CGMutablePathRef solidPath =  CGPathCreateMutable();
        solidLine.lineWidth = lineWidth ;
        solidLine.strokeColor = strokeColor.CGColor;
        solidLine.fillColor = [UIColor clearColor].CGColor;
        CGPathAddEllipseInRect(solidPath, nil, CGRectMake(-10 ,
                                                          -10,
                                                          self.bounds.size.width + 20 ,
                                                          self.bounds.size.height + 20 ));
        solidLine.path = solidPath;
        CGPathRelease(solidPath);
        [self.layer addSublayer:solidLine];
}


// 先将Image绘制好
-(void)qt_circleImageWithImageName:(NSString *)imageName
                    fillColor:(UIColor *)fillColor
                   circleLineWidth:(CGFloat)lineWidth
                  circleStrokeColor:(UIColor*)strokeColor {
  
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
         UIImage *image = [UIImage imageNamed:imageName];
        //        NSTimeInterval start = CACurrentMediaTime();
        
        //1.利用绘图，建立上下文  YES 表示不透明 0 表示不缩放
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, YES, 0);
        
        //2.利用贝塞尔路径 裁切
        CGRect rect = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
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
        
        //3.绘制图像
        [image drawInRect:rect];
        
        
        //4.取得图片
        UIImage *resultImg = UIGraphicsGetImageFromCurrentImageContext();
        
        //5.关闭上下文
        UIGraphicsEndImageContext();
        
        //        NSLog(@"==== %f",CACurrentMediaTime() - start);
        
        // 画圆
        [self qt_addCircleWithLineWidth:lineWidth strokeColor:strokeColor];
        
        // 6.完成回调
        dispatch_async(dispatch_get_main_queue(), ^{

            self.image = resultImg;
        });
    });
}

-(void)qt_circleImageWithImageName:(NSString *)imageName
                   circleLineWidth:(CGFloat)lineWidth
                 circleStrokeColor:(UIColor*)strokeColor {
    
    [self qt_circleImageWithImageName:imageName fillColor:nil circleLineWidth:lineWidth circleStrokeColor:strokeColor];
}



/**第三种方法： 使用CAShapeLayer和UIBezierPath设置圆角 */
//-(void)qt_circleImageView{
//    
//    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds                                                   byRoundingCorners:UIRectCornerAllCorners cornerRadii:self.bounds.size];
//    
//    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
//    //设置大小
//    maskLayer.frame = self.bounds;
//    //设置图形样子
//    maskLayer.path = maskPath.CGPath;
//    self.layer.mask = maskLayer;
//}

-(void)qt_circleImageView{
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds                                                   byRoundingCorners:UIRectCornerAllCorners cornerRadii:self.bounds.size];

    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    //设置大小
    maskLayer.frame = self.bounds;
    //设置图形样子
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
    
    
    CAShapeLayer *solidLine =  [CAShapeLayer layer];
    CGMutablePathRef solidPath =  CGPathCreateMutable();
    solidLine.lineWidth = 5.0f ;
    solidLine.strokeColor = [UIColor redColor].CGColor;
    solidLine.fillColor = [UIColor clearColor].CGColor;
    CGPathAddEllipseInRect(solidPath, nil, CGRectMake(0,
                                                      0,
                                                      self.bounds.size.width ,
                                                      self.bounds.size.height));
    solidLine.path = solidPath;
    CGPathRelease(solidPath);
    [self.layer addSublayer:solidLine];
}

@end



/**
 模拟器 debug下的：
 1.Color Misaligned Images：
 当图片的像素大小与控件的大小不一致而导致需要缩放时，图片会呈现黄色。
 我们希望不要出现黄色。
 
 2.Color Blended Layers
 举个例子：
 一个View上层是蓝色(RGB=0,0,1),透明度为50%，下层是红色(RGB=1,0,0)。那么最终的显示效果是紫色(RGB=0.5,0,0.5)。
 这种颜色的混合(blended)需要消耗一定的GPU资源，在实际开发中可能不止只有两层。
 如果只想显示最上层的颜色，可以把它的透明度设置为100%，这样GPU会忽略下面所有的layer，
 从而节约了很多不必要的运算。
 我们希望红色越少越好，绿色越多性能越好。
 http://www.tuicool.com/articles/aMVjQjQ
 
 
 
 面试题： 如何绘制一个圆形的图像， 不要和我说 cornerRadius
 在表格优化中，有一点，不要动态的修改‘cornerRadius’之类的图层渲染相关的属性.
 
 tableView Cell 出来的时候的事情：
 1.从缓冲池获取可重用Cell
 2.设置模型
 3.不停上下滑动cell，如果设置圆角图层属性，在界面上会不停重绘 --> 性能不好
 
 如果直接显示原图大小，没有缩放，没有混合图层，
 则系统不需要进行图片压缩、混合图层的计算等操作，可减小内存消耗
 
 关于混合图层：
 // UIColor：使用颜色不能带alpha透明度！使用透明度颜色会严重影响性能！
 把后面灰色的画出来。然后计算叠加的面积多大，还要计算2种颜色叠加后的颜色是什么，
 然后才绘制叠加和非叠加部分
 除了UILabel之外，其他的出现混合模式的视图，比如button，都可以做文章
 为了解决UILabel的问题，有些框架会自己创建一个Label，例如YYText。
 */

/**
 高级程序员 养成记：考虑app性能！
 1.block回调的使用场景
 2.日常开发中什么时候用到多线程
 3.如何绘制一个圆形的图像， 不要和我说 cornerRadius
 */
