//
//  ViewController.m
//  ReactiveCocoa
//
//  Created by yz on 15/9/23.
//  Copyright © 2015年 yz. All rights reserved.
//

#import "ViewController.h"

#import "ReactiveCocoa.h"



@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *labelView;
@property (weak, nonatomic) IBOutlet UITextField *textField;



@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
   
    // RAC:给某个类的某个属性绑定一个信号，只要接收信号，就改变这个类的属性
    // 只要文本框文字改变，就会修改label的文字
    RAC(self.labelView,text) = _textField.rac_textSignal;
    
    
    // 监听某个对象的某个属性转换为信号
    [RACObserve(self.view, center) subscribeNext:^(id x) {
      
        NSLog(@"%@",x);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
