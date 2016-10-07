//
//  ViewController.m
//  RuntimeCategoryProperty
//
//  Created by Qinting on 16/4/9.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "ViewController.h"
#import "Student.h"
#import "Student+Action.h"

#import "UIImage+qt.h"

@interface ViewController ()

@end

@implementation ViewController

/** 
 1.一个是自定义类的分类里面添加 字符串属性
 2.一个是系统  类的分类里面添加 int类型属性
 
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Student *stu = [[Student alloc]init];
     /** 为这个在分类中声明的属性赋值 */
    stu.name = @"Bill";
    /** 调用方法 查看是否设置名字成功 */
    [stu sayHello];
    
    UIImage *image = [UIImage imageNamed:@"vip_os7"];
    image.num = 8;
    [image getImageNum];
}


@end
