//
//  MeViewController.m
//  Chuye
//
//  Created by Qinting on 16/8/19.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "MeViewController.h"
#import "LoginViewController.h"
#import "UserDetailViewController.h"
#import "UserInfo.h"
#import "MainTabBarController.h"

@interface MeViewController ()

@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSString *userName = [UserInfo loadlastLogin];
    NSDictionary *info = [UserInfo loadUserInfoFromSandBoxWithName:userName];
      /** 如果登录了  则进入到用户详情界面 ，否则 去登录界面*/
    if([info[kIsLogin] isEqualToString:@"NO"] ||  info == nil ){
        LoginViewController *loginVc = [[LoginViewController alloc]init];
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:loginVc animated:YES completion:nil];
    }else{
        
        [UserInfo sharedUserInfo].userName = userName;
        if(info != nil){
            [UserInfo sharedUserInfo].userPassword = info[kPassword];
        }
        /** 如果不存在 才创建,防止重复创建，导致叠加。。 */
        if(![UserInfo sharedUserInfo].isUserDetailExist){
            UserDetailViewController *vc = [[ UserDetailViewController alloc]init];
            [self addChildViewController:vc];
            [self.view addSubview:vc.view];
        }
    }
    
}




@end
