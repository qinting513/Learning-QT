//
//  AffineTransformController.m
//  AllAnimation
//
//  Created by Qinting on 16/4/25.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "AffineTransformController.h"
/**
 
 * 仿射形变   CGAffineTransform
 
 这个类中包含3张不同类型，分别使用如下3个方法创建数值；
 
 1.CGAffineTransformMakeTranslation(CGFloat tx, CGFloat ty)（平移:设置平移量）
 
 2.CGAffineTransformMakeScale(CGFloat sx, CGFloat sy)（缩放:设置缩放比例）仅通过设置缩放比例就可实现视图扑面而来和缩进频幕的效果。
 
 3.CGAffineTransformMakeRotation(CGFloat angle)（旋转:设置旋转角度）
 
 以上3个都是针对视图的原定最初位置的中心点为起始参照进行相应操作的，在操作结束之后可对设置量进行还原：
 view.transform＝CGAffineTransformIdentity;
 
 */

@interface AffineTransformController ()

@property (nonatomic,strong) UIView *demoView;

@end

@implementation AffineTransformController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.demoView];
}

//UI开发技巧，重写setter方法和Code Block Evaluation C Extension语法
-(UIView *)demoView{
/** 中间用于显示动画的View */
    if (!_demoView) {
        _demoView = ({
            UIView *demoView = [[UIView alloc]initWithFrame:({
                CGRect rect = CGRectMake(SCREEN_WIDTH/2-50, SCREEN_HEIGHT/2-100,100 ,100 );
                rect;
            })];
            demoView.backgroundColor = [UIColor redColor];
            demoView;
        
        });
        
    }
    return _demoView;
}

-(NSArray *)operateTitleArray{
    return [NSArray arrayWithObjects:@"位移",@"缩放",@"旋转",@"组合",@"反转", nil];
}

-(void)clickBtn : (UIButton *)btn{
    switch (btn.tag) {
        case 0:
            [self positionAnimation];
            break;
        case 1:
            [self scaleAnimation];
            break;
        case 2:
            [self rotateAnimation];
            break;
        case 3:
            [self combinationAnimation];
            break;
        case 4:
            [self invertAnimation];
            break;
        default:
            break;
    }
}

-(void)positionAnimation{
    _demoView.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:1.0f animations:^{
        _demoView.transform = CGAffineTransformMakeTranslation(100, 100);
    }];
}

-(void)scaleAnimation{
    _demoView.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:1.0f animations:^{
        _demoView.transform = CGAffineTransformMakeScale(2, 2);
    }];
}

-(void)rotateAnimation{
    _demoView.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:1.0f animations:^{
        _demoView.transform = CGAffineTransformMakeRotation(M_PI);
    }];
}

-(void)combinationAnimation{
    //仿射变换的组合使用
    _demoView.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:1.0f animations:^{
        CGAffineTransform transform1 = CGAffineTransformMakeRotation(M_PI);
        CGAffineTransform transform2 = CGAffineTransformScale(transform1, 0.5, 0.5);
        _demoView.transform = CGAffineTransformTranslate(transform2, 100, 100);
    }];
}

-(void)invertAnimation{
    _demoView.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:1.0f animations:^{
        //矩阵反转
        _demoView.transform = CGAffineTransformInvert(CGAffineTransformMakeScale(2, 2));
    }];
}

-(NSString *)controllerTitle{
    return @"仿射变换";
}


@end
