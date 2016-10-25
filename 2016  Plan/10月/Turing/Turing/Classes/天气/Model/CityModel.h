//
//  City.h
//  天气预报
//
//  Created by tarena22 on 16/8/31.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityModel : NSObject
@property(nonatomic,copy)NSString *city_id;
@property(nonatomic,copy)NSString *province;
@property(nonatomic,copy)NSString *city;
@property(nonatomic,copy)NSString *district;

@end
