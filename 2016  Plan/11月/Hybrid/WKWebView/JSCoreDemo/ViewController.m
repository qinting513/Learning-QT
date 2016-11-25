//
//  ViewController.m
//  JSCoreDemo
//
//  Created by Qinting on 2016/11/25.
//  Copyright © 2016年 QT. All rights reserved.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>
#import "TestViewController.h"

//  WKNavigationDelegate主要实现了涉及到导航跳转方面的回调方法
//  WKUIDelegate主要实现了涉及到界面显示的回调方法：如WKWebView的改变和js相关内容
@interface ViewController ()<WKNavigationDelegate>
@property (nonatomic,strong) WKWebView   *webView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    WKWebView *webView = [[WKWebView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview: webView];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://m.dianping.com/tuan/deal/5501525"]]];
    webView.navigationDelegate = self;
}

// 网页即将开始加载时调用 拦截标签点击时主动发送的请求
-(void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    NSString *urlStr = navigationAction.request.URL.absoluteString;

    if([urlStr isEqualToString:@"http://mycustomurl.com/"]){
        NSLog(@"=============%@",urlStr);
        TestViewController *vc = [TestViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }
    decisionHandler(WKNavigationActionPolicyAllow);// 成功后的回调，相当于UIWebView里的return YES；
}

// 页面开始加载时调用 在收到响应后，决定是否跳转，即是否把这个链接对应的网页加载到webView上
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"=============%s",__func__);
}

//当内容开始返回时调用，即服务器已经向客户端发送网页信息
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    NSLog(@"=============%s",__func__);
}


// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
   NSLog(@"=============%s",__func__);
    NSMutableString *strM = [NSMutableString string];
    [strM appendString:@"var head = document.getElementsByTagName(\"header\")[0]; head.parentNode.removeChild(head);"];
    [strM appendString:@"var footer = document.getElementsByClassName(\"footer-btn-fix\")[0]; footer.parentNode.removeChild(footer);" ];
    [strM appendString:@"var foo = document.getElementsByClassName(\"footer\")[0]; foo.parentNode.removeChild(foo);"];
    [strM appendString:@"var img = document.getElementsByTagName(\"figure\")[0].children[0]; img.onclick=function imgClick(){ window.location.href='http://myCustomURL.com';}"];
    [webView evaluateJavaScript:strM completionHandler:nil];
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"=============%s",__func__);
}






@end
