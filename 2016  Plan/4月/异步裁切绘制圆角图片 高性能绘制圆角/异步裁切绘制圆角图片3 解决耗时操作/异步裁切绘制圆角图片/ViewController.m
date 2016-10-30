//
//  ViewController.m
//  异步裁切绘制圆角图片
//
//  Created by Qinting on 2016/10/30.
//  Copyright © 2016年 QT. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+Extension.h"
@interface ViewController ()

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    UIImageView *iv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 200, 200)];
    [self.view addSubview:iv];
    iv.center = self.view.center;
    
//    iv.image = [UIImage imageNamed:@"5.jpg"];
//    iv.layer.cornerRadius = iv.frame.size.width * 0.5;
//    iv.layer.masksToBounds = YES;
    
    UIImage *img = [UIImage imageNamed:@"5.jpg"];
//    iv.image = [img qt_circleImageWithSize:iv.bounds.size fillColor:[UIColor whiteColor]];
    
    [img qt_circleImageWithSize:iv.bounds.size fillColor:[UIColor whiteColor] completion:^(UIImage *image) {
        iv.image = image;
    }];
    
    
}



@end
