//
//  UserInfo.m
//  Chuye
//
//  Created by Qinting on 16/8/19.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "UserInfo.h"


@implementation UserInfo
singleton_implementation(UserInfo);

/**  从沙盒获取用户数据 */
+(id)loadUserInfoFromSandBoxWithName:(NSString *)name{
NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if(name.length == 0) return nil;
  return  [defaults objectForKey:name];
}

/**  bao存用户数据 */
+(void)saveToSandBoxWithUserInfo:(NSDictionary *)info andUserName:(NSString *)key{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:info forKey:key];
        [defaults synchronize];
}

+(void)saveLastLoginUser:(NSString *)userName{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:userName forKey:kLastLoginUser];
    [defaults synchronize];
}

+(id)loadlastLogin{
   NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:kLastLoginUser];
}

@end
