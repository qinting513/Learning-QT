//
//  ViewController.m
//  手势密码解锁
//
//  Created by ios on 15-12-2.
//  Copyright (c) 2015年 ios. All rights reserved.
//
#import "ZPFmdbTool.h"
#import "ViewController.h"
#import "ZPUnlockView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *backgroudView;

@property (weak, nonatomic) IBOutlet UITextField *passwordText;

@end

@implementation ViewController
- (IBAction)setCode:(id)sender {
    
    [[ZPFmdbTool sharedDatabaseQueue]insertPassword:self.passwordText.text];
//    NSLog(@"%@",self.passwordText.text);
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"已设置新密码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
    
}

- (IBAction)deleteCode:(id)sender {
    [[ZPFmdbTool sharedDatabaseQueue]deletelastPassword];
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"已删除密码记录" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    ZPUnlockView *lockview = [[ZPUnlockView alloc]init];
    lockview.backgroundColor = [UIColor whiteColor];
    lockview.frame = self.backgroudView.bounds;
    [self.backgroudView addSubview:lockview];
    
    
    self.passwordText.leftView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"searchbar_textfield_search_icon"]];
    self.passwordText.leftViewMode = UITextFieldViewModeAlways;
    
}



@end
