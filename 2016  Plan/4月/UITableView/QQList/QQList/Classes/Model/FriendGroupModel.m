//
//  FriendGroupModel.m
//  QQList
//
//  Created by Qinting on 16/4/22.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "FriendGroupModel.h"
#import "FriendModel.h"

@implementation FriendGroupModel

- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

+ (instancetype)friendGroupWithDic:(NSDictionary *)dic
{
    return [[self alloc] initWithDic:dic];
}

+ (NSArray *)getFriendGroupsList
{
        //加载plist
        NSString *path = [[NSBundle mainBundle] pathForResource:@"friends" ofType:@"plist"];
        NSArray *dicArray = [NSArray arrayWithContentsOfFile:path];
        
        //字典转模型
        NSMutableArray *tmpArray = [NSMutableArray array];
        for (NSDictionary *dic in dicArray) {
            FriendGroupModel *friendGroup = [FriendGroupModel friendGroupWithDic:dic];
            //字典转模型
            NSMutableArray *tmpFriendsArray = [NSMutableArray array];
            for (NSDictionary *friendDic in friendGroup.friends) {
                FriendModel *friend = [FriendModel friendWithDic:friendDic];
                [tmpFriendsArray addObject:friend];
            }
            friendGroup.friends = tmpFriendsArray;
            
            [tmpArray addObject:friendGroup];
        }
        return [tmpArray mutableCopy];
    }

@end
