//
//  ViewController.m
//  SecurityTest
//
//  Created by Jone' on 16/4/22.
//  Copyright © 2016年 Jone. All rights reserved.
//

#import "ViewController.h"
#import "SecurityUtil.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSString *str = @"we are hero!";//汉字需转码
    
    NSString *enStr = [SecurityUtil encryptRSAPublicKeyWithString:str];
    NSLog(@"enStr:%@",enStr);
    NSString *deStr = [SecurityUtil decryptRSAPrivateKeyWithString:enStr];
    NSLog(@"deStr:%@",deStr);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
