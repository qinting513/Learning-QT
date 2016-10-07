//
//  QTLoginViewController.m
//  BaiSiBuDeJie
//
//  Created by Qinting on 16/6/1.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "QTLoginViewController.h"

@interface QTLoginViewController ()
- (IBAction)dismissViewController:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *registerOrLoginBtn;

@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginViewLeftMargin;

@end

@implementation QTLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
@end
