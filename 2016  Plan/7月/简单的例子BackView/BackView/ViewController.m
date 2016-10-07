//
//  ViewController.m
//  BackView
//
//  Created by Qinting on 16/8/5.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "ViewController.h"
#import "ChoseView.h"
#import "DetailView.h"

@interface ViewController ()
@property (nonatomic,strong) ChoseView  *choseView;
@property (nonatomic,strong) DetailView  *detailView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    把背景色设置成黑色，黑白对比有很明显的效果
    self.view.backgroundColor  = [UIColor blackColor];
//    注意view的添加顺序
    [self initWithDetailView];
    [self initWithChoseView];
}

-(void)initWithDetailView{
   _detailView = [[DetailView alloc]initWithFrame:self.view.bounds];
    _detailView.backgroundColor = [UIColor lightGrayColor];
    UITextView *textView = [[UITextView alloc]initWithFrame:CGRectMake(30, 30, 200, 400)];
    textView.text = @"Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.";
    [_detailView addSubview:textView];
    [self.view addSubview:_detailView];
    
    UIButton *btn = [UIButton buttonWithType:0];
    btn.frame = CGRectMake(20, 20, 80, 30);
    btn.backgroundColor = [UIColor blueColor];
    [btn setTitle:@"弹出" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(changeView:) forControlEvents:UIControlEventTouchUpInside];
    [_detailView addSubview:btn];
}

-(void)initWithChoseView{
    _choseView = [ChoseView loadView];
    _choseView.alpha = 0;
    [_choseView.cancelButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [_choseView.sureButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_choseView];
}

- (void)changeView:(UIButton*)btn {
    [UIView animateWithDuration: 0.35 animations: ^{
        _detailView.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.8,0.8);
        _choseView.alpha = 1.0;
       _choseView.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        
    } completion: nil];
}

-(void)dismiss{
[UIView animateWithDuration:2 animations:^{
    _detailView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
    _choseView.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height);
    _choseView.alpha = 0;
}];
}

@end
