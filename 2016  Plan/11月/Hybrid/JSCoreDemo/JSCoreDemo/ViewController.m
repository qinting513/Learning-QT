//
//  ViewController.m
//  JSCoreDemo
//
//  Created by Qinting on 2016/11/25.
//  Copyright © 2016年 QT. All rights reserved.
//

#import "ViewController.h"
#import "DetailTableViewController.h"

#import <JavaScriptCore/JavaScriptCore.h>

@interface ViewController ()<UIWebViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    UIWebView *webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:webView];
    webView.delegate = self;
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://m.dianping.com/tuan/deal/5501525"]]];
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSLog(@"点击了图片");
    JSContext *context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    context[@"share"] = ^(){
        DetailTableViewController *vc = [[DetailTableViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    };
    return YES;
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    NSMutableString *stringM = [NSMutableString string];
    [stringM appendString:@"var head = document.getElementsByTagName(\"header\")[0]; head.parentNode.removeChild(head);"];
    //   [stringM appendString:@"var head = document.getElementsByTagName(\"header\")[0]; head.style.display='none';"];
    [stringM appendString:@"var footer = document.getElementsByClassName(\"footer-btn-fix\")[0];footer.parentNode.removeChild(footer);"];
    [stringM appendString:@"var footer = document.getElementsByClassName(\"footer\")[0]; footer.parentNode.removeChild(footer);"];
    [stringM appendString:@"var img = document.getElementsByTagName(\"figure\")[0].children[0]; img.onclick=function imgClick(){ share() }"];
    
    /*
     function imgClick(){
        share();
     }
     */
    //获取上下文
    JSContext *context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    // 执行js代码
    [context evaluateScript:stringM];
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
