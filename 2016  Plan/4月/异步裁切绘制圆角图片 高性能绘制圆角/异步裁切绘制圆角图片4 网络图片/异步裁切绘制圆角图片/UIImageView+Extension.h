//
//  UIImageView+Extension.h
//  异步裁切绘制圆角图片
//
//  Created by Qinting on 2016/11/7.
//  Copyright © 2016年 QT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Extension)
/**加载圆角的网络图片 隔离SDWebImage，并设置了圆角图片 */
-(void)qt_setCircleImage:(NSString *)url placeholderImage:(UIImage *)placeholderImage;

/** 对UIImageView进行圆角处理 */
-(void)qt_circleImageView;
@end
