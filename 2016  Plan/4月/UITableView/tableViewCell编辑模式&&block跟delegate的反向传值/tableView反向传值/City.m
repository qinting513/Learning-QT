//
//  City.m
//  City_TableView
//
//  Created by tarena01 on 15/11/16.
//  Copyright (c) 2015年 tarena01. All rights reserved.
//

#import "City.h"

@implementation City

-(id)initWithDictionary:(NSDictionary*)dict{
    self = [super init];
    if(self){
//        self.cityName = dict[@"cityName"];
//        self.population = [dict[@"population"] integerValue];
        
        [self setValuesForKeysWithDictionary:dict];
    }
    return  self;
}

+(id)cityWithDictionary:(NSDictionary*)dict
{

    return [[self alloc]initWithDictionary:dict];
}

@end
