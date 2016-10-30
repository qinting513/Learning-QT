//
//  UIImage+Extension.h
//  异步裁切绘制圆角图片
//
//  Created by Qinting on 2016/10/30.
//  Copyright © 2016年 QT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)
/** 根据当前图像，和指定尺寸，生成圆角图像并且返回绘制的图像 */
-(UIImage *)qt_circleImageWithSize:(CGSize)size fillColor:(UIColor *)fillColor;

@end
