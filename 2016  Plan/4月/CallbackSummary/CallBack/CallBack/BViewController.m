//
//  BViewController.m
//  CallBack
//
//  Created by Qinting on 16/4/18.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "BViewController.h"
#import <objc/runtime.h>

@interface BViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation BViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)saveBtnClick:(id)sender {
    /** b3.在适当的时候传值 */
    self.block(self.textField.text,@"2");
    
    /** 3.在适当的时候，调用代理方法 传值 */
//    [self.delegate bViewController:self saveMesage:self.textField.text];
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
