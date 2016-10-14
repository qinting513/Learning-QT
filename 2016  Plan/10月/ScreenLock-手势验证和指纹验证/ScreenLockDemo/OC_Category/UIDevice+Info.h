//
//  UIDevice+Info.h
//  LockScreenDemo
//
//  Created by Jone' on 15/12/30.
//  Copyright © 2015年 Jone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (Info)

+ (double)availableMemory; /**< 本应可用内存 */

+ (double)usedMemory; /**< 本应用已用内存 */

+ (NSString *)doDevicePlatform; /**< 设备型号 */

+ (float)deviceTotalMemory; /**< 设备总存储空间 */

+ (float)deviceFreeMemory; /**< 设备可用存储空间 */

@end
