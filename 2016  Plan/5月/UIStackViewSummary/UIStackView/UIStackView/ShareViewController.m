//
//  ShareViewController.m
//  UIStackView
//
//  Created by Qinting on 16/6/2.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "ShareViewController.h"

@interface ShareViewController ()

@end

@implementation ShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *label0 = [[UILabel alloc]init];
    label0.text = @"我是label0";
    label0.backgroundColor = [UIColor cyanColor];
    
    UILabel *label1 = [[UILabel alloc]init];
      label1.text = @"我是label1，我是label1，我是label1";
//    label1.text = @"我是label1，我是label1，我是label1，我是label1，我是label1，我是label1,我是label1，我是label1，我是label1，我是label1，我是label1，我是label1";
    label1.numberOfLines = 0;
    label1.backgroundColor = [UIColor orangeColor];
    
    UIStackView *stackView = [[UIStackView alloc]init];
    [stackView addArrangedSubview:label0];
    [stackView addArrangedSubview:label1];
    
    stackView.axis = UILayoutConstraintAxisVertical;
    stackView.frame = CGRectMake(50, 50, 200, 200);
        [self.view addSubview:stackView];
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
