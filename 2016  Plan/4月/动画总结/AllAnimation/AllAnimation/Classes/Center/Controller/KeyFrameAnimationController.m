//
//  KeyFrameAnimationController.m
//  AllAnimation
//
//  Created by Qinting on 16/4/25.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "KeyFrameAnimationController.h"
#import "SWRevealViewController.h"

@interface KeyFrameAnimationController ()

@property (nonatomic,strong) UIView *demoView;

@end

@implementation KeyFrameAnimationController

- (void)viewDidLoad {
    [super viewDidLoad];
   _demoView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-25, SCREEN_HEIGHT/2-50,50,50)];
    _demoView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_demoView];

}

-(NSString *)controllerTitle{
   return @"关键帧动画";
}

-(NSArray *)operateTitleArray{
    return @[@"关键帧",@"路径",@"抖动"];
}

-(void)clickBtn:(UIButton *)btn{
    switch (btn.tag) {
        case 0:
            [self keyFrameAnimation];
            break;
        case 1:
            [self pathAnimation];
            break;
        case 2:
            [self shakeAnimation];
            break;
        default:
            break;
    }

}

/** 
 关键帧动画
 */

-(void)keyFrameAnimation{
    CAKeyframeAnimation *anima = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    NSValue *value0 = [NSValue valueWithCGPoint:CGPointMake(0, SCREEN_HEIGHT/2-50)];
    NSValue *value1 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH/3, SCREEN_HEIGHT/2-50)];
    NSValue *value2 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH/3, SCREEN_HEIGHT/2+50)];
    NSValue *value3 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH*2/3, SCREEN_HEIGHT/2+50)];
    NSValue *value4 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH*2/3, SCREEN_HEIGHT/2-50)];
    NSValue *value5 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH, SCREEN_HEIGHT/2-50)];
    
    anima.values = @[value0,value1,value2,value3,value4,value5];
    anima.duration = 2.0f;
    anima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];//设置动画的节奏，淡出
    anima.delegate = self;
    [_demoView.layer addAnimation:anima forKey:@"keyFrameAnimation"];
}
/** keyFrameAnimation的代理方法 */
-(void)animationDidStart:(CAAnimation *)anim{
    NSLog(@"animationDidStart");
}
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    NSLog(@"animationDidStop");
}

/** path 动画  沿着路径运动*/
-(void)pathAnimation{
    CAKeyframeAnimation *anima = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(SCREEN_WIDTH/2 -100, SCREEN_HEIGHT/2-100, 200, 200)];
    anima.path = path.CGPath;
    anima.duration = 2.0f;
    [_demoView.layer addAnimation:anima forKey:@"pathAnimation"];
}

/** 抖动效果 */
-(void)shakeAnimation{
    CAKeyframeAnimation *anima =[CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
    //在这里@"transform.rotation"==@"transform.rotation.z"
    NSValue *value  =  [NSNumber numberWithFloat:-M_PI/180 *4];
    NSValue *value2 = [NSNumber numberWithFloat: M_PI/180 *4];
    NSValue *value3 = [NSNumber numberWithFloat:-M_PI/180 *4];
    anima.values = @[value,value2,value3];
    anima.repeatCount = MAXFLOAT;
    
    [_demoView.layer addAnimation:anima forKey:@"shakeAnimation"];
}

@end
