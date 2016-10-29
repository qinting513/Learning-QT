//
//  ViewController.m
//  01-Masonry框架分析
//
//  Created by yz on 15/10/17.
//  Copyright © 2015年 yz. All rights reserved.
//

#import "ViewController.h"

#import "Masonry.h"

@interface ViewController ()




@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 创建控件
    UIView *redView = [[UIView alloc] init];
    
    redView.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:redView];
    
    // 设置控件的约束
    [redView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        // 存放redView设置约束的代码
        
        make.left.top.equalTo(@10);
        
        make.right.bottom.equalTo(@-10);
        
        
    }];
    // 创建约束制造者
    // 执行block
    // 按照约束
    
    // 链式编程：返回值是block
}


@end
