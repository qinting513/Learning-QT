//
//  ViewController.m
//  PlaceholderTextView
//
//  Created by Qinting on 16/7/17.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "ViewController.h"
#import "QTPlaceholderTextView.h"
#import "QTPlaceholderLabelTextView.h"

@interface ViewController ()
@property (nonatomic,strong) QTPlaceholderTextView  *textView;

@property (nonatomic,strong) QTPlaceholderLabelTextView  *textViewLabel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"设置" style:UIBarButtonItemStyleDone target:self action:@selector(setting)];
    
    /** 用drawRect方法绘制 */
//    [self setupPlaceholder];
    
    /** 用label的方法 */
        [self setupPlaceholderWithLabel];
}

-(void)setupPlaceholder
{
    QTPlaceholderTextView *textView = [[QTPlaceholderTextView alloc]init];
    textView.frame = self.view.bounds;
    textView.placeholder = @" 这段文字是占位文字，textField有placeholder占位文字属性，但textFiled只能显示一行，textView能显示多行，但没有placeholder属性，故需求：自定义一个控件，既能有占位文字，又能显示多行,更改占位文字颜色的功能";
    [self.view addSubview:textView];
    self.textView = textView;
}

-(void)setupPlaceholderWithLabel
{
    QTPlaceholderLabelTextView *textView = [[QTPlaceholderLabelTextView alloc]init];
    textView.frame = self.view.bounds;
    textView.textColor = [UIColor blackColor];
    textView.placeholder = @" 这段文字是占位文字，textField有placeholder占位文字属性，但textFiled只能显示一行，textView能显示多行，但没有placeholder属性，故需求：自定义一个控件，既能有占位文字，又能显示多行，点击左上角设置按钮，更改占位文字颜色";
    textView.placeholderColor = [UIColor lightGrayColor];
    
    [self.view addSubview:textView];
    self.textViewLabel = textView;
}

-(void)setting
{
    self.textViewLabel.placeholderColor = [UIColor blueColor];
    self.textViewLabel.placeholder = @"点击设置按钮后  可以更换占位文字 ";
    self.textViewLabel.font = [UIFont systemFontOfSize:20];
//    self.textView.text  = @"hahahah";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
