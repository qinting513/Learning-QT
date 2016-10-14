//
//  NSObject+Common.m
//  Honkib
//
//  Created by Jone' on 15/12/23.
//  Copyright © 2015年 Jone. All rights reserved.
//

#import "NSObject+Common.h"

#define ISLOCKOPEN @"islockopen" /**< 锁屏是否打开 0为关闭 1为指纹 2为手势 */


@implementation NSObject (Common)

//获取fileName的完整地址
+ (NSString* )pathInCacheDirectory:(NSString *)fileName
{
    NSArray *cachePaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [cachePaths objectAtIndex:0];
    return [cachePath stringByAppendingPathComponent:fileName];
}
//检测锁屏是否打开
+ (NSInteger)loadIsSreenLockOpened {
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    if (![userdefaults integerForKey:ISLOCKOPEN]) {
        [userdefaults setInteger:0 forKey:ISLOCKOPEN];
        [userdefaults synchronize];
        return 0;
    }else{
        return [userdefaults integerForKey:ISLOCKOPEN];
    }
}
//保存锁屏设置 /**<  0为关闭 1为指纹 2为手势 */
+ (void)saveScreeenLockWithStatus:(NSInteger)status {
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    [userdefaults setInteger:status forKey:ISLOCKOPEN];
    [userdefaults synchronize];
}
//取出当天手势错误次数
+ (NSInteger)loadGestureErrorTimes {
//    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
//    NSString *filePath = [self pathInCacheDirectory:[NSString stringWithFormat:@"%@/GestureErrorTem.plist",[userdefaults objectForKey:@"userName"]]];
    NSString *filePath = [self pathInCacheDirectory:@"GestureErrorTem.plist"];
    NSLog(@"filePath = %@",filePath);
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSString *strd = [self gettingStringWithToday];
    NSMutableDictionary *dic;
    if (![fileManager fileExistsAtPath:filePath]) {
         dic = @{@"time":strd,@"errorTime":@"0"}.mutableCopy;
        [dic writeToFile:filePath atomically:YES];
        return 0;
    }else{
        dic = [NSMutableDictionary dictionaryWithContentsOfFile:filePath];
        if ([strd isEqualToString:dic[@"time"]]) {
            return [[dic objectForKey:@"errorTime"] integerValue];
        }else{
            return 0;
        }
    }
}
//保存手势错误次数，按天来算
+ (void)saveGestureErrorTimesWithNum:(NSInteger)num {
//    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
//    NSString *filePath = [self pathInCacheDirectory:[NSString stringWithFormat:@"%@/GestureErrorTem.plist",[userdefaults objectForKey:@"userName"]]];
    NSString *filePath = [self pathInCacheDirectory:@"GestureErrorTem.plist"];
    NSLog(@"filePath = %@",filePath);
    NSString *strd = [self gettingStringWithToday];
    NSMutableDictionary *dic;
    dic = @{@"time":strd,@"errorTime":[NSString stringWithFormat:@"%ld",num]}.mutableCopy;
    [dic writeToFile:filePath atomically:YES];
   
}

+ (NSString *)gettingStringWithToday {
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
    NSString *strd = [dateFormatter stringFromDate:date];
    return strd;
}



@end
