//
//  AddFriend.m
//  Chuye
//
//  Created by Qinting on 16/8/20.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "AddFriend.h"
@implementation AddFriend
+(NSDictionary *)objectInArray{
    return @{@"data":[AddFriendData class]};
}
@end
@implementation AddFriendData
+(NSDictionary *)objectInArray{
    return @{
             @"Works":[AddFriendDataWorks class],
             @"User":[AddFriendDataUser class]
             };
}
@end


@implementation AddFriendDataUser

@end


@implementation AddFriendDataWorks
+(NSDictionary *)objectInArray{
    return @{@"User":[AddFriendDataWorksUser class]};
}
@end


@implementation AddFriendDataWorksUser

@end


