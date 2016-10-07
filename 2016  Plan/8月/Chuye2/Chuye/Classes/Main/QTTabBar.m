//
//  QTTabBar.m
//  Chuye
//
//  Created by Qinting on 16/8/19.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "QTTabBar.h"
#import "LoginViewController.h"
#import "TemplateViewController.h"
#import "UserInfo.h"

@implementation QTTabBar
-(instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self ) {
        
//        /** 创建 添加 */
//        UIButton *btn = [UIButton buttonWithType:0];
//        [btn setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
//        [btn setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
////        CGSize size = [btn backgroundImageForState:UIControlStateNormal].size;
//        
//        CGSize size = CGSizeMake(kScreenW / 3.0, 80);
//        [self addSubview:btn];
//        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.center.mas_equalTo(self);
//            make.size.mas_equalTo(size);
//        }];
//        [btn addTarget:self action:@selector(centerBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        UIImageView *imageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"tabBar_publish_icon"] highlightedImage:[UIImage imageNamed:@"tabBar_publish_click_icon"]];
        imageV.contentMode = UIViewContentModeCenter;
        imageV.userInteractionEnabled = YES;
         CGSize size = CGSizeMake(kScreenW/3.0 , 55);
        [self addSubview:imageV];
        
        [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self);
            make.size.mas_equalTo(size);
        }];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(centerBtnClick) ];
        [imageV addGestureRecognizer:tap];
    }
    return self;

}

-(void)centerBtnClick{
    NSLog(@"centerBtnClick----");
    NSString *userName = [UserInfo loadlastLogin];
    NSDictionary *info = [UserInfo loadUserInfoFromSandBoxWithName:userName];
    /** 如果登录了  则进入到用户详情界面 ，否则 去登录界面*/
    if([info[kIsLogin] isEqualToString:@"NO"] ||  info == nil ){
        LoginViewController *loginVc = [[LoginViewController alloc]init];
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:loginVc animated:YES completion:nil];
    }else{
//        * 如果已经登录，则跳转到 模版按钮界面
            TemplateViewController *templateVC = [[TemplateViewController alloc]init];
            [ UIApplication sharedApplication].keyWindow.rootViewController = templateVC;
    }
    
}


/** 调整布局 */
-(void)layoutSubviews{
    [super layoutSubviews];
//    NSLog(@"tabbar:%s",__func__);
    CGFloat width = kScreenW / 3.0;
    int index = 0;
    for(UIControl *control in self.subviews){
        /** 如果control不是UIControl类的，则继续 */
        if ( ![control isKindOfClass:[UIControl class]] || [control isKindOfClass:[UIButton class] ] ) {
            continue;
        }
//        NSLog(@"%@",control);
        CGRect frame = control.frame;
        frame.size.width = width;
//        等于1是右边按钮
        frame.origin.x = index == 1 ? width *(index + 1) : width *index ;
        frame.origin.y =10;
        control.frame = frame;
        index ++;
    }
    
}


@end
