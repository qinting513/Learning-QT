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
#import "AddFriendTableViewController.h"

@interface HomeBaseViewController ()<TitleViewDelegate,UIScrollViewDelegate>

@end

@implementation HomeBaseViewController
{
    DiscoveryViewController   *discoveryVC;
   RecommendTableViewController    *recommendVC;
   AttentionViewController  *attentionVC;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    TitleView *titleView = [[TitleView alloc]initWithFrame:CGRectMake(0, 0, 200, 44) allButtonTitles:@[@"关注",@"推荐",@"发现"]];
    titleView.delegate = self;
//    titleView.selectedAtIndex = 
    self.navigationItem.titleView = titleView;
    [self setupVC];
    self.currentVCType = CurrentVCTypeRecommend;
    [self titleView:nil buttonClickAtIndex:self.currentVCType];
//    [self setupGesture];
    
//    左上角按钮
    UIButton *btn = [UIButton  buttonWithType:0];
    btn.frame = CGRectMake(0, 0, 25, 25);
    [btn setImage:[UIImage imageNamed:@"add_friends"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"add_friend"] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(addFriendBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

//左上角按钮被点击
-(void)addFriendBtnClick{
    AddFriendTableViewController *vc = [[AddFriendTableViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

//初始化控制器
-(void)setupVC{
    attentionVC = [[AttentionViewController alloc]init];
    [self addChildViewController:attentionVC];
    
//    recommendVC = [[RecommendTableViewController alloc]init];
    recommendVC = [self.storyboard instantiateViewControllerWithIdentifier:@"RecommendTableViewController"];
    [self addChildViewController:  recommendVC ];
    
    discoveryVC = [[DiscoveryViewController alloc]init];
    [self addChildViewController:  discoveryVC ];
}

//titleView的代理方法
- (void)titleView:(TitleView *)view buttonClickAtIndex:(NSInteger)index {
    for (UIView *v in self.view.subviews) {
        [v removeFromSuperview];
    }
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
