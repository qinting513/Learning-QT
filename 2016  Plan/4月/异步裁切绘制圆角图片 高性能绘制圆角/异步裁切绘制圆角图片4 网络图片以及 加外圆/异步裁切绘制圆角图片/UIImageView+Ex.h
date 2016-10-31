//
//  UIImageView+Ex.h
//  异步裁切绘制圆角图片
//
//  Created by Qinting on 2016/10/31.
//  Copyright © 2016年 QT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Ex)

/// 给ImageView 添加一个圆
-(void)qt_addCircleWithLineWidth:(CGFloat)lineWidth strokeColor:(UIColor*)color;

/// 加载本地图片 并绘制圆角 以及 画一个边框圆
-(void)qt_circleImageWithImageName:(NSString *)imageName
                   circleLineWidth:(CGFloat)lineWidth
                 circleStrokeColor:(UIColor*)strokeColor;

/// 绘制圆角的ImageView
-(void)qt_circleImageView;
@end
