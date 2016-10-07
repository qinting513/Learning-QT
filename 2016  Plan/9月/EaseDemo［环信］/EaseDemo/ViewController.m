//
//  ViewController.m
//  EaseDemo
//
//  Created by Qinting on 16/9/1.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "ViewController.h"
//#import <EaseMob.h>
#import "FriendsTableViewController.h"
#import "EasemobManager.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userNameTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;

@end

@implementation ViewController
- (IBAction)hud:(id)sender {
    FriendsTableViewController *vc = [[FriendsTableViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
    self.userNameTF.text = @"qt0";
    self.passwordTF.text = @"123456";
    [[EasemobManager sharedManager] isAutoLoginWithUsername:self.userNameTF.text password:self.passwordTF.text loginSuccessBlock:^{
//        成功则跳转
        FriendsTableViewController *vc = [[FriendsTableViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
}

- (IBAction)registerAction:(id)sender {
    [[EasemobManager sharedManager] registerWithName:self.userNameTF.text pwd:self.passwordTF.text];
}

- (IBAction)loginAction:(id)sender {
    [[EasemobManager sharedManager] loginWithName:self.userNameTF.text  pwd:self.passwordTF.text loginSuccessBlock:^{
        FriendsTableViewController *vc = [[FriendsTableViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
}

@end
