//
//  ViewController.m
//  UIMenuControllerDemo
//
//  Created by Qinting on 16/7/10.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "ViewController.h"
#import "QTLabel.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://baidu.com"]]];
    [self.webView loadHTMLString:@"<div>hahahahhahah </div>" baseURL:nil];
//    QTLabel   *label = [[QTLabel alloc]initWithFrame:CGRectMake(100, 200, 200, 400)];
//    label.backgroundColor = [UIColor purpleColor];
//    label.text = @"    QTLabel   *label = [[QTLabel alloc]initWithFrame:CGRectMake(100, 200, 200, 400)]; ";
//    label.numberOfLines = 0;
//    [self.view addSubview:label];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
