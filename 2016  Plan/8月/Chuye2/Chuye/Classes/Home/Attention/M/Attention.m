//
//  Attention.m
//  Chuye
//
//  Created by Qinting on 16/8/22.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "Attention.h"

@implementation Attention
+(NSDictionary *)objectInArray{
    return @{@"data":[AttentionData class]};
}

+(id)parseAttention{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Attention" ofType:@"txt"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    id model =  [NSJSONSerialization JSONObjectWithData:data options:0 error:0];
    return [Attention parse:model];
}

@end
@implementation AttentionData
+(NSDictionary *)objectInArray{
    return @{
              @"Total":[AttentionDataTotal class],
              @"Likes":[AttentionDataLikes class],
              @"User":[AttentionDataUser class],
              @"Comments":[AttentionDataComments class],
              @"ForwardUser":[AttentionDataForwardUser class]
              };
}
@end


@implementation AttentionDataTotal

@end


@implementation AttentionDataUser

@end


@implementation AttentionDataLikes
+(NSDictionary *)objectInArray{
    return @{ @"User":[AttentionDataUser class]};
}
@end

@implementation AttentionDataComments
+(NSDictionary *)objectInArray{
    return @{@"User":[AttentionDataUser class]};
}
@end

@implementation AttentionDataForwardUser

@end

