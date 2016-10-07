//
//  Topics.m
//  Chuye
//
//  Created by Qinting on 16/8/17.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "Works.h"

@implementation Works
+(NSDictionary *)objectInArray{
    return @{@"data":[WorksData class]};
}
@end
@implementation WorksData
+(NSDictionary *)objectInArray{
    return @{@"User":[WorksDataUser class]};
}
@end


@implementation WorksDataUser

@end


