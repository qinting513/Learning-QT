//
//  ViewController.m
//  BuglyDemo
//
//  Created by Qinting on 2016/10/19.
//  Copyright © 2016年 QT. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self crashFunc];
}


- (void)crashFunc {
    NSString *str = nil;
    NSArray *array = @[@"11",str];
    NSLog(@"%@",array);
}


@end
