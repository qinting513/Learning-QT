//
//  UIView+HUD.m
//  QTGameLive
//
//  Created by Qinting on 16/4/17.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "UIView+HUD.h"

/** 考虑到要把文本文件可能分享给别人，所以把必要的引用给写了 */
#import <MBProgressHUD.h>

#define kTimeOutDuration 1.5
#define kWarningDuration 30

@implementation UIView (HUD)
/*
 程序线程原则:所有用户可见的操作必须放置在主线程中执行
 用户不可见的可以放在子线程中执行,来提升程序流畅性.
 */

- (void)showHWarning:(NSString*)words{
    
    //为了防止调用此方法的线程是子线程,导致项目崩溃, 所以强制让下方代码在主线程中执行
    dispatch_async(dispatch_get_main_queue(), ^{
        
        /** 为了避免重复提示的重合现象 */
        [MBProgressHUD hideAllHUDsForView:self animated:YES];
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = words;
        [hud hide:YES afterDelay:kTimeOutDuration];
    });
}

/** 显示繁忙 */
- (void)showBusyHUD{
dispatch_async(dispatch_get_main_queue(), ^{
    [MBProgressHUD hideAllHUDsForView:self animated:YES];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    [hud hide:YES afterDelay:30];
});

}

/** 隐藏繁忙 */
- (void)hiddenBusyHUD{
dispatch_async(dispatch_get_main_queue(), ^{
    [MBProgressHUD hideAllHUDsForView:self animated:YES];
});

}

@end
