//
//  LoginViewController.m
//  Chuye
//
//  Created by Qinting on 16/8/19.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "LoginViewController.h"
#import "MeViewController.h"
#import "MainTabBarController.h"
#import "QTLoginViewController.h"
#import "TemplateViewController.h"
#import "UserInfo.h"
@interface LoginViewController ()<UIWebViewDelegate>
@property (nonatomic,strong) UIWebView  *webView;
@end

@implementation LoginViewController
- (IBAction)loginBtnClick:(id)sender {
    QTLoginViewController * vc = [[QTLoginViewController alloc]init];
    [self presentViewController:vc animated:YES completion:nil];
}

- (IBAction)weChatLogin:(id)sender {
    
}

- (IBAction)sinaLogin:(id)sender {
//    SinaLoginViewController *vc = [[SinaLoginViewController alloc]init];
//    [self presentViewController:vc animated:YES completion:nil];

    self.webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:self.webView];
 
    self.webView.delegate = self;
    NSString *path = @"https://api.weibo.com/oauth2/authorize?client_id=586885323&redirect_uri=http://www.baidu.com";
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:path]];
    [_webView loadRequest:request];
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIButton *btn = [UIButton buttonWithType:0];
    btn.frame = CGRectMake(10, 20, 30, 30);
    [btn setImage:[UIImage imageNamed:@"deleteBtn"] forState:UIControlStateNormal];
    [btn addTarget:self  action:@selector(comeBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    [self.webView addSubview:btn];
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    NSString *path = [request.URL description];
    NSLog(@"%@",path);
    if ([path containsString:@"code"]) {
        NSString *code = [[path componentsSeparatedByString:@"="] lastObject];
        NSLog(@"得到code ：%@",code);
        //拿code换token
        NSString *path = @"https://api.weibo.com/oauth2/access_token";
        NSString *params = [NSString stringWithFormat:@"code=%@&client_id=586885323&client_secret=49b07898f60581be441804f5aada12bb&grant_type=authorization_code&redirect_uri=http://www.baidu.com",code];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:path]];
        //设置POST请求方式
        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
        
        //创建session
        NSURLSession *session = [NSURLSession sharedSession];
        
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSString *token = dic[@"access_token"];
            NSString *uid = dic[@"uid"];
            //把登录信息保存起来
            [UserInfo sharedUserInfo].access_token = token;
            [UserInfo sharedUserInfo].uid = uid;
            NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
            [ud setObject:token forKey:@"token"];
            [ud setObject:uid forKey:@"uid"];
            [ud synchronize];
            //返回页面
            [self dismissViewControllerAnimated:YES completion:nil];
            dispatch_async(dispatch_get_main_queue(), ^{
                UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                MainTabBarController *mainVC = [sb instantiateInitialViewController];
                mainVC.selectedIndex = 0;
                [UIApplication sharedApplication].keyWindow.rootViewController = mainVC;
                TemplateViewController *vc = [[TemplateViewController alloc]init];
                [mainVC presentViewController:vc animated:YES completion:nil];
            });
        }];
        [task resume];
        return NO;
    }
    
    return YES;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    self.webView.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.automaticallyAdjustsScrollViewInsets = NO;
    UIButton *btn = [UIButton buttonWithType:0];
    btn.frame = CGRectMake(10, 20, 30, 30);
    [btn setImage:[UIImage imageNamed:@"deleteBtn"] forState:UIControlStateNormal];
    [btn addTarget:self  action:@selector(comeBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
  
}

-(void)comeBack{

    if( [self.presentingViewController isKindOfClass:[MainTabBarController class]]){
        UITabBarController *tabVC = (UITabBarController*)self.presentingViewController;
        tabVC.selectedIndex = 0;
    }
          [self dismissViewControllerAnimated:YES completion:nil];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
