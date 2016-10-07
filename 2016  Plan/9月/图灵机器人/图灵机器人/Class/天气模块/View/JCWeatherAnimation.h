//
//  JCWeatherAnimation.h
//  图灵机器人
//
//  Created by Guo.JC on 16/9/1.
//  Copyright © 2016年 Guo.JC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JCWeatherAnimation : NSObject
#pragma mark 创建下雨动画
+(void)creatRainForLayer:(CALayer *)layer;

#pragma mark 创建下雪动画
+(void)creatSnowForLayer:(CALayer *)layer;

#pragma mark 创建晴天动画
+(void)creatSunnyForLayer:(CALayer *)layer;

#pragma mark 创建阴天动画
+(void)creatCloudForLayer:(CALayer *)layer;

#pragma mark 创建雷雨动画
+(void)creatEletranicForLayer:(CALayer *)layer;
@end
