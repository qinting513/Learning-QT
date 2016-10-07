//
//  ViewController.m
//  RuntimeSwizzle
//
//  Created by Qinting on 16/4/9.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "ViewController.h"
#import <objc/message.h>
#import <objc/runtime.h>

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *icon1;
@property (weak, nonatomic) IBOutlet UIImageView *icon2;


@end

@implementation ViewController


/** 需求 在ios6时显示这2张图片，在ios7以上 显示另外2张图片
 
 方法1:以前，先判断 再赋值
 
 方法2: 而现在 来个更高级的 修改系统的方法，修改指针的指向
*/

-(void)imageSwizzle{

    // 什么是iOS Swizzle？利用运行时函数交换2个方法的实现（但使用 需谨慎）
    
    //如果有1000处需要这样 就要判断1000次
    //    BOOL iOS7 = [[UIDevice currentDevice].systemVersion floatValue] >= 7.0;
    //    if (iOS7) {
    //        self.icon1.image = [UIImage imageNamed:@"face_os7"];
    //        self.icon2.image = [UIImage imageNamed:@"vip_os7"];
    //    } else {
    //        self.icon1.image = [UIImage imageNamed:@"face"];
    //        self.icon2.image = [UIImage imageNamed:@"vip"];
    //    }
    
   
    
    self.icon1.image = [UIImage imageNamed:@"face"];
    self.icon2.image = [UIImage imageNamed:@"vip"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self imageSwizzle];
    
}


@end
