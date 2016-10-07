//
//  UIView+Extension.h
//  CustomCell
//
//  Created by Qinting on 16/7/14.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)

/** 与左边的距离*/
@property (nonatomic) CGFloat x;
/** 与顶部的距离 */
@property (nonatomic) CGFloat y;

/** 中心点的X */
@property (nonatomic) CGFloat centerX;
/** 中心点点Y */
@property (nonatomic) CGFloat centerY;

/** 宽度 */
@property (nonatomic) CGFloat width;
/** 高度 */
@property (nonatomic) CGFloat height;

/** 左上角原点 */
@property (nonatomic) CGPoint origin;
/** 中心点    *//** 设置不了中心点 */
//@property (nonatomic) CGPoint center;

/** 宽高 */
@property (nonatomic) CGSize size;

/** 设置正方形图片的圆角 */
-(void)circleImage;

/**
 *  设置矩形图片的圆角
 *
 *  @param borderWidth 边框宽度
 *  @param bordColor     边框颜色
 */
-(void)circleImageWithBorderWidth:(CGFloat)borderWidth  borderColor:(UIColor*)bordColor;
/**
 *  设置图片的圆角
 *
 *  @param cornerRadius  圆角半径
 *  @param borderWidth  线宽
 *  @param bordColor    线的颜色
 */
-(void)circleImageWithCornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth  borderColor:(UIColor*)bordColor;

/** 绘制后返回圆角图片
       使用：   self.iconImageView.image =[self.iconImageView round];   */
- (UIImage*)round;
@end
