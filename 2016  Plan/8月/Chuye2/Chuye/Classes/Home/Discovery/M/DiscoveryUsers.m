//
//  DiscoveryUsers.m
//  Chuye
//
//  Created by Qinting on 16/8/18.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "DiscoveryUsers.h"

@implementation DiscoveryUsers
+(NSDictionary *)objectInArray{
    return @{@"data":[DiscoveryUsersData class]};
}
@end
@implementation DiscoveryUsersData
+(NSDictionary *)objectInArray{
    return @{
             @"Works":[DiscoveryUsersDataWorks class],
             @"User":[DiscoveryUsersDataMasterUser class]
             };
}
@end


@implementation DiscoveryUsersDataMasterUser

@end


@implementation DiscoveryUsersDataWorks
+(NSDictionary *)objectInArray{
    return @{@"User":[DiscoveryUsersDataWorksUser class]};
}
@end


@implementation DiscoveryUsersDataWorksUser

@end


