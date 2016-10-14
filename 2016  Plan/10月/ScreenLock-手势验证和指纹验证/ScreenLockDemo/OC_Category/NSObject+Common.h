//
//  NSObject+Common.h
//  Honkib
//
//  Created by Jone' on 15/12/23.
//  Copyright © 2015年 Jone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Common)

+ (NSInteger)loadIsSreenLockOpened;
+ (void)saveScreeenLockWithStatus:(NSInteger)status;/**<  0为关闭 1为指纹 2为手势 */
+ (NSInteger)loadGestureErrorTimes;
+ (void)saveGestureErrorTimesWithNum:(NSInteger)num;


@end
