//
//  ViewController.m
//  异步裁切绘制圆角图片
//
//  Created by Qinting on 2016/10/30.
//  Copyright © 2016年 QT. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+Extension.h"
#import "UIImageView+Extension.h"
#import "UIImageView+WebCache.h"
@interface ViewController ()

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    UIImageView *iv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 200, 200)];
    [self.view addSubview:iv];
    iv.center = self.view.center;
    
    
//    UIImage *img = [UIImage imageNamed:@"5.jpg"];
//    [img qt_circleImageWithSize:iv.bounds.size fillColor:[UIColor whiteColor] completion:^(UIImage *image) {
//        iv.image = image;
//    }];
//
    
    /** 网络图片 */
//    [iv qt_setCircleImage:@"http://static.cnbetacdn.com/article/2016/1031/967464d3efa8f88.jpg" placeholderImage:[UIImage imageNamed:@"5.jpg"]];

    [iv sd_setImageWithURL:[NSURL URLWithString:@"http://static.cnbetacdn.com/article/2016/1031/967464d3efa8f88.jpg"] placeholderImage:[UIImage imageNamed:@"5.jpg"]];
    [iv qt_circleImageView];
}



@end
