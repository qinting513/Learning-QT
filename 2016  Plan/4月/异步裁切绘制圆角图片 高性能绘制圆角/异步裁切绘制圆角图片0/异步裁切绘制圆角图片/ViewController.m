//
//  ViewController.m
//  异步裁切绘制圆角图片
//
//  Created by Qinting on 2016/10/30.
//  Copyright © 2016年 QT. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

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
 
 如果直接显示原图大小，没有缩放，没有混合图层，
 则系统不需要进行图片压缩、混合图层的计算等操作，可减小内存消耗
 */


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    UIImageView *iv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 200, 200)];
    [self.view addSubview:iv];
    iv.center = self.view.center;
    
    iv.image = [UIImage imageNamed:@"5.jpg"];
    
    iv.layer.cornerRadius = iv.frame.size.width * 0.5;
    iv.layer.masksToBounds = YES;
}


@end
