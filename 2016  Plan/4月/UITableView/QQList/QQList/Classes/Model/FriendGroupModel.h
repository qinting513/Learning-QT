//
//  FriendGroupModel.h
//  QQList
//
//  Created by Qinting on 16/4/22.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FriendGroupModel : NSObject

/**
 *  分组名称
 */
@property (nonatomic,copy) NSString *name;
/**
 *  在线的
 */
@property (nonatomic,assign) int online;

//记录展开还是合并 默认NO  合并
@property (nonatomic,assign,getter=isExpend) BOOL expend;

@property (nonatomic,strong) NSArray *friends;

- (instancetype)initWithDic:(NSDictionary *)dic;
+ (instancetype)friendGroupWithDic:(NSDictionary *)dic;

+ (NSArray *)getFriendGroupsList;

@end
