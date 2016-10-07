//
//  ViewController.m
//  TestDemo
//
//  Created by Qinting on 16/8/2.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "ViewController.h"
#import "ChangeLayoutView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ChangeLayoutView *view = [[ChangeLayoutView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:view];
}

@end
