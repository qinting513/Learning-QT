//
//  ViewController.m
//  Runtime_setTextFieldPlaceholderColor
//
//  Created by Qinting on 16/5/29.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>

@interface ViewController ()

@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    [self setPlaceholderColor:[UIColor grayColor]];
    
}



-(BOOL)becomeFirstResponder{
    NSLog(@"becomeFirstResponder");
    [self setPlaceholderColor:[UIColor grayColor]];
    return [super becomeFirstResponder];
}

-(void)setPlaceholderColor:(UIColor*)color{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName] = color;
    
    /** 进入api找到 */
    NSAttributedString *placeholder = [[NSAttributedString alloc]initWithString:@"密码" attributes:dict
                                       ];
    self.passwordField.attributedPlaceholder = placeholder;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
