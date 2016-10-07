//
//  ViewController.m
//  UIStackView
//
//  Created by Qinting on 16/5/8.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "ViewController.h"
#import "ShareViewController.h"

@interface ViewController ()
- (IBAction)shareButtonClick:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)shareButtonClick:(id)sender {
    ShareViewController *shareVC = [[ShareViewController alloc]init];
    [self presentViewController:shareVC animated:YES completion:nil];
}
@end
