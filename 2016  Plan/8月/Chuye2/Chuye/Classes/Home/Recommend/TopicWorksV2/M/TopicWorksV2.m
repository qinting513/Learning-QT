//
//  TopicWorksV2.m
//  Chuye
//
//  Created by Qinting on 16/8/21.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "TopicWorksV2.h"

@implementation TopicWorksV2
+(NSDictionary *)objectInArray{
    return @{
             @"data":[TopicWorksV2Data class]
             };
}

//解析数据
+(id)parseTopicWorksV2{
    NSString *path = [[NSBundle mainBundle ]pathForResource:@"TopicWorksV2.txt" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:path];
  id model =  [NSJSONSerialization JSONObjectWithData:data options:0 error:0];
  return  [TopicWorksV2 parse:model];
}

@end


@implementation TopicWorksV2Data
+(NSDictionary *)objectInArray{
    return @{ @"list":[TopicWorksV2DataList class]};
}
@end


@implementation TopicWorksV2DataList
+(NSDictionary *)objectInArray
{
    return @{@"User": [TopicWorksV2DataListUser class]};
}
@end


@implementation TopicWorksV2DataListUser

@end


