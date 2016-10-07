//
//  UIView+HUD.h
//  QTGameLive
//
//  Created by Qinting on 16/4/17.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIView (HUD)
/** 封装hud */
- (void)showHWarning:(NSString*)words;

/** 显示繁忙 */
- (void)showBusyHUD;

/** 隐藏繁忙 */
- (void)hiddenBusyHUD;
@end
