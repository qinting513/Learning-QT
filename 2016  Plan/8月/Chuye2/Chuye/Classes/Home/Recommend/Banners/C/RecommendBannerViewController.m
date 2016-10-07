//
//  RecommendBannerViewController.m
//  Chuye
//
//  Created by Qinting on 16/8/16.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "RecommendBannerViewController.h"

@interface RecommendBannerViewController ()
@property (nonatomic,strong) UIWebView  *webView;
@end

@implementation RecommendBannerViewController

-(BOOL)prefersStatusBarHidden{
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:self.webView];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    
    UIButton *btn = [UIButton buttonWithType:0];
    btn.frame = CGRectMake(10, 20, 30, 30);
    [btn setImage:[UIImage imageNamed:@"deleteBtn"] forState:UIControlStateNormal];
    [btn addTarget:self  action:@selector(comeBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}


-(void)comeBack{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
