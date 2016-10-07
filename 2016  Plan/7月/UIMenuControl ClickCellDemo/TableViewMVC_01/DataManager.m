//
//  DataManager.m
//  TableViewMVC_01
//
//  Created by Qinting on 16/7/12.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "DataManager.h"
#import "Provinces.h"

@interface DataManager()
@end

@implementation DataManager
+(NSArray *)loadData
{
    //1.init data
    //获得路径
    NSString* path= [[NSBundle mainBundle] pathForResource:@"province.plist" ofType:nil];
    NSArray* array =[NSArray arrayWithContentsOfFile:path];
    
    NSMutableArray *allProvinces =[NSMutableArray array];
    
    /** 字典转模型   这一步很重要 一定要理解 */
    for (NSDictionary* dict in array)
    {
        Provinces *p=  [Provinces provinceWithDictionary:dict];
        [allProvinces addObject:p];
    }
    
    return  allProvinces;
}
@end
