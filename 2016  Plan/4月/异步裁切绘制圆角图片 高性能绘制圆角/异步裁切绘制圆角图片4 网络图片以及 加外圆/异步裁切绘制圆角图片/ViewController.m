//
//  ViewController.m
//  异步裁切绘制圆角图片
//
//  Created by Qinting on 2016/10/30.
//  Copyright © 2016年 QT. All rights reserved.
//

#import "ViewController.h"
#import "UIImageView+WebCache.h"
#import "UIImageView+Ex.h"

@interface ViewController ()

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
 
  
    UIImageView *iv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 150, 150)];
    [self.view addSubview:iv];
    iv.center = self.view.center;
    [iv sd_setImageWithURL:[NSURL URLWithString:@"http://static.cnbetacdn.com/article/2016/1031/967464d3efa8f88.jpg"]];
    [iv qt_circleImageView];
    
    /** 添加边框圆 */
//    [iv qt_circleImageWithImageName:@"5.jpg" circleLineWidth:2.0f circleStrokeColor:[UIColor redColor]];
 
}



@end
