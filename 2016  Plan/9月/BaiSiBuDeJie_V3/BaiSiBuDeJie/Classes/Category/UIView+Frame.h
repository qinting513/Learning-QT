//
//  UIView+Frame.h
//  FullScreenWhenScroll
//
//  Created by Qinting on 16/3/23.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)

@property (nonatomic) CGFloat left;
@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat right;
@property (nonatomic) CGFloat bottom;

@property (nonatomic) CGFloat centerX;
@property (nonatomic) CGFloat centerY;

@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;

@property (nonatomic) CGPoint origin;
@property (nonatomic) CGSize size;

/** 设置正方形图片的圆角 */
-(void)round;
/** 设置矩形图片的圆角 */
-(void)round:(CGFloat)borderWith  bordColor:(UIColor*)bordColor;
/** 设置图片的圆角 */
-(void)roundRectCornerRadius:(CGFloat)cornerRadius borderWith:(CGFloat)borderWith  bordColor:(UIColor*)bordColor;

@end
