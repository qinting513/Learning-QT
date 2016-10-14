//
//  ZPDatabaseQueue.h
//  手势密码解锁
//
//  Created by ios on 15-12-4.
//  Copyright (c) 2015年 ios. All rights reserved.
//

#import "FMDB.h"
@interface fmdbQueueTool : NSObject
+ (instancetype)sharedDatabaseQueue;

//保存密码
- (void)insertPassword:(NSString *)str;

//删除上次密码数据
- (void)deletelastPassword;

//取出最新密码数据
- (NSString *)querylastPassword;
@end
