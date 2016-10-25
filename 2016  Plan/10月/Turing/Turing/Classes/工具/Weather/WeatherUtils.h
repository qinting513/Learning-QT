//
//  Utils.h
//  天气预报
//
//  Created by tarena22 on 16/8/31.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^MyCallback)(id obj);
@interface WeatherUtils : NSObject
+ (void)requestCitysWithCallback:(MyCallback)callback;

+(void)requestCityWeatherWithCityName:(NSString*)cityName andCallback:(MyCallback)callback;
@end
