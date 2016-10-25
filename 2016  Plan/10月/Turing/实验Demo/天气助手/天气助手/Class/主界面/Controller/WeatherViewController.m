//
//  WeatherViewController.m
//  天气助手
//
//  Created by Guo.JC on 16/8/27.
//  Copyright © 2016年 Guo.JC. All rights reserved.
//

#import "WeatherViewController.h"

@interface WeatherViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *backGroundImage;

@end

@implementation WeatherViewController{
    CAEmitterLayer * _fireEmitter;//发射器对象
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置发射器
    _fireEmitter=[[CAEmitterLayer alloc]init];
    _fireEmitter.emitterPosition=CGPointMake(SCREEN_WIDTH * .5,0);//发射器在xy平面的中心位置
    _fireEmitter.emitterSize=CGSizeMake(SCREEN_WIDTH, 1);//发射器在Z平面的中心位置
    _fireEmitter.emitterShape = @"line";
    _fireEmitter.emitterMode = kCAEmitterLayerOutline;
    _fireEmitter.renderMode = kCAEmitterLayerOldestFirst;//渲染模式
    _fireEmitter.preservesDepth = NO;
    //发射单元
    //雨点
    CAEmitterCell * fire = [CAEmitterCell emitterCell];
    fire.birthRate=500; //粒子创建速率
    fire.lifetime=2.0; //粒子存活时间
    fire.lifetimeRange=1.5;//生存时间容差
    fire.color=[[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:.15]CGColor];
    fire.contents=(id)[[UIImage imageNamed:@"sunny_night_shooting_start"]CGImage];
    [fire setName:@"rain"];
    
    fire.velocity=500; //运动速度
    fire.velocityRange=400;//粒子速度的容差
    fire.emissionLongitude=M_PI * (10.0/10.0);//粒子在xy平面的发射角度
//    fire.emissionLatitude = 0;//粒子在Z轴方向的发射角度
    fire.emissionRange=M_PI / 20.0;//粒子发射角度的容差
//    
//    fire.xAcceleration = 10;//X方向加速度
//    fire.yAcceleration = 10;//Y方向加速度
//    fire.zAcceleration = 10;//Z方向加速度
    
    fire.scaleSpeed=0.3;
//    fire.spin=-0.2;//旋转角度
    
    //烟雾
    CAEmitterCell * smoke = [CAEmitterCell emitterCell];
    smoke.birthRate=1;
    smoke.lifetime=3.0;
    smoke.lifetimeRange=1.5;
    smoke.color=[[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1]CGColor];
    smoke.contents=(id)[[UIImage imageNamed:@"sunny_night_star_l"]CGImage];
    [fire setName:@"smoke"];
    
    smoke.velocity=250;
    smoke.velocityRange=100;
    smoke.emissionLongitude=M_PI * (10.0/10.0);
    smoke.emissionRange=M_PI / 20.0;
    
    _fireEmitter.emitterCells=[NSArray arrayWithObjects:smoke,fire,nil];
    [self.view.layer addSublayer:_fireEmitter];
    
}

@end
