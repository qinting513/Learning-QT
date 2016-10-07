//
//  OverrideNSLog.h
//  AA
//
//  Created by Qinting on 16/4/8.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#ifndef OverrideNSLog_h
#define OverrideNSLog_h

#endif

// 把此文件import “OverrideNSLog.h” 到 PCH 里即可覆盖了原来的NSLog
//如果是在debug阶段，打印NSLog 否则在上线阶段 则为空了
#ifdef DEBUG

/**  关于NSLog的输出 的 改造，用法不变   */
#define  NSLog(format,...)  do{ \
fprintf(stderr," <在%s : %d行>   方法名%s\n",\
[ [ [NSString stringWithUTF8String:__FILE__] lastPathComponent] \
UTF8String], \
__LINE__,__func__); \
(NSLog)((format),##__VA_ARGS__);\
fprintf(stderr,"-------------------------------------------------------------\n"); \
}while (0)

#else

#define NSLog(format,...)

#endif



