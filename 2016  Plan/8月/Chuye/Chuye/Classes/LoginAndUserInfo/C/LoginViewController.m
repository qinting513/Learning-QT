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

@interface LoginViewController ()

@end

@implementation LoginViewController
- (IBAction)loginBtnClick:(id)sender {
    QTLoginViewController * vc = [[QTLoginViewController alloc]init];
    [self presentViewController:vc animated:YES completion:nil];
}

- (IBAction)weChatLogin:(id)sender {
    
}

- (IBAction)sinaLogin:(id)sender {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
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
