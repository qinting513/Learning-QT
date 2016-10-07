//
//  Constant.h
//  QTGameLive
//
//  Created by Qinting on 16/4/16.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#ifndef Constant_h
#define Constant_h

#define kAppDelegate ((AppDelegate*)([UIApplication sharedApplication].delegate))

/** 宏中参数 不要跟代码中的变量重名，比如 A，如果我定义成alpha,则跟变量alpha*/
#define kRGBA(R,G,B,A) [UIColor colorWithRed:(R)/255.0 green:(G)/255.0 blue:(B)/255.0 alpha:A];

#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height

#endif /* Constant_h */
