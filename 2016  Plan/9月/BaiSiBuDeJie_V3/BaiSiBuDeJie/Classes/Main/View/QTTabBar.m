//
//  QTTabBar.m
//  BaiSiBuDeJie
//
//  Created by Qinting on 16/5/16.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "QTTabBar.h"
#import "QTCenterViewController.h"
//#import "DCPathButton.h"

@interface QTTabBar ( )

@end

@implementation QTTabBar

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIButton *publishButton = [[UIButton alloc]init];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:
        UIControlStateHighlighted];
        
        CGSize size = [publishButton backgroundImageForState:UIControlStateNormal].size;
        
        [self addSubview:publishButton];
        [publishButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self);
            make.size.mas_equalTo(size);
        }];
        
        [publishButton addTarget:self action:@selector(publishClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return  self;
}

- (void)publishClick{
    MYLog(@"publishClick");
    
    QTCenterViewController * centerVC = [[QTCenterViewController alloc]init];
    centerVC.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    centerVC.view.backgroundColor = [UIColor grayColor];
    UIViewController *vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    [vc presentViewController:centerVC animated:YES completion:nil];
}

/** 当设置view 的frame时会触发此方法 */
- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat width = self.frame.size.width / 5.0;
    int index = 0;
    for ( UIControl *control in self.subviews) {
        /** 如果control不是UIControl类的，则继续 */
        if ( ![control isKindOfClass:[UIControl class]] || [control isKindOfClass:[UIButton class] ] ) {
            continue;
        }
       /** 重新布局 修改x 和宽度 */
        control.width = width;
        control.left  = index > 1 ? width *(index+1) : width * index;
        index ++;
    }

}


@end
