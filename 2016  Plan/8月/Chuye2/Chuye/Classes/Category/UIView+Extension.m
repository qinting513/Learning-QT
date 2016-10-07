//
//  UIView+Extension.m
//  CustomCell
//
//  Created by Qinting on 16/7/14.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)

#pragma mark - 设置属性
-(CGFloat)x
{
    return self.frame.origin.x;
}

-(void)setX:(CGFloat)x
{
    CGRect frame  = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

-(CGFloat)y
{
    return self.frame.origin.y;
}

-(void)setY:(CGFloat)y{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

-(CGFloat)centerX
{
    return  self.center.x;
}

-(void)setCenterX:(CGFloat)centerX
{
    self.center = CGPointMake(centerX, self.center.y);
}

-(CGFloat)centerY
{
    return self.center.y;
}

-(void)setCenterY:(CGFloat)centerY
{
    self.center = CGPointMake(self.center.x, centerY);
}

/** 设置不了中心点 */
//-(CGPoint)center
//{
//    return CGPointMake(self.centerX, self.centerY);
//}
//
//-(void)setCenter:(CGPoint)center
//{
//    CGPoint  p =  self.center;
//    p.x = center.x;
//    p.y = center.y;
//    self.center = p;
//}

-(CGFloat)width{
    return self.frame.size.width;
}
-(void)setWidth:(CGFloat)width
{
    CGRect frame  = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

-(CGFloat)height{
    return self.frame.size.height;
}

-(void)setHeight:(CGFloat)height
{
    CGRect frame  =  self.frame;
    frame.size.height  = height;
    self.frame = frame;
}

-(CGPoint)origin{
    return self.frame.origin;
}

-(void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

-(CGSize)size{
    return self.frame.size;
}

-(void)setSize:(CGSize)size{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

#pragma mark - 方法
/** 设置正方形图片的圆角 */
-(void)circleImage
{
//    assert(self.width == self.height);
    if (self.width != self.height) {
        self.height = self.width;
    }
    [self circleImageWithBorderWidth:1  borderColor:[UIColor lightGrayColor]];
}

/**
 *  设置矩形图片的圆角
 *
 *  @param borderWidth 边框宽度
 *  @param bordColor     边框颜色
 */
-(void)circleImageWithBorderWidth:(CGFloat)borderWidth  borderColor:(UIColor*)borderColor
{
    [self circleImageWithCornerRadius:self.width*0.5 borderWidth:borderWidth borderColor:borderColor];
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
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    
    //获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //    添加一个圆     Ellipse：椭圆
    CGRect rect = CGRectMake(0, 0, self.width, self.height);
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
