//
//  TransitionAnimationController.m
//  AllAnimation
//
//  Created by Qinting on 16/4/25.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "TransitionAnimationController.h"

/** 过渡动画
 //0.创建对象
        CATransition *anima = [CATransition animation];
 //1.设置动画类型
        type:
 //2.设置动画方向
        subType:
//3.设置动画时间
        anima.duration = 1.0f;
 //4.在view的layer层添加动画,后面的key不重要
         [_demoView.layer addAnimation:anima forKey:@"fadeAnimation"];
 */

@interface TransitionAnimationController ()

@property (nonatomic,strong) UIView  *demoView;
@property (nonatomic,strong) UILabel *demoLabel;
@property (nonatomic,assign) NSInteger index;

@end

@implementation TransitionAnimationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
}

-(NSString *)controllerTitle{
return @"过渡动画";
}

-(void)initView {
    [super initView];
    _index = 0;
    
    _demoView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-90, SCREEN_HEIGHT/2-200,180,260)];
    [self.view addSubview:_demoView];
    
    /** 在demoView上 显示的文字  */
    _demoLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(_demoView.frame)/2-10, CGRectGetHeight(_demoView.frame)/2-20, 20, 40)];
    _demoLabel.textAlignment = NSTextAlignmentCenter;
    _demoLabel.font = [UIFont systemFontOfSize:40];
    [_demoView addSubview:_demoLabel];
    
    [self changeView:YES];
}

/** 设置view的值 */
-(void)changeView:(BOOL)isUp{
    if(_index >3){
        _index = 0;
    }else if(_index <0){
        _index = 3;
    }
    NSArray *colors = [NSArray arrayWithObjects:[UIColor cyanColor],[UIColor magentaColor],[UIColor orangeColor],[UIColor purpleColor], nil];
    NSArray *titles = @[@"1",@"2",@"3",@"4"];
    _demoView.backgroundColor = [colors objectAtIndex:_index];
    _demoLabel.text = titles[_index];
    if (isUp) {
        _index ++;
    }else{
        _index --;
    }
    
}

-(NSArray *)operateTitleArray{
    return [NSArray arrayWithObjects:@"fade",@"moveIn",@"push",@"reveal",@"cube",@"suck",@"oglFlip",@"ripple",@"Curl",@"UnCurl",@"caOpen",@"caClose", nil];
}

-(void)clickBtn : (UIButton *)btn{
    switch (btn.tag) {
        case 0:
            [self fadeAnimation];
            break;
        case 1:
            [self moveInAnimation];
            break;
        case 2:
            [self pushAnimation];
            break;
        case 3:
            [self revealAnimation];
            break;
        case 4:
            [self cubeAnimation];
            break;
        case 5:
            [self suckEffectAnimation];
            break;
        case 6:
            [self oglFlipAnimation];
            break;
        case 7:
            [self rippleEffectAnimation];
            break;
        case 8:
            [self pageCurlAnimation];
            break;
        case 9:
            [self pageUnCurlAnimation];
            break;
        case 10:
            [self cameraIrisHollowOpenAnimation];
            break;
        case 11:
            [self cameraIrisHollowCloseAnimation];
            break;
        default:
            break;
    }
}

//-----------------------------public api------------------------------------
/*
  CATransition *anima = [CATransition animation]; //0.创建对象
 type: //1.设置动画类型
 kCATransitionFade;
 kCATransitionMoveIn;
 kCATransitionPush;
 kCATransitionReveal;
 */
/*
 subType: //2.设置动画方向
 kCATransitionFromRight;
 kCATransitionFromLeft;
 kCATransitionFromTop;
 kCATransitionFromBottom;
 
  anima.duration = 1.0f;  //3.设置动画时间
                          //4.在view的layer层添加动画,后面的key不重要
 [_demoView.layer addAnimation:anima forKey:@"fadeAnimation"];
 */

/** 淡入淡出 */
-(void)fadeAnimation{
    [self changeView:YES];
    CATransition *anima = [CATransition animation];
    anima.type = kCATransitionFade; //设置动画类型
    anima.subtype = kCATransitionFromRight; //设置动画方向
//    anima.startProgress = 0.3; //设置动画起点
//    anima.endProgress = 0.9; //设置动画终点
    anima.duration = 1.0f;
    
    [_demoView.layer addAnimation:anima forKey:@"fadeAnimation"];
}

