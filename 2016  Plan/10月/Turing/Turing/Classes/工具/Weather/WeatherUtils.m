//
//  Utils.m
//  天气预报
//
//  Created by tarena22 on 16/8/31.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "WeatherUtils.h"
#import "CityModel.h"
#import "AFNetworking.h"
#import "WeatherModel.h"
@implementation WeatherUtils
+(void)requestCitysWithCallback:(MyCallback)callback{
    
    NSString *path = @"http://v.juhe.cn/weather/citys";
    NSDictionary *paramsDic = @{@"key":@"8043916b0a9f8f79254556ce9d28610b"};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
    
    [manager GET:path parameters:paramsDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        NSArray *cityArr = dic[@"result"];
        //创建字典分组保存城市信息
        NSMutableArray* cities = [NSMutableArray array];
        
         for (NSDictionary *cityDic in cityArr) {
            
             CityModel* city = [[CityModel alloc]init];
             city.city_id = cityDic[@"id"];
            city.province = cityDic[@"province"];
              city.city = cityDic[@"city"];
              city.district = cityDic[@"district"];
             [cities addObject:city];
            
        }
        callback(cities);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"城市列表失败");
    }];
    
}
+(void)requestCityWeatherWithCityName:(NSString*)cityName andCallback:(MyCallback)callback
{
    NSString *path = @"http://v.juhe.cn/weather/index";
    
    
    if (!cityName) {
        cityName = @"深圳";
    }
    
    NSDictionary *paramsDic = @{@"key":@"8043916b0a9f8f79254556ce9d28610b",@"cityname":cityName};
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
    
    [manager GET:path parameters:paramsDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        NSDictionary *weaDic = dic[@"result"];
        WeatherModel* wea = [[WeatherModel alloc]init];
        wea.temp =weaDic[@"sk"][@"temp"];
        wea.wind_direction =weaDic[@"sk"][@"wind_direction"];
        wea.wind_strength =weaDic[@"sk"][@"wind_strength"];
        wea.humidity =weaDic[@"sk"][@"humidity"];
        wea.time =weaDic[@"sk"][@"time"];
        wea.city =weaDic[@"today"][@"city"];
         wea.date_y =weaDic[@"today"][@"date_y"];
         wea.week =weaDic[@"today"][@"week"];
         wea.weather =weaDic[@"today"][@"weather"];
         wea.temperature =weaDic[@"today"][@"temperature"];
        
        
        callback(wea);
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"城市列表失败");
    }];
}
@end
