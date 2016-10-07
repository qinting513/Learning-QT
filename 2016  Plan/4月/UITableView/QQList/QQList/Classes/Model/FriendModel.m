//
//  FriendModel.m
//  QQList
//
//  Created by Qinting on 16/4/22.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "FriendModel.h"

@implementation FriendModel

-  (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}


+  (instancetype)friendWithDic:(NSDictionary *)dic
{
    return [[self alloc] initWithDic:dic];
}

@end
