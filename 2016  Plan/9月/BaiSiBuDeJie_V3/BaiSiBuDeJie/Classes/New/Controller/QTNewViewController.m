//
//  QTNewViewController.m
//  BaiSiBuDeJie
//
//  Created by Qinting on 16/5/21.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "QTNewViewController.h"
#import "UIBarButtonItem+Extension.h"
#import "MainRecommendTableViewController.h"

@interface QTNewViewController ()

@end

@implementation QTNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(NSArray<NSString *> *)titles{
    return @[@"全部", @"视频",@"图片", @"段子", @"声音",  @"网红", @"排行",  @"社会",  @"美女",  @"冷知识", @"游戏"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
