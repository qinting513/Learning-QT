//
//  ViewController.m
//  WeiboDemo
//
//  Created by tarena on 16/7/20.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "HomeViewController.h"
#import "WeiboTableViewController.h"

@interface HomeViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//      _textField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"占位字符串" attributes:@{NSForegroundColorAttributeName :[UIColor greenColor]} ];
    
        _textField.placeholder = @"占位字符串";
    [_textField  setValue:[UIColor redColor] forKeyPath:@"placeholderLabel.textColor"];
    
    /** 设置 这个 可以使textView靠左顶端开始 */
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    WeiboTableViewController *weiboVC = segue.destinationViewController;
    weiboVC.backBlock = ^(NSString *name, NSString*content){
        self.textField.text = name;
        self.textView.text = content;
    };
    
}

@end
