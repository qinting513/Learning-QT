//
//  QTLoginViewController.m
//  BaiSiBuDeJie
//
//  Created by Qinting on 16/6/1.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "QTLoginViewController.h"
#import "QTTextField.h"
#import "MainTabBarController.h"
#import "UserInfo.h"

@interface QTLoginViewController ()
- (IBAction)dismissViewController:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *registerOrLoginBtn;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginViewLeftMargin;

@property (weak, nonatomic) IBOutlet QTTextField *registerNameTF;
@property (weak, nonatomic) IBOutlet QTTextField *registerPasswordTF;
@property (weak, nonatomic) IBOutlet QTTextField *loginNameTF;
@property (weak, nonatomic) IBOutlet QTTextField *loginPasswordTF;

@end

@implementation QTLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.loginNameTF.text = @"chuye";
//    self.loginPasswordTF.text = @"123456";
}

/** 设置状态栏为白色s */
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (IBAction)dismissViewController:(id)sender {
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

/** 点击右上角按钮 登录跟注册进行切换 */
- (IBAction)shouldLoginOrRegisterBtnClick:(UIButton *)sender {
    //退出键盘
    [self.view endEditing:YES];
    
    if (_loginViewLeftMargin.constant == 0) {
        [self.registerOrLoginBtn setTitle:@"已有账号？" forState:UIControlStateNormal];
        _loginViewLeftMargin.constant = -self.view.frame.size.width;
    }else{
        _loginViewLeftMargin.constant = 0;
        [self.registerOrLoginBtn setTitle:@"注册账号" forState:UIControlStateNormal];
    }
    [UIView animateWithDuration:0.15 animations:^{
        [self.view layoutIfNeeded];
    }];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (IBAction)loginButtonClick:(id)sender {
    
    NSString *userName = self.loginNameTF.text;
    NSString *pwd =  self.loginPasswordTF.text;
    if(userName.length < 1 || pwd.length < 6 ){
        [self.view showWarning:@"用户名不能为空或密码不能少于6位"];
        return;
    }
    /** 通过用户名获取字典，如果获取不到则没注册过 */
   NSDictionary *userInfo = [UserInfo loadUserInfoFromSandBoxWithName:userName];
    if([userInfo[userName] isEqualToString:userName] && [userInfo[kPassword] isEqualToString:pwd]){
           NSDictionary *userInfo = @{userName : userName, kPassword:pwd,kIsLogin:@"YES"};
            [UserInfo saveToSandBoxWithUserInfo:userInfo andUserName:userName];
            [UserInfo saveLastLoginUser:userName];
            [UserInfo sharedUserInfo].userName = userName;
            [UserInfo sharedUserInfo].userPassword = pwd;
        
        
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        MainTabBarController *mainVC = [sb instantiateInitialViewController];
        mainVC.selectedIndex = 1;
        [UIApplication sharedApplication].keyWindow.rootViewController = mainVC;
    }else{
         [self.view showWarning:@"用户名或密码不正确"];
    }
}

- (IBAction)registerButtonClick:(id)sender {
    NSString *userName = self.registerNameTF.text;
    NSString *pwd =  self.registerPasswordTF.text;
    if(userName.length < 1 || pwd.length < 6 ){
        [self.view showWarning:@"用户名不能为空或密码不能少于6位"];
        return;
    }
    NSDictionary *userInfo = @{userName : userName, kPassword:pwd};
    [UserInfo saveToSandBoxWithUserInfo:userInfo andUserName:userName];
    [self.registerOrLoginBtn sendActionsForControlEvents:UIControlEventTouchUpInside];
    self.loginNameTF.text = self.registerNameTF.text;
    self.loginPasswordTF.text = @"";
    [self.loginPasswordTF becomeFirstResponder];
}

@end
