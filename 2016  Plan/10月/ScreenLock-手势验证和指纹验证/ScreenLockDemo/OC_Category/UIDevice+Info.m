//
//  UIDevice+Info.m
//  LockScreenDemo
//
//  Created by Jone' on 15/12/30.
//  Copyright © 2015年 Jone. All rights reserved.
//

#import "UIDevice+Info.h"
#import <sys/sysctl.h>
#import <mach/mach.h>

@implementation UIDevice (Info)

// 获取当前设备可用内存(单位：MB）
+ (double)availableMemory

{
    
    vm_statistics_data_t vmStats;
    
    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
    
    kern_return_t kernReturn = host_statistics(mach_host_self(),
                                               
                                               HOST_VM_INFO,
                                               
                                               (host_info_t)&vmStats,
                                               
                                               &infoCount);
    
    
    
    if (kernReturn != KERN_SUCCESS) {
        
        return NSNotFound;
        
    }
    
    return ((vm_page_size *vmStats.free_count) / 1024.0) / 1024.0;
    
}


// 获取当前应用所占用的内存（单位：MB）

+ (double)usedMemory

{
    
    task_basic_info_data_t taskInfo;
    
    mach_msg_type_number_t infoCount = TASK_BASIC_INFO_COUNT;
    
    kern_return_t kernReturn = task_info(mach_task_self(),
                                         
                                         TASK_BASIC_INFO,
                                         
                                         (task_info_t)&taskInfo,
                                         
                                         &infoCount);
    
    
    if (kernReturn != KERN_SUCCESS
        
        ) {
        
        return NSNotFound;
        
    }
    
    return taskInfo.resident_size / 1024.0 / 1024.0;
    
}
//设备型号
+ (NSString*) doDevicePlatform
{
    size_t size;
    int nR = sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = (char *)malloc(size);
    nR = sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    free(machine);
     NSLog(@"%@",platform);
    if ([platform isEqualToString:@"x86_64"]){
        /**< Simulator */
        return @"iPhone Simulator";
    }
    /**< iPhone */
    if ([platform isEqualToString:@"iPhone4,1"])
    {
        return @"iPhone4s";
    }else if ([platform isEqualToString:@"iPhone5,1"]||[platform isEqualToString:@"iPhone5,2"])
    {
        return @"iPhone5";
    }else if ([platform isEqualToString:@"iPhone5,3"]||[platform isEqualToString:@"iPhone5,4"])
    {
        return @"iPhone5c";
    }else if ([platform isEqualToString:@"iPhone6,1"]||[platform isEqualToString:@"iPhone6,2"])
    {
        return @"iPhone5s";
    }else if ([platform isEqualToString:@"iPhone7,1"])
    {
        return @"iPhone6 Plus";
    }else if ([platform isEqualToString:@"iPhone7,2"])
    {
        return @"iPhone6";
    }else if ([platform isEqualToString:@"iPhone8,1"])
    {
        return @"iPhone6s";
    }else if ([platform isEqualToString:@"iPhone8,2"])
    {
        return @"iPhone6s Plus";
    }else if ([platform hasPrefix:@"iPhone"]){
        return @"iPhone";
    }
    /**< iPad */
    if ([platform isEqualToString:@"iPad4,1"]||[platform isEqualToString:@"iPad4,2"])
    {
        return @"iPad Air";
    }else if ([platform isEqualToString:@"iPad5,3"]||[platform isEqualToString:@"iPad5,4"])
    {
        return @"iPad Air 2";
    }else if ([platform isEqualToString:@"iPad2,5"]||[platform isEqualToString:@"iPad2,6"]||[platform isEqualToString:@"iPad2,7"])
    {
        return @"iPad mini 1G";
    }else if ([platform isEqualToString:@"iPad4,4"]||[platform isEqualToString:@"iPad4,5"]||[platform isEqualToString:@"iPad4,6"])
    {
        return @"iPad mini 2G";
    }else if ([platform isEqualToString:@"iPad4,7"]||[platform isEqualToString:@"iPad4,8"]||[platform isEqualToString:@"iPad4,9"])
    {
        return @"iPad mini 3G";
    }else if ([platform isEqualToString:@"iPad5,1"]||[platform isEqualToString:@"iPad5,2"])
    {
        return @"iPad mini 4G";
    }else if ([platform isEqualToString:@"iPad6,7"]||[platform isEqualToString:@"iPad6,8"])
    {
        return @"iPad Pro 1G";
    }else if ([platform hasPrefix:@"iPad"])
    {
        return @"iPad";
    }
    else{/**< iPod tuoch */
          return @"iPod touch";
    }
    
}
//设备总空间 单位：GB
+ (float)deviceTotalMemory{
    NSDictionary *fattributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    
    return (([[fattributes objectForKey:NSFileSystemSize] longLongValue]/1024.0)/1024.0)/1024.0;
    
}
// 设备剩余空间 单位：GB
+ (float)deviceFreeMemory {
    NSDictionary *fattributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    
    return (([[fattributes objectForKey:NSFileSystemFreeSize] longLongValue]/1024.0)/1024.0)/1024.0;
}


@end
