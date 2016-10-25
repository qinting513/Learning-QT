//
//  JCMeVC.m
//  Turing
//
//  Created by Guo.JC on 16/9/17.
//  Copyright © 2016年 Guo.JC. All rights reserved.
//

#import "JCMeVC.h"

@interface JCMeVC ()

@end

@implementation JCMeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//是否支持旋转
- (BOOL)shouldAutorotate
{
    return NO;
}
//
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    //只支持竖屏
    return UIInterfaceOrientationMaskPortrait;
}

@end
