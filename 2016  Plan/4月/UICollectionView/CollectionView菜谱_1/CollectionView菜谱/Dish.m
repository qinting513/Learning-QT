//
//  Dish.m
//  菜谱大全
//
//  Created by tarena on 16/4/12.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "Dish.h"

@implementation Dish
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.steps = [NSMutableArray array];
    }
    return self;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{

}

@end
