//
//  UIView+Round.m
//  Chuye
//
//  Created by Qinting on 16/8/18.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "UIView+Round.h"

@implementation UIView (Round)

#pragma mark - 方法
/** 设置正方形图片的圆角 */
-(void)circleImage
{
    //    assert(self.width == self.height);
    if (self.frame.size.width != self.frame.size.height) {
        self.bounds = CGRectMake(0, 0, self.frame.size.width, self.frame.size.width);
    }
    [self circleImageWithBorderWidth:1  borderColor:[UIColor yellowColor]];
}

/**
 *  设置矩形图片的圆角
 *
 *  @param borderWidth 边框宽度
 *  @param bordColor     边框颜色
 */
-(void)circleImageWithBorderWidth:(CGFloat)borderWidth  borderColor:(UIColor*)borderColor
{
    [self circleImageWithCornerRadius:self.frame.size.width*0.5 borderWidth:borderWidth borderColor:borderColor];
}
/**
 *  设置图片的圆角
 *
 *  @param cornerRadius  圆角半径
 *  @param borderWidth  线宽
 *  @param bordColor    线的颜色
 */
-(void)circleImageWithCornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth  borderColor:(UIColor*)bordColor
{
    self.layer.cornerRadius = cornerRadius;
    self.layer.borderColor = bordColor.CGColor;
    self.layer.borderWidth = borderWidth;
    self.layer.masksToBounds = YES;
    
}


/** 高效的设置圆形图片 */
- (UIImage*)round
{
    //NO 代表透明
    UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 0.0);
    
    //获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //    添加一个圆     Ellipse：椭圆
    CGRect rect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    CGContextAddEllipseInRect(ctx, rect);
    //    剪切
    CGContextClip(ctx);
    
    //    将图片画上去
    [self drawRect:rect];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


@end

