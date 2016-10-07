//
//  HomeBaseViewController.m
//  Chuye
//
//  Created by Qinting on 16/8/16.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "HomeBaseViewController.h"
#import "TitleView.h"
#import "DiscoveryViewController.h"
#import "RecommendTableViewController.h"
#import "AttentionViewController.h"

@interface HomeBaseViewController ()<TitleViewDelegate>

@end

@implementation HomeBaseViewController
{
    DiscoveryViewController   *discoveryVC;
RecommendTableViewController    *recommendVC;
AttentionViewController  *attentionVC;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    TitleView *titleView = [[TitleView alloc]initWithFrame:CGRectMake(0, 0, 200, 44) allButtonTitles:@[@"最新",@"推荐",@"发现"]];
    titleView.delegate = self;
//    titleView.selectedAtIndex = 
    self.navigationItem.titleView = titleView;
    [self setupVC];
    [self titleView:nil buttonClickAtIndex:1];
    
    UIButton *btn = [UIButton  buttonWithType:0];
    btn.frame = CGRectMake(0, 0, 25, 25);
    [btn setImage:[UIImage imageNamed:@"add_friends"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"add_friend"] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
}

-(void)loginBtnClick{

}
-(void)setupVC{
    attentionVC = [[AttentionViewController alloc]init];
    [self addChildViewController:attentionVC];
    
//    recommendVC = [[RecommendTableViewController alloc]init];
    recommendVC = [self.storyboard instantiateViewControllerWithIdentifier:@"RecommendTableViewController"];
    [self addChildViewController:  recommendVC ];
    
    discoveryVC = [[DiscoveryViewController alloc]init];
    [self addChildViewController:  discoveryVC ];
}

- (void)titleView:(TitleView *)view buttonClickAtIndex:(NSInteger)index {
    switch (index) {
        case 0:
        {
              [self.view addSubview:attentionVC.view];
            break;
        }
        case 1:
        {
            [self.view addSubview: recommendVC.view];
            break;
        }
        default:
        {
            [self.view addSubview:discoveryVC.view];
        }
       
    }
    
    
}



@end
