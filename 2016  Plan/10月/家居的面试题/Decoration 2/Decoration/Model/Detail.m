//
//  Detail.m
//  Decoration
//
//  Created by tarena on 16/10/20.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "Detail.h"
#import "NSObject+Parse.h"

@implementation Detail
+(NSDictionary *)objectInArray{
    return @{@"progress":[DetailProgress class],
             @"team":[DetailTeam class]
             };
}
@end
@implementation DetailTeam

@end


@implementation DetailProgress
+(NSDictionary *)objectInArray{
    return @{@"steps":[DetailProgressSteps class]};
}
@end


@implementation DetailProgressSteps

@end


