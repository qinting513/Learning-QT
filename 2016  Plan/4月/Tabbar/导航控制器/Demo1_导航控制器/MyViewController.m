//
//  MyViewController.m
//  Demo1_导航控制器
//
//  Created by tarena on 15/11/12.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import "MyViewController.h"
#import "OtherViewController.h"
#import "AnyViewController.h"

@interface MyViewController ()

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationBar];
    [self setupToolBar];
}

// 配置工具栏
-(void)setupToolBar
{
    // 设置工具栏显示
    self.navigationController.toolbarHidden = NO;
    // 工具栏中只能放UIBarButtonItem的对象
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemPlay target:nil action:nil];
    
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward target:nil action:nil];
    
    UIBarButtonItem *item3 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRewind target:nil action:nil];
    
    //木棍特效按钮
    UIBarButtonItem *fixedItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    //设置木棍的长度
    fixedItem.width = 40;
    
    //弹簧特效按钮
    UIBarButtonItem *flexiableItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    // 配置工具条的内容
    self.toolbarItems = @[fixedItem,item3,flexiableItem,item1,flexiableItem,item2,fixedItem];
#warning 此时的self就是当前的ViewController，当前VC的导航控制器的导航栏的一些属性
    //修改左右 按键的颜色，
    self.navigationController.navigationBar.tintColor = [UIColor greenColor];
    //修改导航条的背景
    self.navigationController.navigationBar.backgroundColor = [UIColor blueColor];
    //    //设置导航条 不是 半透明状态
    self.navigationController.navigationBar.translucent = YES;
    //设置导航条 样式
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    //设置工具栏
    //让 工具栏 显示出来
    self.navigationController.toolbarHidden = NO;

}


// 配置导航栏
-(void)setupNavigationBar
{
    // 1.配置导航栏的右侧按钮
    // 文字类型的按钮
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc]initWithTitle:@"增加" style:UIBarButtonItemStylePlain target:self action:@selector(add:)];
    // 系统类型的按钮
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(clickCamera:)];
    self.navigationItem.leftBarButtonItem = item2;
    self.navigationItem.rightBarButtonItems = @[item1];
   
    // 3.配置导航栏的中间部分
    UIButton *titleButton = [[UIButton alloc]init];
    titleButton.frame = CGRectMake(0, 0, 200, 40);
    //titleButton.backgroundColor = [UIColor redColor];
    [titleButton setTitle:@"张三" forState:UIControlStateNormal];
    [titleButton setImage:[UIImage imageNamed:@"down.png"] forState:UIControlStateNormal];
    // 只有通过设置按钮的selected属性为YES，按钮才会进入selected状态
    [titleButton setImage:[UIImage imageNamed:@"up.png"] forState:UIControlStateSelected];
    [titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    // 设置按钮中图片的内边距，实现左右位移
    titleButton.imageEdgeInsets = UIEdgeInsetsMake(0, 120, 0, 0);
    //titleButton.titleEdgeInsets;
    //titleButton.contentEdgeInsets;
    // 为按钮添加点击事件
    [titleButton addTarget:self action:@selector(clickTitleButton:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.titleView = titleButton;
    
    //修改导航条的背景
    self.navigationController.navigationBar.backgroundColor = [UIColor blueColor];
    
}

// 点击导航栏右侧按钮时，执行此方法
-(void)add:(UIBarButtonItem *)item
{
    OtherViewController *otherVC = [[OtherViewController alloc]init];
    //推出二级页面时，隐藏底部各种bar
    otherVC.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:otherVC animated:YES];
}

// 点击导航中间按钮时，执行此方法
-(void)clickTitleButton:(UIButton *)btn
{
    btn.selected = !btn.selected;
}

//点击照相机按钮后，从当前流程，切换到另一个流程
//就是切换的AnyViewController中
-(void)clickCamera:(UIBarButtonItem *)item
{
    AnyViewController *anyVC = [[AnyViewController alloc]init];
    
    UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:anyVC];
    
    //从当前控制器的导航，切换到管理anyVC的那个导航
    [self.navigationController presentViewController:navi animated:YES completion:nil];
    
}






@end
