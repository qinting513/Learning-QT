//
//  UIImageView+Extension.m
//  异步裁切绘制圆角图片
//
//  Created by Qinting on 2016/11/7.
//  Copyright © 2016年 QT. All rights reserved.
//

#import "UIImageView+Extension.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Extension.h"

@implementation UIImageView (Extension)
/**加载圆角的网络图片 隔离SDWebImage，并设置了圆角图片 */
-(void)qt_setCircleImage:(NSString *)url placeholderImage:(UIImage *)placeholderImage{
   
    __weak typeof (self) weakSelf = self;
    if(url == nil){
        [placeholderImage qt_circleImageWithSize:self.bounds.size fillColor:[UIColor whiteColor] completion:^(UIImage *image) {
            weakSelf.image = image;
        }];
        return;
    }
    
   [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholderImage options:0 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
       /** 将图片获取到之后 再处理图片才显示出来 */
      [image qt_circleImageWithSize:self.frame.size fillColor:[UIColor whiteColor] completion:^(UIImage *image) {
         weakSelf.image = image;
      }];
    }];
}

/** 使用CAShapeLayer和UIBezierPath设置圆角 */
-(void)qt_circleImageView{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSTimeInterval start = CACurrentMediaTime();
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds                                                   byRoundingCorners:UIRectCornerAllCorners cornerRadii:self.bounds.size];
        
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
        //设置大小
        maskLayer.frame = self.bounds;
        //设置图形样子
        maskLayer.path = maskPath.CGPath;
    
        dispatch_async(dispatch_get_main_queue(), ^{
            self.layer.mask = maskLayer;
        });
        NSLog(@"==== %f",CACurrentMediaTime() - start);
    });
    
}
@end
