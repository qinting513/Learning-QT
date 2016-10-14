//
//  ZPDatabaseQueue.m
//  手势密码解锁
//
//  Created by ios on 15-12-4.
//  Copyright (c) 2015年 ios. All rights reserved.
//


#import "ZPDatabaseQueue.h"


@implementation ZPDatabaseQueue
static ZPDatabaseQueue *_instance;


+ (void)initialize{
    

}

//单例方法
+ (instancetype)sharedDatabaseQueue{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        //设置sqlite数据库装载设置的密码
        NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]stringByAppendingPathComponent:@"passworddata.sqlite"];
        NSLog(@"%@",path);
          ZPDatabaseQueue *instance = (ZPDatabaseQueue *)[FMDatabaseQueue databaseQueueWithPath:path];
        
        [self inDatabase:^(FMDatabase *db) {
            if ([db open]) {
                NSLog(@"创建数据库成功");
                NSString *str = @"CREATE TABLE IF NOT EXISTS t_passworddata (id INTEGER PRIMARY KEY AUTOINCREMENT, password TEXT NOT NULL)";
                BOOL success = [db executeUpdate:str];
                if (success) {
                    NSLog(@"表创建成功!");
                }else{
                    NSLog(@"创建表失败!");
                }
                
            } else {
                NSLog(@"创建数据库失败");
            }
            
        }];

    });
    
    return _instance;
}

- (void)insertPassword:(NSString *)str{
        NSLog(@"%@",str);

//    NSString *str1 = [NSString stringWithFormat: @"INSERT INTO t_passworddata(password) VALUES('%@')",str];
//    [self inDatabase:^(FMDatabase *db) {
//       BOOL success = [db executeUpdate:str1];
//        if (success) {
//            NSLog(@"添加成功");
//        } else {
//            NSLog(@"添加失败");
//        }
//    }];
}
- (void)deletelastPassword{
    NSString *str = @"DELETE FROM t_passworddata ";
    [self inDatabase:^(FMDatabase *db) {
        BOOL success = [db executeUpdate:str];
        if (success) {
            NSLog(@"添加成功");
        } else {
            NSLog(@"添加失败");
        }
        
    }];
    
}
- (NSString *)querylastPassword{
    __block NSString *password = nil;
    
    NSString *strSql =  @"SELECT password FROM t_student WHERE id=(SELECT MAX(id) FROM t_passworddata)";
    [self inDatabase:^(FMDatabase *db) {
        //查询语句  执行的方法
        FMResultSet *set =  [db executeQuery:strSql];
        
        while ([set next]) {
            
            password = [set stringForColumn:@"password"];
            
            NSLog(@"password = %@ ",password);
        }
    }];
    return password;
}


@end
