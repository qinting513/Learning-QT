//
//  MasterUser.m
//  Chuye
//
//  Created by Qinting on 16/8/19.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "MasterUser.h"

@implementation MasterUser
+(NSDictionary *)objectInArray{
    return @{@"data":[MasterUserData class] };
}
@end
@implementation MasterUserData
+(NSDictionary *)objectInArray{
    return @{
             @"FromSelfAimOthers":[MasterUserDataFromselfaimothers class],
             @"ChuyeUser" : [MasterUserDataChuyeuser class],
             @"RelationStat" : [MasterUserDataRelationstat class]
             };

}
@end


@implementation MasterUserDataChuyeuser

@end


@implementation MasterUserDataFromselfaimothers

@end


@implementation MasterUserDataRelationstat

@end


