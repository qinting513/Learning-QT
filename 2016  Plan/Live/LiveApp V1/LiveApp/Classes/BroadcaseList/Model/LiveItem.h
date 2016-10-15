//
//  LiveItem.h
//  LiveApp
//
//  Created by Qinting on 2016/10/15.
//  Copyright © 2016年 QT. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YZCreatorItem;
@interface LiveItem : NSObject
/** 直播流地址 */
@property (nonatomic, copy) NSString *stream_addr;
/** 关注人 */
@property (nonatomic, assign) NSUInteger online_users;
/** 城市 */
@property (nonatomic, copy) NSString *city;

/** 主播信息 */
@property (nonatomic,strong) YZCreatorItem  *creator;

@end

@interface YZCreatorItem : NSObject

/** 主播名 */
@property (nonatomic, strong) NSString *nick;
/** 主播头像 */
@property (nonatomic, strong) NSString *portrait;

@end
