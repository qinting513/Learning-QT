//
//  FooterView.m
//  Demo3_自定义Cell
//
//  Created by Qinting on 16/4/21.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "FooterView.h"

@interface FooterView()
@property (weak, nonatomic) IBOutlet UIButton *loadButton;
@property (weak, nonatomic) IBOutlet UIView *loadView;

@end



@implementation FooterView
- (IBAction)clickButton:(id)sender {
    //Button隐藏
    self.loadButton.hidden = YES;
    //View显示
    self.loadView.hidden = NO;
    //通知代理人执行 代理方法
    [self.delegate loadData:self];
}

-(void)didLoadNewsData {
    //数组加载完 button显示  view 隐藏
    self.loadButton.hidden = NO;
    self.loadView.hidden = YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
