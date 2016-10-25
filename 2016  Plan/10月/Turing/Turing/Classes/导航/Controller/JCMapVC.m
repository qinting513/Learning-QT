//
//  JCMapVC.m
//  Turing
//
//  Created by Guo.JC on 16/9/17.
//  Copyright © 2016年 Guo.JC. All rights reserved.
//

#import "JCMapVC.h"

@interface JCMapVC ()

@end

static NSString *entityName = @"Guo.JC";

@implementation JCMapVC

- (void)viewDidLoad {
    [super viewDidLoad];

    
    

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
