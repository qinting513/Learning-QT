//
//  DataUtils.m
//  菜谱大全
//
//  Created by tarena on 16/4/12.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "DataUtils.h"
#import "Dish.h"

@implementation DataUtils
+(NSArray *)paseDishes{
    NSMutableArray *dishes = [NSMutableArray array];
    NSString *path = [[NSBundle mainBundle]pathForResource:@"Dishes" ofType:@"txt"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    NSDictionary *dishesDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    NSDictionary *resultDic = dishesDic[@"result"];
    NSArray *dishesArr = resultDic[@"data"];
    for (NSDictionary *dishDic in dishesArr) {
        
        
        Dish *d = [[Dish alloc]init];
        
        d.title = dishDic[@"title"];
        NSString *burdenString = dishDic[@"burden"];
        
        d.burden = [burdenString componentsSeparatedByString:@";"];
        d.imtro = dishDic[@"imtro"];
        d.ingredients = dishDic[@"ingredients"];
        d.albums = dishDic[@"albums"][0];
    
        [dishes addObject:d];
    }
    
    return dishes;
}
@end
