//
//  ViewController.m
//  运行时01-对象属性
//
//  Created by Qinting on 2016/10/29.
//  Copyright © 2016年 QT. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "NSObject+Runtime.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *properties = [Person qt_objProperties];
    NSLog(@"%@",properties);
    Person *person = [Person qt_objWithDict:@{
                                              @"name":@"aaa",
                                              @"age":@12,
                                              @"height":@14.0
                                              }];
    NSLog(@"person: %@",person);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
