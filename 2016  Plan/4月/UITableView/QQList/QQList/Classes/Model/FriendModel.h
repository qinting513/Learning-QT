//
//  FriendModel.h
//  QQList
//
//  Created by Qinting on 16/4/22.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FriendModel : NSObject

/**
 *  头像
 */
@property (nonatomic,copy) NSString *icon;
/**
 *  个性签名
 */
@property (nonatomic,copy) NSString *intro;
/**
 *  好友名称
 */
@property (nonatomic,copy) NSString *name;
/**
 *  是否是会员
 */
@property (nonatomic,assign,getter=isVip) BOOL vip;

- (instancetype)initWithDic:(NSDictionary *)dic;
+ (instancetype)friendWithDic:(NSDictionary *)dic;

@end
