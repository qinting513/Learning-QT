//
//  JCWeatherAnimation.m
//  图灵机器人
//
//  Created by Guo.JC on 16/9/1.
//  Copyright © 2016年 Guo.JC. All rights reserved.
//

#import "JCWeatherAnimation.h"

@implementation JCWeatherAnimation

//static CAEmitterLayer * _weatherBGEmitter;//发射器对象


+(void)creatRainForLayer:(CALayer *)layer
{
    CAEmitterLayer * _weatherBGEmitter;//发射器对象
    //设置发射器
    _weatherBGEmitter=[[CAEmitterLayer alloc]init];
    _weatherBGEmitter.emitterPosition=CGPointMake(SCREEN_WIDTH * .5,0);//发射器在xy平面的中心位置
    _weatherBGEmitter.emitterSize=CGSizeMake(SCREEN_WIDTH, 1);//发射器在Z平面的中心位置
    _weatherBGEmitter.emitterShape = @"line";
    _weatherBGEmitter.emitterMode = kCAEmitterLayerOutline;
    _weatherBGEmitter.renderMode = kCAEmitterLayerOldestFirst;//渲染模式
    _weatherBGEmitter.preservesDepth = NO;
    //发射单元
    //雨点
    CAEmitterCell * rain = [CAEmitterCell emitterCell];
    rain.birthRate = 100; //粒子创建速率
    rain.lifetime = 2.0; //粒子存活时间
    rain.lifetimeRange = 1.5;//生存时间容差
    rain.color=[[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:.15]CGColor];
    rain.contents=(id)[[UIImage imageNamed:@"sunny_night_shooting_start"]CGImage];
    [rain setName:@"rain"];
    
    rain.velocity=500; //运动速度
    rain.velocityRange=400;//粒子速度的容差
    rain.emissionLongitude=M_PI * (10.0/10.0);//粒子在xy平面的发射角度
    //    fire.emissionLatitude = 0;//粒子在Z轴方向的发射角度
    rain.emissionRange=M_PI / 20.0;//粒子发射角度的容差
    //
    rain.xAcceleration = 10;//X方向加速度
    rain.yAcceleration = 10;//Y方向加速度
    rain.zAcceleration = 10;//Z方向加速度
    
    rain.scaleSpeed=0.3;
    rain.spin=0.2;//旋转角度
    
    _weatherBGEmitter.emitterCells=[NSArray arrayWithObjects:rain,nil];
    [layer addSublayer:_weatherBGEmitter];
}

#pragma mark 创建下雪动画
+(void)creatSnowForLayer:(CALayer *)layer{
    CAEmitterLayer * _weatherBGEmitter;//发射器对象
    //设置发射器
    _weatherBGEmitter=[[CAEmitterLayer alloc]init];
    _weatherBGEmitter.emitterPosition=CGPointMake(SCREEN_WIDTH * .5,0);//发射器在xy平面的中心位置
    _weatherBGEmitter.emitterSize=CGSizeMake(SCREEN_WIDTH, 1);//发射器在Z平面的中心位置
    _weatherBGEmitter.emitterShape = @"line";
    _weatherBGEmitter.emitterMode = kCAEmitterLayerOutline;
    _weatherBGEmitter.renderMode = kCAEmitterLayerOldestFirst;//渲染模式
    _weatherBGEmitter.preservesDepth = NO;
    
    //发射单元
    //雪花
    CAEmitterCell * snow = [CAEmitterCell emitterCell];
    snow.birthRate = 50; //粒子创建速率
    snow.lifetime = 8.0; //粒子存活时间
    snow.lifetimeRange = 5.0;//生存时间容差
    snow.color=[[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:.4]CGColor];
    snow.contents=(id)[[UIImage imageNamed:@"sunny_night_star_l"]CGImage];
    [snow setName:@"snow"];
    
    snow.velocity=50; //运动速度
    snow.velocityRange=400;//粒子速度的容差
    snow.emissionLongitude=M_PI * (10.0/10.0);//粒子在xy平面的发射角度
    //    fire.emissionLatitude = 0;//粒子在Z轴方向的发射角度
    snow.emissionRange=M_PI / 20.0;//粒子发射角度的容差
    //
    snow.xAcceleration = 10;//X方向加速度
    snow.yAcceleration = 10;//Y方向加速度
    snow.zAcceleration = 10;//Z方向加速度
    
    snow.scaleSpeed=0.3;
    snow.spin=1.0;//旋转角度
    
    _weatherBGEmitter.emitterCells=[NSArray arrayWithObjects:snow,nil];
    [layer addSublayer:_weatherBGEmitter];

}

#pragma mark 创建晴天动画
+(void)creatSunnyForLayer:(CALayer *)layer{

}

#pragma mark 创建阴天动画
+(void)creatCloudForLayer:(CALayer *)layer{//sunny_day_cloud3
    CAEmitterLayer * _weatherBGEmitter;//发射器对象
    //设置发射器
    _weatherBGEmitter=[[CAEmitterLayer alloc]init];
    _weatherBGEmitter.emitterPosition=CGPointMake(-30,-30);//发射器在xy平面的中心位置
    _weatherBGEmitter.emitterSize=CGSizeMake(1, SCREEN_HEIGHT*.5);//发射器在Z平面的中心位置
    _weatherBGEmitter.emitterShape = @"line";
    _weatherBGEmitter.emitterMode = kCAEmitterLayerOutline;
    _weatherBGEmitter.renderMode = kCAEmitterLayerOldestFirst;//渲染模式
    _weatherBGEmitter.preservesDepth = NO;
    
    //发射单元
    //云雾
    CAEmitterCell * cloud = [CAEmitterCell emitterCell];
    cloud.birthRate = 10; //粒子创建速率
    cloud.lifetime = 8.0; //粒子存活时间
    cloud.lifetimeRange = 8.0;//生存时间容差
    cloud.color=[[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1]CGColor];
    cloud.contents=(id)[[UIImage imageNamed:@"sunny_day_cloud3"]CGImage];
    [cloud setName:@"cloud"];
    
    cloud.velocity=50; //运动速度
    cloud.velocityRange=400;//粒子速度的容差
    cloud.emissionLongitude=M_PI * (5.0/10.0);//粒子在xy平面的发射角度
    //    fire.emissionLatitude = 0;//粒子在Z轴方向的发射角度
    cloud.emissionRange=M_PI / 10.0;//粒子发射角度的容差
    //
    cloud.xAcceleration = 10;//X方向加速度
    cloud.yAcceleration = 10;//Y方向加速度
    cloud.zAcceleration = 10;//Z方向加速度
    
    cloud.scaleSpeed=0.5;
//    cloud.spin=1.0;//旋转角度
    
    _weatherBGEmitter.emitterCells=[NSArray arrayWithObjects:cloud,nil];
    [layer addSublayer:_weatherBGEmitter];
}

#pragma mark 创建雷雨动画
+(void)creatEletranicForLayer:(CALayer *)layer{

}
@end
