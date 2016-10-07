//
//  Provinces.m
//  tableView
//
//  Created by tarena19 on 2015/10/23.
//  Copyright (c) 2015年 tarena19. All rights reserved.
//

#import "Provinces.h"

@implementation Provinces

-(id)initWithDictionary:(NSDictionary*)dict
{
    if (self=[super init])
    {
        self.header=dict[@"header"];
        self.footer=dict[@"footer"];
        self.cities=dict[@"cities"];
    }
    return self;
}
//
//+(id)provinceWithDictionary:(NSDictionary*)dict
//{
//    return [[self alloc]initWithDictionary:dict];
//}

+(id)provinceWithDictionary:(NSDictionary*)dict
{
    Provinces *p = [Provinces new];
        p.header=dict[@"header"];
        p.footer=dict[@"footer"];
        p.cities=dict[@"cities"];
    return p;
}

//+(id)provinceWithHeader:(NSString*)header footer:(NSString*)footer cities:(NSArray*)cities
//{
//    Provinces* province=[[Provinces alloc]init];
//    province.header=header;
//    province.footer=footer;
//    province.cities=cities;
//    return province;
//}

@end
