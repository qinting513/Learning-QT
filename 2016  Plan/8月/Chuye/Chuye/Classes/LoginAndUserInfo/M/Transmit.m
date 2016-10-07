//
//  Transmit.m
//  Chuye
//
//  Created by Qinting on 16/8/19.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "Transmit.h"


@implementation Transmit
+(NSDictionary *)objectInArray{
    return @{@"data":[TransmitData class]};
}
@end
@implementation TransmitData
+(NSDictionary *)objectInArray{
    return @{@"User":[TransmitDataUser class]};
}
@end


@implementation TransmitDataUser

@end


