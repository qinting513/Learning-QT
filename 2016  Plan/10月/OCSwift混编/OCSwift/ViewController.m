//
//  ViewController.m
//  OCSwift
//
//  Created by Qinting on 2016/11/9.
//  Copyright © 2016年 QT. All rights reserved.
//

#import "ViewController.h"


/**  #import "工程名-Swift.h"*/
#import "OCSwift-Swift.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self useSwiftMethod];
}

/**
 *  OC里面调用swift方法
 */
- (void)useSwiftMethod{
    SwiftClass * wigt = [[SwiftClass alloc] init];
    NSLog(@"%@",wigt.returnSwiftName);
}


- (void)getOneMethodForSwift {
    NSLog(@"这是在OC中的方法 -- swift中调用OC的方法");
}


@end
