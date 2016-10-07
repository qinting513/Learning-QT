//
//  UserModel.m
//  Chuye
//
//  Created by Qinting on 16/8/19.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "UserModel.h"


@implementation UserModel
+(NSDictionary *)objectInArray{
    return @{ @"data":[UserModelData class]};
}
@end

@implementation UserModelData
+(NSDictionary *)objectInArray{
    return @{@"Works":[UserModelDataWorks class]};

}
@end


@implementation UserModelDataWorks
+(NSDictionary *)objectInArray{
    return @{@"User":[UserModelDataWorksUser class]};
}
@end


@implementation UserModelDataWorksUser

@end