/** 移动进来 覆盖住 */
-(void)moveInAnimation{
    [self changeView:YES];
    CATransition *anima = [CATransition animation];
    anima.type = kCATransitionMoveIn;
    anima.subtype = kCATransitionFromTop;
    anima.duration = 1.0f;
    
    [_demoView.layer addAnimation:anima forKey:@"moveInAnimation"];
}

/** 常用的push的效果 */
-(void)pushAnimation{
    [self changeView:YES];
    CATransition *anima = [CATransition animation];
    anima.type = kCATransitionPush;
    anima.subtype = kCATransitionFromLeft;
    anima.duration = 1.0f;
    
    [_demoView.layer addAnimation:anima forKey:@"pushAnimation"];
}

/** 移走 显示出下一个View */
-(void)revealAnimation{
    [self changeView:YES];
    CATransition *anima = [CATransition animation];
    anima.type = kCATransitionReveal;
    anima.subtype = kCATransitionFromRight;
    anima.duration = 1.0f;
    
    [_demoView.layer addAnimation:anima forKey:@"revealAnimation"];
}

//-----------------------------private api------------------------------------
/*
	Don't be surprised if Apple rejects your app for including those effects,
	and especially don't be surprised if your app starts behaving strangely after an OS update.
 */

/** 立体效果 */
-(void)cubeAnimation{
    [self changeView:YES];
    CATransition *anima = [CATransition animation];
    anima.type = @"cube"; //设置动画类型
    anima.subtype = kCATransitionFromRight;
    anima.duration = 1.0f;
    
    [_demoView.layer addAnimation:anima forKey:@"cubeAnimation"];
}

/** 吸吮效果 */
-(void)suckEffectAnimation{
    [self changeView: YES];
    CATransition *anima = [CATransition animation];
    anima.type = @"suckEffect";
    anima.subtype = kCATransitionFromLeft;//此行没用 都是往左上角吸吮
    anima.duration = 1.0f;
    
    [_demoView.layer addAnimation:anima forKey:@"suckEffectAnimation"];
}

/** view绕中心轴旋转 */
-(void)oglFlipAnimation{
    [self changeView:YES];
    CATransition *anima = [CATransition animation];
    anima.type = @"oglFlip";
    anima.subtype = kCATransitionFromTop;
    anima.duration = 1.0f;
    
    [_demoView.layer addAnimation:anima forKey:@"oglFlipAnimation"];
}

/** ripple 波纹 涟漪效果 */
-(void)rippleEffectAnimation{
    [self changeView:YES];
    CATransition *anima = [CATransition animation];
    anima.type = @"rippleEffect";//设置动画的类型
    anima.subtype = kCATransitionFromRight; //设置动画的方向
    anima.duration = 1.0f;
    
    [_demoView.layer addAnimation:anima forKey:@"rippleEffectAnimation"];
}

/** 翻页效果 */
-(void)pageCurlAnimation{
    [self changeView:YES];
    CATransition *anima = [CATransition animation];
    anima.type = @"pageCurl";//设置动画的类型
    anima.subtype = kCATransitionFromRight; //设置动画的方向
    anima.duration = 1.0f;
    
    [_demoView.layer addAnimation:anima forKey:@"pageCurlAnimation"];
}

/** 盖住（与翻页效果相反） */
-(void)pageUnCurlAnimation{
    [self changeView:YES];
    CATransition *anima = [CATransition animation];
    anima.type = @"pageUnCurl";//设置动画的类型
    anima.subtype = kCATransitionFromRight; //设置动画的方向
    anima.duration = 1.0f;
    
    [_demoView.layer addAnimation:anima forKey:@"pageUnCurlAnimation"];
}

/** 镜头打开效果 */
-(void)cameraIrisHollowOpenAnimation{
    [self changeView:YES];
    CATransition *anima = [CATransition animation];
    anima.type = @"cameraIrisHollowOpen";//设置动画的类型
    anima.subtype = kCATransitionFromRight; //设置动画的方向
    anima.duration = 1.0f;
    
    [_demoView.layer addAnimation:anima forKey:@"cameraIrisHollowOpenAnimation"];
}

/** 镜头关闭效果 */
-(void)cameraIrisHollowCloseAnimation{
    [self changeView:NO];
    CATransition *anima = [CATransition animation];
    anima.type = @"cameraIrisHollowClose";//设置动画的类型
    anima.subtype = kCATransitionFromRight; //设置动画的方向
    anima.duration = 1.0f;
    
    [_demoView.layer addAnimation:anima forKey:@"cameraIrisHollowCloseAnimation"];
}


@end
