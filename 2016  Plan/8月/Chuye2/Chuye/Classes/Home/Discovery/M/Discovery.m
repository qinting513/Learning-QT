//
//  Discovery.m
//  Chuye
//
//  Created by Qinting on 16/8/18.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "Discovery.h"

//@class DiscoveryData,DiscoveryDataWorks,DiscoveryDataWorksUser;
@implementation Discovery
+(NSDictionary *)objectInArray{
    return @{@"data":[DiscoveryData class]};
}
@end
@implementation DiscoveryData
+(NSDictionary *)objectInArray{
    return @{@"works":[DiscoveryDataWorks class]};
}
@end


@implementation DiscoveryDataWorks
+(NSDictionary *)objectInArray{
    return @{@"User":[DiscoveryDataWorksUser class]};
}
@end


@implementation DiscoveryDataWorksUser

@end


