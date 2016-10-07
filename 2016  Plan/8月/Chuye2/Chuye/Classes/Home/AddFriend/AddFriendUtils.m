//
//  AddFriendUtils.m
//  Chuye
//
//  Created by Qinting on 16/8/20.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "AddFriendUtils.h"
#import "AddFriend.h"
@implementation AddFriendUtils
+(id)GETFriends:(NSString *)url  completionHandler:(void(^)(id mode,NSError *err))completionHandler{
    return  [self  GET:url parameters:nil progress:nil completionHandler:^(id model, NSError *error) {
        !completionHandler ?: completionHandler([AddFriend parse:model],error);
    }];
}
@end
