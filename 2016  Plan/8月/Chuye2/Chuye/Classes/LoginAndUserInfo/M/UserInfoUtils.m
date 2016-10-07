//
//  UserInfoUtils.m
//  Chuye
//
//  Created by Qinting on 16/8/19.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "UserInfoUtils.h"
#import "UserModel.h"
@implementation UserInfoUtils

+(id)parseTxtWithName:(NSString *)txt className:(NSString *)name{
    NSString *path = [[NSBundle mainBundle]pathForResource:txt ofType:@"txt"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *dishesDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    Class class = NSClassFromString(name);
    return [class parse:dishesDic];
}


+(id)parseUserModel{
    return [self parseTxtWithName:@"UserInfo" className:@"UserModel"];
}

+(id)parseFavorites
{
    return [self parseTxtWithName:@"Favorites" className:@"Favorites"];
}

+(id)parseTransmit{
    return [self parseTxtWithName:@"Transmit" className:@"Transmit"];
}



@end
