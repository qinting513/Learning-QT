//
//  FriendTrendsViewController.m
//  BaiSiBuDeJie
//
//  Created by Qinting on 16/5/16.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "FriendTrendsViewController.h"
#import "UIBarButtonItem+Extension.h"
#import "RecommendViewController.h"
#import "QTLoginViewController.h"

@interface FriendTrendsViewController ()

@end

@implementation FriendTrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

         self.view.backgroundColor = GlobalColor;
         self.navigationItem.title = @"我的关注";
    
        self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" highlightImageName:@"friendsRecommentIcon-click" target:self action:@selector(leftBarButtonItemClick)];
}

- (void)leftBarButtonItemClick{
    RecommendViewController *recommandVC = [[RecommendViewController alloc]init];
    [self.navigationController pushViewController:recommandVC animated:YES];
}

- (IBAction)loginButtonClick:(UIButton *)sender {
    QTLoginViewController *loginVC = [[QTLoginViewController alloc]init];
    [self presentViewController:loginVC  animated:YES completion:nil];
}


@end
