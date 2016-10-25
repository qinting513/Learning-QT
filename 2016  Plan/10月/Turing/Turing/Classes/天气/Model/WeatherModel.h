//
//  Weather.h
//  天气预报
//
//  Created by tarena22 on 16/9/1.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeatherModel : NSObject
@property(nonatomic,copy)NSString* temp;
@property(nonatomic,copy)NSString * wind_direction;
@property(nonatomic,copy)NSString* wind_strength;
@property(nonatomic,copy)NSString* humidity;
@property(nonatomic,copy)NSString* time;
@property(nonatomic,copy)NSString* city;
@property(nonatomic,copy)NSString* date_y;
@property(nonatomic,copy)NSString* week;
@property(nonatomic,copy)NSString* temperature;
@property(nonatomic,copy)NSString* weather;
@end
