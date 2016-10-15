//
//  MainViewController.m
//  LiveApp
//
//  Created by Qinting on 2016/10/15.
//  Copyright © 2016年 QT. All rights reserved.
//

#import "MainViewController.h"
#import "BroadcastViewController.h"
#import "CaptureViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"直播";
}


/** 采集视频 */
- (IBAction)getCaptureVideo:(id)sender {
    CaptureViewController *vc = [[CaptureViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}


/** 主播列表 */
- (IBAction)playVideo:(id)sender {
    BroadcastViewController *vc = [[BroadcastViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}



@end
