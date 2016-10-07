//
//  Weibo.m
//  WeiboDemo
//
//  Created by Qinting on 16/7/20.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "Weibo.h"

@implementation Weibo

-(id)initWithDict:(NSDictionary*)dict
{
    self = [super init];
    if (self ) {
        self.icon = dict[@"icon"];
        self.name = dict[@"name"];
        self.time = dict[@"time"];
        self.source = dict[@"source"];
        self.content = dict[@"content"];
        self.image = dict[@"image"];
    }
    return self;
}

+(id)weiboWithDict:(NSDictionary*)dict
{
    return  [[self alloc]initWithDict:dict];
}

@end
